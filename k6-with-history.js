import http from 'k6/http';
import { check, sleep } from 'k6';
import { Rate, Trend } from 'k6/metrics';

// 커스텀 메트릭 정의
const errorRate = new Rate('errors');
const requestDuration = new Trend('request_duration');

// 테스트 설정
export const options = {
  stages: [
    { duration: '1m', target: 5 },    // 1분간 5명의 사용자로 증가
    { duration: '2m', target: 5 },    // 2분간 5명 유지
    { duration: '1m', target: 20 },   // 1분간 20명으로 증가
    { duration: '2m', target: 20 },   // 2분간 20명 유지
    { duration: '1m', target: 50 },   // 1분간 50명으로 증가
    { duration: '2m', target: 50 },   // 2분간 50명 유지
    { duration: '1m', target: 0 },    // 1분간 0명으로 감소
  ],
  thresholds: {
    http_req_duration: ['p(95)<500'], // 95%의 요청이 500ms 이내
    http_req_failed: ['rate<0.1'],    // 실패율 10% 미만
    'errors': ['rate<0.1'],           // 커스텀 에러율
  },
};

// 기본 URL (스프링부트 서버)
const BASE_URL = 'http://localhost:8081';

export default function () {
  const startTime = new Date();
  
  // 1. 헬스 체크 (기본 트래픽)
  const healthResponse = http.get(`${BASE_URL}/actuator/health`);
  const healthSuccess = check(healthResponse, {
    'health check status is 200': (r) => r.status === 200,
    'health check response time < 200ms': (r) => r.timings.duration < 200,
  });
  errorRate.add(!healthSuccess);
  requestDuration.add(healthResponse.timings.duration);

  // 2. 메인 페이지 접근
  const mainResponse = http.get(`${BASE_URL}/`);
  const mainSuccess = check(mainResponse, {
    'main page status is 200': (r) => r.status === 200,
  });
  errorRate.add(!mainSuccess);
  requestDuration.add(mainResponse.timings.duration);

  // 3. 사용자 API 테스트
  const userResponse = http.get(`${BASE_URL}/api/users`);
  const userSuccess = check(userResponse, {
    'user API status is 200': (r) => r.status === 200,
  });
  errorRate.add(!userSuccess);
  requestDuration.add(userResponse.timings.duration);

  // 4. 게임 세션 API 테스트
  const gameResponse = http.get(`${BASE_URL}/api/game-sessions`);
  const gameSuccess = check(gameResponse, {
    'game session API status is 200': (r) => r.status === 200,
  });
  errorRate.add(!gameSuccess);
  requestDuration.add(gameResponse.timings.duration);

  // 5. 트래픽 메트릭 API 테스트
  const trafficResponse = http.get(`${BASE_URL}/api/traffic/metrics`);
  const trafficSuccess = check(trafficResponse, {
    'traffic metrics API status is 200': (r) => r.status === 200,
  });
  errorRate.add(!trafficSuccess);
  requestDuration.add(trafficResponse.timings.duration);

  // 요청 간 간격 (0.1초 ~ 0.5초 랜덤)
  sleep(Math.random() * 0.4 + 0.1);
}

// 테스트 완료 후 처리
export function teardown(data) {
  console.log('=== k6 트래픽 테스트 완료 ===');
  console.log('생성된 총 요청 수:', data.metrics.http_reqs.values.count);
  console.log('평균 응답 시간:', data.metrics.http_req_duration.values.avg, 'ms');
  console.log('95% 응답 시간:', data.metrics.http_req_duration.values['p(95)'], 'ms');
  console.log('실패율:', (data.metrics.http_req_failed.values.rate * 100).toFixed(2), '%');
  console.log('최대 RPS:', data.metrics.http_reqs.values.rate);
  
  // 결과를 JSON 파일로 저장
  const fs = require('fs');
  const timestamp = new Date().toISOString().replace(/[:.]/g, '-');
  const resultData = {
    timestamp: new Date().toISOString(),
    summary: {
      totalRequests: data.metrics.http_reqs.values.count,
      avgResponseTime: data.metrics.http_req_duration.values.avg,
      p95ResponseTime: data.metrics.http_req_duration.values['p(95)'],
      failureRate: data.metrics.http_req_failed.values.rate,
      maxRPS: data.metrics.http_reqs.values.rate
    },
    metrics: data.metrics
  };
  
  fs.writeFileSync(`k6-results-${timestamp}.json`, JSON.stringify(resultData, null, 2));
  console.log(`결과가 k6-results-${timestamp}.json 파일에 저장되었습니다.`);
}
