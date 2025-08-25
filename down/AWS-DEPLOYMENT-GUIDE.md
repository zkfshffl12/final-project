# 🚀 AWS 배포 가이드

## 📋 사전 요구사항

1. **AWS CLI 설치 및 설정**
   ```bash
   aws configure
   ```

2. **Docker 설치**
   - Docker Desktop 또는 Docker Engine

3. **Terraform 설치**
   - Terraform CLI

4. **환경 변수 설정**
   ```bash
   export AWS_ACCOUNT_ID=your-aws-account-id
   ```

## 🏗️ 인프라 구성

### 1. VPC 및 네트워킹
- VPC 생성
- 퍼블릭/프라이빗 서브넷
- 인터넷 게이트웨이
- NAT 게이트웨이

### 2. 보안 그룹
- ALB: 80, 443 포트 허용
- EC2: 8081 포트 허용 (스프링부트)

### 3. Application Load Balancer
- HTTP/HTTPS 리스너
- 헬스체크: `/actuator/health`
- 루트 경로 자동 리다이렉트

### 4. EC2 인스턴스
- Docker 설치
- 애플리케이션 컨테이너 실행
- 자동 스케일링 그룹

## 🚀 배포 방법

### 방법 1: 자동 배포 스크립트 사용

**Linux/Mac:**
```bash
chmod +x deploy-to-aws.sh
./deploy-to-aws.sh
```

**Windows:**
```cmd
deploy-to-aws.bat
```

### 방법 2: 수동 배포

1. **애플리케이션 빌드**
   ```bash
   ./gradlew clean build -x test
   ```

2. **Docker 이미지 빌드**
   ```bash
   docker build -t traffic-monitor:latest .
   ```

3. **AWS ECR 푸시**
   ```bash
   aws ecr get-login-password --region ap-northeast-2 | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.ap-northeast-2.amazonaws.com
   docker tag traffic-monitor:latest $AWS_ACCOUNT_ID.dkr.ecr.ap-northeast-2.amazonaws.com/traffic-monitor:latest
   docker push $AWS_ACCOUNT_ID.dkr.ecr.ap-northeast-2.amazonaws.com/traffic-monitor:latest
   ```

4. **Terraform 배포**
   ```bash
   cd terraform
   terraform init
   terraform plan
   terraform apply -auto-approve
   ```

## 🌐 접속 방법

배포 완료 후 다음 URL로 접속:

```
http://[ALB-DNS-NAME]/
```

예시:
```
http://alb-123456789.ap-northeast-2.elb.amazonaws.com/
```

## 📊 기능 확인

1. **메인 대시보드**: 루트 URL 접속
2. **헬스체크**: `/actuator/health`
3. **H2 콘솔**: `/h2-console`
4. **API 엔드포인트**: `/api/*`

## 🔧 문제 해결

### 1. ALB 헬스체크 실패
- EC2 인스턴스가 8081 포트에서 실행 중인지 확인
- 보안 그룹에서 8081 포트 허용 확인

### 2. 정적 파일 로드 실패
- `index.html`이 `src/main/resources/static/` 폴더에 있는지 확인
- 애플리케이션 로그에서 정적 파일 경로 확인

### 3. Docker 이미지 빌드 실패
- Dockerfile이 올바른지 확인
- 포트 매핑이 8081:8081인지 확인

## 🗑️ 리소스 정리

```bash
cd terraform
terraform destroy -auto-approve
```

## 📝 참고사항

- 모든 트래픽 데이터는 브라우저 로컬 스토리지에 저장됩니다
- AWS 배포 시에는 실시간 데이터가 서버 재시작 시 초기화됩니다
- 프로덕션 환경에서는 데이터베이스 연결을 권장합니다
