# Weiver Design System: Dramatic Theater

## Overview
Weiver의 디자인 시스템은 'Dramatic Theater'를 테마로 하며, 극장의 어둡고 웅장한 분위기와 스포트라이트를 받는 듯한 몰입감을 제공합니다. 사용자가 뮤지컬과 무대의 주인공이 된 듯한 느낌을 줍니다.

## 1. Color Palette
무대의 깊이감과 고급스러운 분위기를 연출하기 위해 깊은 검은색, 왕실의 버건디, 그리고 포인트를 주는 황금색을 사용합니다.

*   **배경 (Stage Background)**: 
    *   깊이감 있는 검정색 그라데이션
    *   `background: linear-gradient(180deg, #0f0f0f 0%, #000000 100%);`
    *   Tailwind: `bg-stage-bg` (`#0a0a0a`)
*   **표면 (Surface/Cards)**:
    *   Tailwind: `bg-stage-surface` (`#1a1a1a`)
*   **주조색 (Primary Accent)**:
    *   깊은 벨벳 레드 (버건디)
    *   Tailwind: `bg-stage-primary`, `text-stage-primary` (`#BE123C`)
*   **보조색 (Secondary Accent)**:
    *   우아한 골드 (별점, 강조 텍스트, 보더 등)
    *   Tailwind: `text-stage-secondary`, `border-stage-secondary` (`#D4AF37`)
*   **강조 조명 (Gold Glow)**:
    *   스포트라이트 및 호버 효과용 밝은 골드
    *   Tailwind: `text-stage-gold-glow` (`#FFD700`)
*   **텍스트 (Text)**:
    *   기본 텍스트: `text-stage-text` (`#F8FAFC`)
    *   보조 텍스트: `text-stage-text-sub` (`#a1a1aa`)

## 2. Typography
*   **가독성 (Sans-serif)**: `Pretendard` - 기본 UI 텍스트, 본문, 메타데이터에 사용.
*   **타이틀 및 강조 (Serif)**: `Cinzel`, `Playfair Display` - 대제목, 로고, 장식적인 요소에 사용하여 클래식한 무대 느낌 부여.
    *   Tailwind: `font-sans`, `font-serif`

## 3. UI Components & Effects
*   **Glassmorphism Navigation (글래스모피즘 네비게이션)**:
    *   반투명한 검은색 배경과 블러(blur) 효과를 결합하여 무대 배경과 자연스럽게 어우러짐.
    *   ```css
        .glass-nav {
          background: rgba(0, 0, 0, 0.4);
          backdrop-filter: blur(12px);
          border-bottom: 1px solid rgba(212, 175, 55, 0.2);
        }
        ```
*   **Spotlight Glow (스포트라이트 호버 효과)**:
    *   포스터나 카드 컴포넌트에 마우스를 올렸을 때 조명을 받는 듯한 극적인 시각적 피드백 제공.
    *   ```css
        .spotlight-glow:hover {
          box-shadow: 0 0 15px rgba(212, 175, 55, 0.3);
          border-color: rgba(212, 175, 55, 0.8);
        }
        ```

## 4. Layout
*   어두운 테마 기반의 모던 웹 레이아웃.
*   세로 스크롤을 활용하여 정보를 단계적으로 보여줌.
*   포스터 등 시각적인 요소는 그림자(Shadow)를 깊게 주어 공간감을 형성.