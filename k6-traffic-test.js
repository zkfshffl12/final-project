import http from 'k6/http';
import { check, sleep } from 'k6';

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
  },
};

// 기본 URL (스프링부트 서버)
const BASE_URL = 'http://localhost:8081';

export default function () {
  // 1. 헬스 체크 (기본 트래픽)
  const healthResponse = http.get(`${BASE_URL}/health`);
  check(healthResponse, {
    'health check status is 200': (r) => r.status === 200,
    'health check response time < 200ms': (r) => r.timings.duration < 200,
  });

  // 2. 트래픽 기록 API 호출
  const recordResponse = http.post(`${BASE_URL}/api/traffic/record`);
  check(recordResponse, {
    'traffic record status is 200': (r) => r.status === 200,
  });

  // 3. 메트릭 조회 (모니터링용)
  const metricsResponse = http.get(`${BASE_URL}/api/traffic/metrics`);
  check(metricsResponse, {
    'metrics status is 200': (r) => r.status === 200,
    'metrics has currentRPS': (r) => r.json('currentRPS') !== undefined,
    'metrics has peakRPS': (r) => r.json('peakRPS') !== undefined,
  });

  // 4. 테스트 엔드포인트 (부하 생성용)
  const testResponse = http.get(`${BASE_URL}/api/traffic/test`);
  check(testResponse, {
    'test endpoint status is 200': (r) => r.status === 200,
  });

  // 요청 간 간격 (0.1초 ~ 0.5초 랜덤)
  sleep(Math.random() * 0.4 + 0.1);
}

// 테스트 완료 후 처리
export function teardown(data) {
  console.log('k6 트래픽 테스트 완료!');
  console.log('생성된 총 요청 수:', data.metrics.http_reqs.values.count);
  console.log('평균 응답 시간:', data.metrics.http_req_duration.values.avg, 'ms');
}
