# Weiver 운영 가이드

## 목차
- [크롤링 운영](#크롤링-운영)
  - [설정 키](#설정-키)
  - [시작 시 전체 수집 (초기 데이터 세팅)](#시작-시-전체-수집-초기-데이터-세팅)
  - [정기 스케줄 수집](#정기-스케줄-수집)
  - [크롤링 상태 모니터링](#크롤링-상태-모니터링)
  - [로그 형식](#로그-형식)
- [관리자 페이지](#관리자-페이지)
- [배포 (CI/CD)](#배포-cicd)

---

## 크롤링 운영

뮤지컬·배우 데이터는 [PlayDB](http://www.playdb.co.kr)에서 크롤링합니다.
크롤링은 **전체 수집**(최초 1회)과 **예정 공연 수집**(이후 반복)의 두 가지 유형으로 동작합니다.

### 설정 키

`weiver-main-server/src/main/resources/application.properties`

| 키 | 기본값 | 설명 |
|---|---|---|
| `crawling.startup.enabled` | `false` | `true`로 설정하면 **서버 기동 직후** 크롤링 1회 실행 |
| `crawling.schedule.enabled` | `false` | `true`로 설정하면 **7일 주기** 자동 스케줄 크롤링 활성화 |

> 두 옵션을 동시에 `true`로 설정하면 기동 시 1회 + 이후 7일마다 정기 실행됩니다.

---

### 시작 시 전체 수집 (초기 데이터 세팅)

DB에 뮤지컬·배우 데이터가 없는 상태에서 최초 1회 전체 수집을 실행하려면:

```properties
# application.properties
crawling.startup.enabled=true
crawling.schedule.enabled=false
```

서버를 기동하면 `ApplicationRunner`(`CrawlingStartupRunner`)가 즉시 `CrawlingService.task()`를 호출합니다.
**첫 번째 실행은 항상 `isFirst=true`이므로 전체(ALL) 유형으로 수집됩니다.**

완료 후 재시작 시 불필요한 재수집을 방지하려면 `crawling.startup.enabled=false`로 되돌리세요.

---

### 정기 스케줄 수집

운영 환경에서 예정 공연 데이터를 주기적으로 갱신하려면:

```properties
# application.properties
crawling.startup.enabled=false
crawling.schedule.enabled=true
```

- 첫 실행: 서버 기동 후 **7일(604,800,000ms)** 뒤
- 이후: **7일마다** 반복
- 두 번째 실행부터는 `isFirst=false`이므로 **예정 공연(LATER)** 유형만 수집

스케줄 간격을 변경하려면 `CrawlingScheduler.java`의 `@Scheduled` 값을 수정합니다.

```java
// 예: 3일(259200000ms)마다
@Scheduled(initialDelay = 259200000, fixedDelay = 259200000)
```

---

### 크롤링 상태 모니터링

관리자 페이지에서 실시간으로 크롤링 진행 상태를 확인할 수 있습니다.

| 경로 | 설명 |
|---|---|
| `GET /admin/crawling` | 상태 페이지 (브라우저) |
| `GET /admin/crawling/status` | JSON 상태 API |

**상태 페이지** (`/admin/crawling`)는 5초마다 자동으로 갱신되며 다음 정보를 표시합니다:

| 항목 | 설명 |
|---|---|
| 상태 | 실행 중 / 대기 |
| 크롤링 유형 | 전체 / 예정 공연 |
| 현재 장르 | 처리 중인 장르명 |
| 장르 진행 | N / 4 형태의 진행률 |
| 시작 시각 | 현재 또는 마지막 실행 시작 시각 |
| 마지막 완료 | 마지막 완료 시각 |
| 마지막 소요 시간 | `Xh Xm Xs` 형식 |

**JSON 응답 예시:**
```json
{
  "running": true,
  "crawlingType": "전체",
  "currentGenre": "오리지널",
  "genreIndex": 2,
  "genreTotal": 4,
  "startedAt": "2026-03-05 14:00:00",
  "finishedAt": "-",
  "lastDuration": "-"
}
```

---

### 로그 형식

크롤링 실행 시 다음 형식으로 로그가 출력됩니다.

```
INFO  [크롤링 시작] 유형: 전체 (isFirst=true)
INFO  [1/4] 라이센스 — 최대 12페이지 | 340개 ID 수집 완료
INFO  데이터 저장(340/340)
INFO  [2/4] 오리지널 — 최대 8페이지 | 210개 ID 수집 완료
INFO  데이터 저장(210/210)
INFO  [3/4] 창작 — 최대 15페이지 | 450개 ID 수집 완료
INFO  데이터 저장(450/450)
INFO  [4/4] 뮤지컬 — 최대 5페이지 | 120개 ID 수집 완료
INFO  데이터 저장(120/120)
INFO  [크롤링 완료] 소요: 0h 43m 12s
```

- 페이지별 개별 로그는 출력되지 않습니다 (노이즈 제거).
- 예외 발생 시 `ERROR 예외 발생: <메시지>` 및 재시도 로그가 출력됩니다.
- 3회 재시도 후에도 실패하면 해당 항목을 건너뜁니다.

---

## 관리자 페이지

관리자 페이지는 `/admin/*` 경로에서 제공됩니다.

| 경로 | 기능 |
|---|---|
| `/admin/login` | 관리자 로그인 |
| `/admin/main` | 문의 조회 (메인) |
| `/admin/getAllActors` | 배우 목록 조회·삭제 |
| `/admin/getAllMusicals` | 뮤지컬 목록 조회·삭제 |
| `/admin/getAllUsers` | 유저 목록 조회·삭제 |
| `/admin/getAllAdmins` | 관리자 계정 목록 |
| `/admin/getAllPosts` | 게시글 목록 조회·삭제 |
| `/admin/getAllInquirys` | 문의 목록 및 답변 |
| `/admin/crawling` | 크롤링 상태 모니터링 |

---

## 배포 (CI/CD)

`main` 브랜치에 push하면 GitHub Actions (`.github/workflows/main.yml`)가 자동으로 실행됩니다.

**파이프라인 흐름:**

1. **Checkout** — 소스 체크아웃
2. **JDK 11 설정**
3. **Maven 빌드** — `weiver-main-server/pom.xml`로 `clean package` 실행 → `.war` 생성
4. **배포 패키지 생성** — `Procfile`, `.ebextensions`, `.platform` 포함하여 `deploy.zip` 압축
5. **AWS Elastic Beanstalk 배포** — `ap-northeast-2` 리전의 `Weiver-beanstalk-env` 환경에 배포

**필요한 GitHub Secrets:**

| Secret | 설명 |
|---|---|
| `AWS_ACCESS_KEY_ID` | AWS IAM 액세스 키 |
| `AWS_SECRET_ACCESS_KEY` | AWS IAM 시크릿 키 |

**배포 환경 정보:**
- 플랫폼: AWS Elastic Beanstalk
- 리전: `ap-northeast-2` (서울)
- 애플리케이션명: `weiver`
- 환경명: `Weiver-beanstalk-env`
- 빌드 결과물: `.war` 파일
