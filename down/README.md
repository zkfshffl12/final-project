# Game Server Project

Spring Boot 기반의 게임 서버 프로젝트입니다.

## 🏗️ 아키텍처

```
CloudFront (CDN) → S3 (정적 파일) + ALB (API) → EC2 (Spring Boot) → RDS MySQL
                                                       ↓
                                                 CloudWatch (모니터링)
```

## 🚀 주요 기능

### 사용자 관리
- 사용자 등록/수정/삭제
- 비밀번호 암호화 (SHA-256)
- 중복 검사 (사용자명, 이메일)

### 게임 세션 관리
- 게임 세션 생성/수정/삭제
- 게임 상태 관리 (ACTIVE, COMPLETED, CANCELLED)
- 점수 기록 및 조회

### API 엔드포인트

#### 사용자 API
- `GET /api/users` - 모든 사용자 조회
- `GET /api/users/{id}` - 특정 사용자 조회
- `GET /api/users/username/{username}` - 사용자명으로 조회
- `POST /api/users` - 사용자 생성
- `PUT /api/users/{id}` - 사용자 수정
- `DELETE /api/users/{id}` - 사용자 삭제

#### 게임 세션 API
- `GET /api/game-sessions` - 모든 게임 세션 조회
- `GET /api/game-sessions/{id}` - 특정 게임 세션 조회
- `GET /api/game-sessions/user/{userId}` - 사용자의 게임 세션 조회
- `GET /api/game-sessions/user/{userId}/active` - 사용자의 활성 게임 세션 조회
- `POST /api/game-sessions` - 게임 세션 생성
- `PUT /api/game-sessions/{id}` - 게임 세션 수정
- `POST /api/game-sessions/{id}/complete` - 게임 세션 완료
- `DELETE /api/game-sessions/{id}` - 게임 세션 삭제
- `GET /api/game-sessions/completed` - 완료된 게임 세션 조회

#### 헬스체크 API
- `GET /health` - 서버 상태 확인

## 🛠️ 기술 스택

- **Backend**: Spring Boot 3.5.4, Java 17
- **Database**: MySQL 8.0
- **Security**: SHA-256 비밀번호 암호화
- **Infrastructure**: AWS (EC2, RDS, S3, CloudFront, ALB, CloudWatch)
- **Container**: Docker, Docker Compose
- **CI/CD**: GitHub Actions
- **IaC**: Terraform

## 📁 프로젝트 구조

```
down/
├── src/main/java/com/bed/
│   ├── Controller/           # REST API 컨트롤러
│   ├── service/              # 비즈니스 로직 서비스
│   ├── repository/           # 데이터 접근 계층
│   ├── entity/               # JPA 엔티티
│   └── config/               # 설정 클래스
├── src/main/resources/
│   ├── application.properties    # 기본 설정
│   ├── application-aws.properties # AWS 환경 설정
│   ├── application-docker.properties # Docker 환경 설정
│   ├── schema.sql               # 데이터베이스 스키마
│   └── data.sql                 # 초기 데이터
├── terraform/                # Terraform 인프라 코드
├── .github/workflows/        # GitHub Actions 워크플로우
├── docker-compose.yml        # Docker Compose 설정
├── Dockerfile               # Docker 이미지 설정
└── build.gradle             # Gradle 빌드 설정
```

## 🔧 개발 환경 설정

### 사전 요구사항
- Java 17
- Gradle 8.x
- Docker & Docker Compose
- MySQL 8.0

### 로컬 개발 환경 실행

1. **데이터베이스 설정**
   ```bash
   # MySQL 컨테이너 실행
   docker run --name mysql-game -e MYSQL_ROOT_PASSWORD=password \
     -e MYSQL_DATABASE=gamedb -p 3306:3306 -d mysql:8.0
   ```

2. **애플리케이션 실행**
   ```bash
   # Gradle로 실행
   ./gradlew bootRun
   
   # 또는 Docker로 실행
   docker-compose up -d
   ```

3. **API 테스트**
   ```bash
   # 헬스체크
   curl http://localhost:8080/health
   
   # 사용자 생성
   curl -X POST http://localhost:8080/api/users \
     -H "Content-Type: application/json" \
     -d '{"username":"testuser","email":"test@example.com","password":"password123"}'
   ```

## 🚀 배포

### GitHub Actions를 통한 자동 배포

1. **GitHub Secrets 설정**
   - AWS 인증 정보
   - SSH 키
   - 데이터베이스 비밀번호

2. **배포 프로세스**
   - `main` 브랜치에 push
   - GitHub Actions에서 자동으로 테스트 → 빌드 → 배포

### 수동 배포

1. **인프라 배포**
   ```bash
   cd terraform
   terraform init
   terraform plan
   terraform apply
   ```

2. **애플리케이션 배포**
   ```bash
   # EC2 인스턴스에 접속
   ssh -i ~/.ssh/deploy-key ec2-user@<EC2_IP>
   
   # 애플리케이션 실행
   cd /opt/app
   docker-compose up -d
   ```

## 📊 모니터링

### CloudWatch 메트릭
- EC2 CPU/메모리 사용률
- ALB 요청 수/응답 시간
- RDS 연결 수/쿼리 성능

### 로그
- 애플리케이션 로그: `/ec2/production-spring-boot`
- 시스템 로그: CloudWatch Logs

## 🔒 보안

- SHA-256을 통한 비밀번호 암호화
- VPC를 통한 네트워크 격리
- Security Groups를 통한 포트 제어
- S3 Bucket Policy를 통한 접근 제어

## 🧪 테스트

```bash
# 단위 테스트 실행
./gradlew test

# 통합 테스트 실행
./gradlew integrationTest
```

## 📞 지원

문제가 발생하면:
1. GitHub Issues 확인
2. CloudWatch 로그 확인
3. EC2 인스턴스 상태 확인
4. 팀 내 DevOps 담당자 문의

---

**참고**: 이 프로젝트는 프로덕션 환경을 위한 것입니다. 개발 환경에서는 더 간단한 설정을 사용할 수 있습니다.
# final-project
