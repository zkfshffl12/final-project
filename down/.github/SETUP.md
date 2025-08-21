# GitHub Actions 설정 가이드

## 📋 개요

이 프로젝트는 GitHub Actions를 사용하여 CI/CD 파이프라인과 Terraform 배포를 자동화합니다.

## 🔧 필요한 GitHub Secrets

### 1. AWS 인증 정보

GitHub 저장소의 Settings → Secrets and variables → Actions에서 다음 secrets를 설정하세요:

#### 필수 Secrets
- `AWS_ACCESS_KEY_ID`: AWS IAM 사용자의 Access Key ID
- `AWS_SECRET_ACCESS_KEY`: AWS IAM 사용자의 Secret Access Key
- `AWS_REGION`: AWS 리전 (예: us-east-1)

#### 데이터베이스 관련
- `DB_PASSWORD`: RDS MySQL 데이터베이스 비밀번호

#### SSH 키 관련
- `SSH_PUBLIC_KEY`: EC2 접속용 SSH 공개키
- `SSH_PRIVATE_KEY`: GitHub Actions에서 EC2 접속용 SSH 개인키

#### 프론트엔드 관련
- `REACT_APP_API_URL`: React 앱에서 사용할 API URL

## 🔐 AWS IAM 사용자 설정

### 1. IAM 사용자 생성

AWS Console에서 다음 권한을 가진 IAM 사용자를 생성하세요:

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ec2:*",
                "autoscaling:*",
                "s3:*",
                "cloudfront:*",
                "rds:*",

                "cloudwatch:*",
                "iam:*",
                "vpc:*",
                "elasticloadbalancing:*",
                "logs:*",
                "secretsmanager:*"
            ],
            "Resource": "*"
        }
    ]
}
```

### 2. Access Key 생성

1. IAM 사용자 선택
2. "Security credentials" 탭
3. "Create access key" 클릭
4. 생성된 Access Key ID와 Secret Access Key를 GitHub Secrets에 설정

## 🔑 SSH 키 설정

### 1. SSH 키 생성

```bash
# SSH 키 생성
ssh-keygen -t rsa -b 4096 -f ~/.ssh/github-deploy-key -N ""

# 공개키 내용 확인
cat ~/.ssh/github-deploy-key.pub
```

### 2. GitHub Secrets에 설정

1. **공개키 설정**: 생성된 공개키 내용을 `SSH_PUBLIC_KEY` secret에 설정
2. **개인키 설정**: 생성된 개인키 내용을 `SSH_PRIVATE_KEY` secret에 설정

### 3. EC2 인스턴스에 배포 키 설정

EC2 인스턴스의 `~/.ssh/authorized_keys`에 배포용 SSH 키를 추가하세요.

## 🚀 워크플로우 설명

### 1. CI/CD Pipeline (`ci-cd.yml`)

**트리거 조건:**
- `main` 또는 `develop` 브랜치에 push
- `main` 브랜치로 Pull Request

**단계:**
1. **Test**: Java 애플리케이션 테스트 실행
2. **Build**: Gradle을 사용한 애플리케이션 빌드
3. **Docker Build**: Docker 이미지 빌드 및 GitHub Container Registry에 푸시
4. **Deploy to EC2**: EC2 인스턴스에 애플리케이션 배포

### 2. Terraform Deploy (`terraform-deploy.yml`)

**트리거 조건:**
- `main` 브랜치에 push (terraform 디렉토리 변경 시)
- 수동 실행 (workflow_dispatch)

**기능:**
- Terraform 코드 검증 및 포맷팅
- 인프라 계획 생성 및 적용
- 환경별 배포 지원 (production, staging)

### 3. Static Files Deploy (`deploy-static.yml`)

**트리거 조건:**
- `main` 브랜치에 push (frontend 디렉토리 변경 시)
- 수동 실행

**기능:**
- React 앱 빌드
- S3 버킷에 정적 파일 업로드
- CloudFront 캐시 무효화

## 📁 프로젝트 구조

```
down/
├── .github/
│   ├── workflows/
│   │   ├── ci-cd.yml              # CI/CD 파이프라인
│   │   ├── terraform-deploy.yml   # Terraform 배포
│   │   └── deploy-static.yml      # 정적 파일 배포
│   └── SETUP.md                   # 이 파일
├── terraform/                     # Terraform 인프라 코드
├── frontend/                      # React 프론트엔드 (선택사항)
└── src/                          # Spring Boot 백엔드
```

## 🔄 배포 프로세스

### 1. 초기 설정

1. **Terraform 배포**:
   ```bash
   # GitHub Actions에서 수동 실행
   # 또는 terraform 디렉토리 변경 후 자동 실행
   ```

2. **인프라 생성 확인**:
   - VPC, 서브넷, 보안 그룹
   - EC2 인스턴스 및 Auto Scaling Group
   - RDS MySQL 데이터베이스
   - S3 버킷 및 CloudFront 배포

### 2. 애플리케이션 배포

1. **백엔드 배포**:
   - `main` 브랜치에 push
   - 자동으로 테스트 → 빌드 → Docker 이미지 생성 → EC2 배포

2. **프론트엔드 배포** (선택사항):
   - `frontend` 디렉토리 변경 시 자동 배포
   - S3에 정적 파일 업로드
   - CloudFront 캐시 무효화

## 🛠️ 문제 해결

### 일반적인 문제

1. **AWS 권한 오류**:
   - IAM 사용자 권한 확인
   - Access Key 유효성 확인

2. **SSH 연결 오류**:
   - SSH 키 설정 확인
   - EC2 보안 그룹 설정 확인

3. **Terraform 오류**:
   - Terraform 코드 검증
   - 변수 설정 확인

### 로그 확인

GitHub Actions에서 각 단계의 로그를 확인하여 문제를 진단할 수 있습니다.

## 📞 지원

문제가 발생하면:

1. GitHub Actions 로그 확인
2. AWS CloudWatch 로그 확인
3. EC2 인스턴스 로그 확인
4. 팀 내 DevOps 담당자 문의

---

**참고**: 이 설정은 프로덕션 환경을 위한 것입니다. 개발 환경에서는 더 간단한 설정을 사용할 수 있습니다.
