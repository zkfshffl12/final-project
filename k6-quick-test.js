import http from 'k6/http';
import { check, sleep } from 'k6';

// 빠른 테스트 설정
export const options = {
  vus: 10,        // 10명의 가상 사용자
  duration: '30s', // 30초간 테스트
};

const BASE_URL = 'http://localhost:8080';

export default function () {
  // 트래픽 기록
  const recordResponse = http.post(`${BASE_URL}/api/traffic/record`);
  check(recordResponse, {
    'traffic record works': (r) => r.status === 200,
  });

  // 메트릭 확인
  const metricsResponse = http.get(`${BASE_URL}/api/traffic/metrics`);
  check(metricsResponse, {
    'metrics endpoint works': (r) => r.status === 200,
    'has traffic data': (r) => r.json('currentRPS') >= 0,
  });

  sleep(1);
}
