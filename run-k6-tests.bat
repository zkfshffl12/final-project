@echo off
echo ========================================
echo k6 트래픽 테스트 실행기
echo ========================================

echo.
echo 1. 빠른 테스트 (30초)
echo 2. 일반 부하 테스트 (3분)
echo 3. 스파이크 테스트 (2분)
echo 4. 모든 테스트 실행
echo.

set /p choice="테스트를 선택하세요 (1-4): "

if "%choice%"=="1" (
    echo.
    echo 빠른 테스트 시작...
    k6 run k6-quick-test.js
) else if "%choice%"=="2" (
    echo.
    echo 일반 부하 테스트 시작...
    k6 run k6-traffic-test.js
) else if "%choice%"=="3" (
    echo.
    echo 스파이크 테스트 시작...
    k6 run k6-spike-test.js
) else if "%choice%"=="4" (
    echo.
    echo 모든 테스트 실행...
    echo.
    echo 1. 빠른 테스트...
    k6 run k6-quick-test.js
    echo.
    echo 2. 일반 부하 테스트...
    k6 run k6-traffic-test.js
    echo.
    echo 3. 스파이크 테스트...
    k6 run k6-spike-test.js
) else (
    echo 잘못된 선택입니다.
    goto :eof
)

echo.
echo 테스트 완료!
pause
