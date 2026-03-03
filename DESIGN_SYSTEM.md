# 🎭 Weiver 디자인 시스템: "The Stage"

본 문서는 뮤지컬 커뮤니티 **Weiver**의 UI/UX 일관성을 유지하기 위한 디자인 가이드라인입니다. 넷플릭스의 직관적인 레이아웃을 계승하되, 뮤지컬 특유의 예술적 감성을 담은 차별화된 아이덴티티를 지향합니다.

## 1. 브랜드 컨셉 (Brand Keywords)
- **Passion (열정):** 뮤지컬의 뜨거운 에너지를 담은 로즈 레드 컬러.
- **Spotlight (조명):** 중요한 정보와 콘텐츠에 시각적 집중도를 높이는 효과.
- **Elegance (우아함):** 클래식 예술의 고전적 감성과 현대적 세련미의 조화.
- **Connected (연결):** 관객과 관객이 소통하는 커뮤니티 중심의 공간.

## 2. 컬러 팔레트 (Color Palette)
깊이감 있는 극장(Theatre) 테마를 기반으로 하며, 눈의 피로도를 낮춘 다크 모드 지향적 컬러입니다.

| 구분 | 색상 코드 | 용도 | 비고 |
| :--- | :--- | :--- | :--- |
| **Primary** | `#BE123C` | 브랜드 컬러, 강조 버튼, 포인트 | Rose Red (열정) |
| **Secondary** | `#FBBF24` | 별점, 등급, 조명 효과, 강조 아이콘 | Amber Gold (조명) |
| **Background** | `#0F172A` | 전체 페이지 배경 | Deep Navy Black (무대) |
| **Surface** | `#1E293B` | 카드 배경, 섹션 구분, 입력 필드 | Dark Blue Gray (바닥) |
| **Text (Main)** | `#F8FAFC` | 본문, 제목, 주요 텍스트 | High Contrast White |
| **Text (Sub)** | `#94A3B8` | 설명글, 비활성 텍스트, 하단 정보 | Muted Gray Blue |

## 3. 타이포그래피 (Typography)
- **Main Sans-serif:** `Pretendard`, `Noto Sans KR` (가독성 중심)
- **Accent (English only):** `Playfair Display` (클래식한 느낌의 세리프체, 포인트용)
- **Font Sizes:**
  - H1: 2rem (32px) - 주요 섹션 타이틀
  - H2: 1.5rem (24px) - 카드 타이틀, 서브 타이틀
  - Body: 1rem (16px) - 일반 텍스트
  - Small: 0.875rem (14px) - 캡션, 부가 정보

## 4. UI 컴포넌트 원칙 (UI Principles)
### 4.1. 카드 디자인 (Card UI)
- **Rounded:** `12px` 이상의 둥근 모서리 (`rounded-xl` in Tailwind).
- **Glassmorphism:** 커뮤니티 게시글 및 팝업 요소에 투명도(`backdrop-blur`) 적용.
- **Elevation:** 미세한 그림자(`shadow-lg`)와 테두리(`border border-slate-700`)로 입체감 부여.

### 4.2. 호버 효과 (Hover Effects)
- **Spotlight Glow:** 카드 호버 시 뒷면에 은은한 골드(`Amber Gold`) 글로우 효과.
- **Scale Up:** 포스터 카드 호버 시 `1.05배` 확대 및 선명도 조절.

### 4.3. 레이아웃 (Layout)
- **Horizontal Row:** 뮤지컬 목록은 좌우 스와이프 캐러셀(Netflix style) 유지.
- **Masonry/Grid:** 커뮤니티 인기글은 가변형 그리드 또는 정돈된 리스트 카드 배치.

## 5. 테크 스택 가이드 (Implementation)
- **Framework:** Spring Boot (JSP/JSTL)
- **Styling:** Tailwind CSS (Utility-first)
- **Icons:** Bootstrap Icons 또는 Lucide React (아이콘 라이브러리)
- **Library:** Swiper.js (캐러셀 전용)

---
*Last Updated: 2026-03-03*
