# Terraform Infrastructure for Game Server

이 Terraform 스크립트는 게임 서버를 위한 완전한 AWS 인프라를 생성합니다.

## 🏗️ 아키텍처

```
CloudFront (CDN) → S3 (정적 파일) + ALB (API) → EC2 (Spring Boot) → RDS MySQL
                                                      ↓
                                                CloudWatch (모니터링)
```

### 구성 요소

- **CloudFront**: React 정적 파일(JS, CSS, 이미지) 캐싱 및 전송
- **S3**: 정적 리소스(React 빌드 파일, 이미지, 문서) 저장
- **ALB**: HTTP/HTTPS 트래픽을 여러 서버로 분산, SSL 인증서 관리
- **EC2**: 백엔드 API 실행 (비즈니스 로직 처리)
- **RDS**: 사용자, 게시글, 주식 데이터 등 저장
- **VPC + Security Group**: 네트워크 격리 및 포트 접근 제어

## 📁 모듈 구조

- **vpc**: VPC, 서브넷, 보안 그룹
- **alb**: Application Load Balancer
- **ec2**: EC2 인스턴스 및 Auto Scaling Group
- **s3**: S3 버킷 (정적 파일 저장)
- **cloudfront**: CloudFront CDN

- **rds**: RDS MySQL 인스턴스
- **cloudwatch**: 모니터링 및 로깅

## 🚀 배포 방법

### 1. 사전 준비
```bash
# AWS CLI 설정
aws configure

# Terraform 설치 확인
terraform version

# SSH 키 생성 (EC2 접속용)
ssh-keygen -t rsa -b 4096 -f ~/.ssh/game-server-key
```

### 2. 변수 설정
```bash
# terraform.tfvars 파일 생성
cp terraform.tfvars.example terraform.tfvars

# 변수 값 수정
vim terraform.tfvars
```

**필수 설정 항목:**
- `db_password`: 데이터베이스 비밀번호
- `ssh_public_key`: SSH 공개키 (EC2 접속용)

### 3. 인프라 배포
```bash
# Terraform 초기화
terraform init

# 배포 계획 확인
terraform plan

# 인프라 생성
terraform apply
```

### 4. 애플리케이션 배포
```bash
# EC2 인스턴스에 접속
ssh -i ~/.ssh/game-server-key ec2-user@<EC2_PRIVATE_IP>

# 애플리케이션 디렉토리로 이동
cd /opt/app

# Docker 이미지 빌드 및 실행
docker-compose up -d
```

### 5. 인프라 삭제
```bash
terraform destroy
```

## 🔧 주요 리소스

### VPC
- **CIDR**: 10.0.0.0/16
- **Public Subnets**: 3개 (각 AZ별)
- **Private Subnets**: 3개 (각 AZ별)
- **NAT Gateway**: 1개

### EC2
- **Instance Type**: t3.medium
- **Auto Scaling Group**: 2-4개 인스턴스
- **Security Group**: ALB에서 8080 포트만 허용
- **SSH Access**: 22 포트 허용

### S3
- **Bucket**: 정적 파일 저장
- **Versioning**: 활성화
- **CORS**: CloudFront 접근 허용
- **Lifecycle**: 30일 후 이전 버전 삭제

### RDS MySQL
- **Engine**: MySQL 8.0
- **Instance**: db.t3.micro
- **Storage**: 20GB (최대 100GB)
- **Backup**: 7일 보관

### CloudWatch
- **Log Groups**: 애플리케이션, EC2
- **Alarms**: CPU, Memory 사용률
- **Dashboard**: 실시간 모니터링

## 📊 출력값

배포 후 다음 정보를 확인할 수 있습니다:

```bash
terraform output
```

- `alb_dns_name`: ALB DNS 이름
- `cloudfront_domain_name`: CloudFront 도메인
- `s3_bucket_name`: S3 버킷 이름
- `ec2_instance_id`: EC2 인스턴스 ID
- `rds_endpoint`: RDS 연결 엔드포인트


## 🔒 보안

- **VPC**: 격리된 네트워크 환경
- **Security Groups**: 포트별 접근 제어
- **Private Subnets**: EC2, RDS 비공개 배치
- **SSH Key**: EC2 접속용 키 페어
- **S3 Bucket Policy**: CloudFront OAI만 접근 허용

## 💰 비용 예상

월 예상 비용 (us-east-1 기준):
- **EC2 t3.medium**: ~$60 (2개 인스턴스)
- **ALB**: ~$20
- **RDS MySQL**: ~$100
- **S3**: ~$5
- **CloudFront**: ~$10
- **CloudWatch**: ~$30
- **기타**: ~$50
- **총 비용**: 약 $275/월

## 🆘 문제 해결

### 일반적인 오류
1. **권한 오류**: IAM 사용자에게 필요한 권한 부여
2. **리소스 제한**: AWS 계정의 리소스 제한 확인
3. **네트워크 오류**: VPC 설정 및 보안 그룹 확인
4. **SSH 연결 오류**: 키 페어 및 보안 그룹 설정 확인

### 로그 확인
```bash
# EC2 로그
ssh -i ~/.ssh/game-server-key ec2-user@<EC2_IP>
sudo journalctl -u spring-boot.service

# Docker 로그
docker-compose logs spring-boot

# CloudWatch 메트릭
aws cloudwatch list-metrics --namespace "AWS/EC2"
```

### 애플리케이션 배포 문제
```bash
# Docker 이미지 재빌드
docker-compose down
docker-compose build --no-cache
docker-compose up -d

# 환경 변수 확인
docker-compose exec spring-boot env
```

## 📞 지원

문제가 발생하면 다음을 확인하세요:
1. Terraform 버전 (>= 1.0)
2. AWS CLI 설정
3. 변수 값 설정
4. AWS 계정 권한
5. SSH 키 설정
6. Docker 및 Docker Compose 설치
