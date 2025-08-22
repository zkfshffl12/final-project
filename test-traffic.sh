#!/bin/bash

# 트래픽 테스트 스크립트
echo "실제 트래픽 테스트 시작..."

# 서버 URL (실제 배포된 URL로 변경 필요)
SERVER_URL="http://localhost:8080"

# 1. 기본 헬스 체크
echo "1. 헬스 체크 테스트..."
for i in {1..10}; do
    curl -s "$SERVER_URL/health" > /dev/null
    echo "헬스 체크 $i 완료"
    sleep 0.1
done

# 2. 트래픽 기록 API 테스트
echo "2. 트래픽 기록 API 테스트..."
for i in {1..20}; do
    curl -s -X POST "$SERVER_URL/api/traffic/record" > /dev/null
    echo "트래픽 기록 $i 완료"
    sleep 0.05
done

# 3. 메트릭 확인
echo "3. 현재 메트릭 확인..."
curl -s "$SERVER_URL/api/traffic/metrics" | jq '.'

# 4. 대량 트래픽 테스트 (Apache Bench 사용)
echo "4. 대량 트래픽 테스트 (Apache Bench)..."
if command -v ab &> /dev/null; then
    ab -n 100 -c 10 "$SERVER_URL/api/traffic/test"
else
    echo "Apache Bench가 설치되지 않았습니다. 수동으로 테스트하세요."
    for i in {1..100}; do
        curl -s "$SERVER_URL/api/traffic/test" > /dev/null
        if [ $((i % 10)) -eq 0 ]; then
            echo "대량 테스트 $i/100 완료"
        fi
    done
fi

echo "트래픽 테스트 완료!"
