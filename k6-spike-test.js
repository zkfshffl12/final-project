import http from 'k6/http';
import { check, sleep } from 'k6';

// 스파이크 테스트 설정 (갑작스러운 트래픽 증가)
export const options = {
  stages: [
    { duration: '30s', target: 5 },   // 30초간 5명으로 시작
    { duration: '10s', target: 100 }, // 10초간 100명으로 급증 (스파이크!)
    { duration: '30s', target: 100 }, // 30초간 100명 유지
    { duration: '10s', target: 5 },   // 10초간 5명으로 급감
    { duration: '20s', target: 0 },   // 20초간 0명으로 종료
  ],
  thresholds: {
    http_req_duration: ['p(95)<1000'], // 스파이크 시 1초 이내
    http_req_failed: ['rate<0.2'],     // 실패율 20% 미만
  },
};

const BASE_URL = 'http://localhost:8080';

export default function () {
  // 다양한 엔드포인트로 부하 분산
  const endpoints = [
    '/health',
    '/api/traffic/test',
    '/api/traffic/record'
  ];
  
  // 랜덤하게 엔드포인트 선택
  const endpoint = endpoints[Math.floor(Math.random() * endpoints.length)];
  
  let response;
  if (endpoint === '/api/traffic/record') {
    response = http.post(`${BASE_URL}${endpoint}`);
  } else {
    response = http.get(`${BASE_URL}${endpoint}`);
  }
  
  check(response, {
    'status is 200': (r) => r.status === 200,
    'response time < 1000ms': (r) => r.timings.duration < 1000,
  });

  // 짧은 간격으로 연속 요청 (스파이크 효과)
  sleep(Math.random() * 0.2 + 0.05);
}
