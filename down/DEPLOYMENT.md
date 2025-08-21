# 배포 가이드

## 🚀 전체 배포 프로세스

이 프로젝트는 GitHub Actions를 사용하여 자동화된 CI/CD 파이프라인과 Terraform 인프라 배포를 제공합니다.

## 📋 사전 준비

### 1. GitHub 저장소 설정

1. **GitHub Secrets 설정**:
   - `.github/SETUP.md` 파일을 참조하여 필요한 secrets 설정
   - AWS 인증 정보, SSH 키, 데이터베이스 비밀번호 등

2. **저장소 권한 설정**:
   - Settings → Actions → General
   - "Workflow permissions" → "Read and write permissions" 선택

### 2. AWS 계정 설정

1. **IAM 사용자 생성**:
   - Terraform 및 GitHub Actions에서 사용할 IAM 사용자 생성
   - 필요한 권한 부여 (`.github/SETUP.md` 참조)

2. **SSH 키 생성**:
   ```bash
   ssh-keygen -t rsa -b 4096 -f ~/.ssh/github-deploy-key -N ""
   ```

## 🔄 배포 단계

### 1단계: 인프라 배포 (Terraform)

**자동 배포**:
- `main` 브랜치에 push (terraform 디렉토리 변경 시)
- GitHub Actions에서 자동으로 실행

**수동 배포**:
1. GitHub 저장소 → Actions
2. "Terraform Deploy" 워크플로우 선택
3. "Run workflow" 클릭
4. 환경과 액션 선택 (production, apply)

**배포되는 리소스**:
- VPC, 서브넷, 보안 그룹
- EC2 인스턴스 및 Auto Scaling Group
- RDS MySQL 데이터베이스
- S3 버킷 및 CloudFront 배포
- ALB (Application Load Balancer)

### 2단계: 애플리케이션 배포

**백엔드 배포**:
- `main` 브랜치에 push 시 자동 실행
- 단계: 테스트 → 빌드 → Docker 이미지 생성 → EC2 배포

**프론트엔드 배포** (선택사항):
- `frontend` 디렉토리 변경 시 자동 실행
- React 앱 빌드 → S3 업로드 → CloudFront 캐시 무효화

## 📁 프로젝트 구조

```
down/
├── .github/
│   ├── workflows/
│   │   ├── ci-cd.yml              # CI/CD 파이프라인
│   │   ├── terraform-deploy.yml   # Terraform 배포
│   │   └── deploy-static.yml      # 정적 파일 배포
│   └── SETUP.md                   # GitHub Actions 설정 가이드
├── terraform/                     # Terraform 인프라 코드
│   ├── modules/                   # Terraform 모듈들
│   ├── main.tf                    # 메인 설정
│   ├── variables.tf               # 변수 정의
│   └── outputs.tf                 # 출력값 정의
├── src/                          # Spring Boot 백엔드
├── frontend/                     # React 프론트엔드 (선택사항)
├── docker-compose.yml            # Docker Compose 설정
├── Dockerfile                    # Docker 이미지 설정
└── env.example                   # 환경 변수 예제
```

## 🔧 워크플로우 설명

### 1. CI/CD Pipeline (`ci-cd.yml`)

**트리거**:
- `main` 또는 `develop` 브랜치에 push
- `main` 브랜치로 Pull Request

**단계**:
1. **Test**: Java 애플리케이션 테스트
2. **Build**: Gradle 빌드
3. **Docker Build**: Docker 이미지 생성 및 GitHub Container Registry 푸시
4. **Deploy to EC2**: EC2 인스턴스에 애플리케이션 배포

### 2. Terraform Deploy (`terraform-deploy.yml`)

**트리거**:
- `main` 브랜치에 push (terraform 디렉토리 변경 시)
- 수동 실행

**기능**:
- Terraform 코드 검증 및 포맷팅
- 인프라 계획 생성 및 적용
- 환경별 배포 지원

### 3. Static Files Deploy (`deploy-static.yml`)

**트리거**:
- `main` 브랜치에 push (frontend 디렉토리 변경 시)
- 수동 실행

**기능**:
- React 앱 빌드
- S3 버킷에 정적 파일 업로드
- CloudFront 캐시 무효화

## 🌐 접속 정보

배포 완료 후 다음 정보를 확인할 수 있습니다:

### GitHub Actions에서 확인
1. Actions → Terraform Deploy → 최신 실행
2. "Update GitHub Environment" 단계에서 출력값 확인

### AWS Console에서 확인
- **CloudFront**: CDN 도메인
- **ALB**: 로드 밸런서 DNS 이름
- **EC2**: 인스턴스 상태
- **RDS**: 데이터베이스 엔드포인트
- **S3**: 정적 파일 버킷

## 🔍 모니터링

### 1. GitHub Actions
- Actions 탭에서 워크플로우 실행 상태 확인
- 각 단계별 로그 확인

### 2. AWS CloudWatch
- EC2 인스턴스 메트릭
- 애플리케이션 로그
- RDS 데이터베이스 메트릭

### 3. 애플리케이션 헬스체크
```bash
# ALB 헬스체크
curl http://your-alb-dns-name/actuator/health

# CloudFront 헬스체크
curl http://your-cloudfront-domain/actuator/health
```

## 🛠️ 문제 해결

### 일반적인 문제

1. **Terraform 오류**:
   - GitHub Actions 로그 확인
   - Terraform 코드 검증
   - AWS 권한 확인

2. **배포 실패**:
   - SSH 키 설정 확인
   - EC2 보안 그룹 설정 확인
   - Docker 이미지 빌드 로그 확인

3. **애플리케이션 오류**:
   - EC2 인스턴스 로그 확인
   - 데이터베이스 연결 확인
   - 환경 변수 설정 확인

### 로그 확인 방법

1. **GitHub Actions 로그**:
   - Actions → 워크플로우 → 실행 → 단계별 로그

2. **EC2 인스턴스 로그**:
   ```bash
   ssh -i ~/.ssh/deploy-key ec2-user@<EC2_IP>
   sudo journalctl -u spring-boot.service
   docker-compose logs spring-boot
   ```

3. **AWS CloudWatch 로그**:
   - CloudWatch → Log groups → `/ec2/production-spring-boot`

## 🔄 롤백 방법

### 1. 애플리케이션 롤백
```bash
# 이전 Docker 이미지로 롤백
ssh -i ~/.ssh/deploy-key ec2-user@<EC2_IP>
cd /opt/app
docker-compose down
docker-compose up -d ghcr.io/your-repo:previous-tag
```

### 2. 인프라 롤백
1. GitHub Actions → Terraform Deploy
2. 수동 실행 → action: "destroy"
3. 이전 버전으로 재배포

## 📞 지원

문제가 발생하면:

1. GitHub Actions 로그 확인
2. AWS CloudWatch 로그 확인
3. EC2 인스턴스 상태 확인
4. 팀 내 DevOps 담당자 문의

---

**참고**: 이 가이드는 프로덕션 환경을 위한 것입니다. 개발 환경에서는 더 간단한 설정을 사용할 수 있습니다.
