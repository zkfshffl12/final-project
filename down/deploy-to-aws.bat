@echo off
echo 🚀 AWS 배포 시작...

REM 1. 애플리케이션 빌드
echo 📦 애플리케이션 빌드 중...
call gradlew.bat clean build -x test

REM 2. Docker 이미지 빌드
echo 🐳 Docker 이미지 빌드 중...
docker build -t traffic-monitor:latest .

REM 3. AWS ECR 로그인 (AWS CLI 필요)
echo 🔐 AWS ECR 로그인 중...
aws ecr get-login-password --region ap-northeast-2 | docker login --username AWS --password-stdin %AWS_ACCOUNT_ID%.dkr.ecr.ap-northeast-2.amazonaws.com

REM 4. ECR 리포지토리 태그
echo 🏷️ ECR 리포지토리 태그 중...
docker tag traffic-monitor:latest %AWS_ACCOUNT_ID%.dkr.ecr.ap-northeast-2.amazonaws.com/traffic-monitor:latest

REM 5. ECR에 푸시
echo ⬆️ ECR에 푸시 중...
docker push %AWS_ACCOUNT_ID%.dkr.ecr.ap-northeast-2.amazonaws.com/traffic-monitor:latest

REM 6. Terraform 배포
echo 🏗️ Terraform 인프라 배포 중...
cd terraform
terraform init
terraform plan
terraform apply -auto-approve

echo ✅ 배포 완료!
echo 🌐 ALB URL: 
terraform output -raw alb_dns_name
echo 📊 대시보드: http://
terraform output -raw alb_dns_name

pause
