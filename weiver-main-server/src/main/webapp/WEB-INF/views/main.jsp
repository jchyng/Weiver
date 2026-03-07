<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="config.jsp" %>

<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no, viewport-fit=cover">
  <title>WIEVER - The Stage</title>

  <!-- Tailwind CSS CDN -->
  <script src="https://cdn.tailwindcss.com"></script>
  <script>
    tailwind.config = {
      theme: {
        extend: {
          colors: {
            'stage-primary': '#BE123C',
            'stage-secondary': '#D4AF37',
            'stage-bg': '#0a0a0a',
            'stage-surface': '#1a1a1a',
            'stage-text': '#F8FAFC',
            'stage-text-sub': '#a1a1aa',
            'stage-gold-glow': '#FFD700',
          },
          fontFamily: {
            sans: ['Pretendard', 'sans-serif'],
            serif: ['Cinzel', 'Playfair Display', 'serif'],
          },
        }
      }
    }
  </script>

  <!-- External Assets -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
  <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.8/dist/web/static/pretendard.css" />
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&family=Cinzel:wght@600;700&display=swap" rel="stylesheet">

  <!-- Swiper -->
  <link rel="stylesheet" href="https://unpkg.com/swiper@8/swiper-bundle.min.css" />
  <script src="https://unpkg.com/swiper@8/swiper-bundle.min.js"></script>

  <style>
    body {
      background: linear-gradient(180deg, #0f0f0f 0%, #000000 100%);
      min-height: 100vh;
      -webkit-tap-highlight-color: transparent;
      overflow-x: hidden;
    }

    .glass-nav {
      background: rgba(0, 0, 0, 0.4);
      backdrop-filter: blur(12px);
      -webkit-backdrop-filter: blur(12px);
      border-bottom: 1px solid rgba(212, 175, 55, 0.2);
    }

    .hero-overlay {
      background: radial-gradient(circle at center, transparent 0%, #000 80%), linear-gradient(to top, #000 0%, transparent 40%);
    }

    .spotlight-glow:hover {
      box-shadow: 0 0 15px rgba(212, 175, 55, 0.3);
      border-color: rgba(212, 175, 55, 0.8);
    }

    .review-card {
      background: #1a1a1a;
      border: 1px solid rgba(212, 175, 55, 0.3);
    }

    .swiper-slide { width: auto; }
    
    @keyframes fadeInUp {
      from { opacity: 0; transform: translateY(20px); }
      to { opacity: 1; transform: translateY(0); }
    }
    .animate-up { animation: fadeInUp 0.8s cubic-bezier(0.2, 0.8, 0.2, 1) forwards; }
  </style>
</head>

<body class="text-stage-text antialiased pb-32">

  <!-- Top Navigation -->
  <header class="fixed top-0 left-0 w-full z-[100] glass-nav">
    <div class="max-w-7xl mx-auto px-6 h-16 flex items-center justify-between">
      <div class="flex items-center gap-8">
        <a href="${baseURL}/main" class="text-2xl font-serif font-bold text-stage-secondary tracking-tighter">WIEVER</a>
        <nav class="hidden md:flex items-center gap-6">
          <a href="${baseURL}/musical-search" class="font-serif text-sm text-stage-secondary hover:text-stage-gold-glow transition-colors">Musical DB</a>
          <a href="${baseURL}/community" class="font-serif text-sm text-stage-secondary hover:text-stage-gold-glow transition-colors">Community</a>
          <a href="${baseURL}/community?type=Review" class="font-serif text-sm text-stage-secondary hover:text-stage-gold-glow transition-colors">Reviews</a>
        </nav>
      </div>
      <div class="flex items-center gap-5 text-stage-secondary">
        <a href="${baseURL}/musical-search" class="hover:text-stage-gold-glow transition-colors">
          <i class="bi bi-search text-xl"></i>
        </a>
        <a href="${baseURL}/mypage/myinfo" class="hover:text-stage-gold-glow transition-colors">
          <i class="bi bi-person-circle text-xl"></i>
        </a>
      </div>
    </div>
  </header>

  <!-- Hero Section -->
  <section class="relative h-[85vh] min-h-[600px] w-full flex items-center justify-center pt-16">
    <div class="absolute inset-0 z-0">
      <!-- The Phantom of the Opera Banner -->
      <img src="https://images.unsplash.com/photo-1514533440815-5ea5b60b7e28?auto=format&fit=crop&q=80&w=2000" 
           class="w-full h-full object-cover opacity-60 mix-blend-overlay" alt="The Phantom of the Opera">
      <div class="absolute inset-0 hero-overlay"></div>
    </div>
    
    <div class="relative z-10 max-w-4xl mx-auto px-6 text-center animate-up">
      <p class="text-stage-secondary font-serif text-sm tracking-[0.4em] uppercase mb-4 drop-shadow-lg">The Phantom of the Opera</p>
      <h1 class="text-5xl md:text-7xl font-serif font-bold leading-tight mb-6 tracking-tight text-white drop-shadow-[0_0_20px_rgba(212,175,55,0.4)]">
        오늘, 당신의 무대를 기록하다
      </h1>
      <p class="text-stage-text-sub text-lg font-light mb-10 max-w-2xl mx-auto">
        전 세계를 감동시킨 세기의 걸작, 무대 위의 전설이 다시 깨어난다. 당신의 가슴 속에 영원히 남을 단 하나의 무대.
      </p>
      <a href="${baseURL}/musical-detail/${performingMusicals[0].id}" class="inline-flex items-center justify-center gap-2 bg-stage-primary hover:bg-rose-800 text-white px-8 py-4 rounded-full font-bold text-lg transition-all shadow-[0_0_20px_rgba(190,18,60,0.5)]">
        <i class="bi bi-ticket-perforated"></i> 상세 정보 보기
      </a>
    </div>
  </section>

  <!-- Main Content Area -->
  <main class="max-w-7xl mx-auto px-6 space-y-24 mt-10 relative z-20">
    
    <!-- Content Grid: Now Showing -->
    <section class="animate-up" style="animation-delay: 0.2s;">
      <div class="flex items-end justify-between mb-8 border-b border-stage-secondary/20 pb-4">
        <div>
          <h2 class="text-3xl font-serif font-bold text-stage-secondary tracking-tight">Now Showing</h2>
          <p class="text-stage-text-sub text-sm mt-1">현재 상영 중인 작품을 만나보세요.</p>
        </div>
        <a href="${baseURL}/musical-search" class="text-stage-secondary hover:text-stage-gold-glow text-sm font-serif transition-colors">View All <i class="bi bi-chevron-right text-xs ml-1"></i></a>
      </div>
      
      <div class="swiper nowPlayingSwiper !overflow-visible">
        <div class="swiper-wrapper">
          <c:choose>
            <c:when test="${not empty performingMusicals}">
              <c:forEach var="musical" items="${performingMusicals}">
                <div class="swiper-slide w-48 md:w-60">
                  <a href="${baseURL}/musical-detail/${musical.id}" class="group block relative spotlight-glow rounded-xl overflow-hidden transition-all duration-500 border border-stage-secondary/30">
                    <div class="aspect-[2/3] w-full">
                      <img src="${musical.posterImage}" class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-700" alt="Musical">
                    </div>
                    <!-- Hover Overlay -->
                    <div class="absolute inset-0 bg-black/80 flex items-center justify-center opacity-0 group-hover:opacity-100 transition-opacity duration-300">
                      <div class="text-center">
                        <i class="bi bi-eye text-3xl text-stage-secondary mb-2 block drop-shadow-[0_0_10px_rgba(212,175,55,0.8)]"></i>
                        <span class="text-stage-secondary font-serif text-sm tracking-widest uppercase">View Details</span>
                      </div>
                    </div>
                  </a>
                </div>
              </c:forEach>
            </c:when>
            <c:otherwise>
              <!-- Skeleton Loading -->
              <c:forEach begin="1" end="5">
                <div class="swiper-slide w-48 md:w-60">
                  <div class="aspect-[2/3] rounded-xl bg-stage-surface border border-white/5 animate-pulse"></div>
                </div>
              </c:forEach>
            </c:otherwise>
          </c:choose>
        </div>
      </div>
    </section>

    <!-- Review Section -->
    <section class="animate-up" style="animation-delay: 0.4s;">
      <div class="flex items-end justify-between mb-8 border-b border-stage-secondary/20 pb-4">
        <div>
          <h2 class="text-3xl font-serif font-bold text-stage-secondary tracking-tight">Stage Reviews</h2>
          <p class="text-stage-text-sub text-sm mt-1">관객들이 직접 남긴 생생한 감동의 순간들.</p>
        </div>
      </div>

      <div class="swiper reviewSwiper !overflow-visible">
        <div class="swiper-wrapper">
          <!-- Dummy Reviews for Layout Purpose -->
          <div class="swiper-slide w-80">
            <div class="review-card p-6 rounded-2xl h-full flex flex-col justify-between">
              <div>
                <div class="flex text-stage-secondary text-sm mb-3">
                  <i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i>
                </div>
                <p class="text-stage-text text-sm leading-relaxed line-clamp-4 italic">"오페라의 유령, 그 이름만으로도 가슴이 벅차오르는 무대. 배우들의 압도적인 가창력과 화려한 샹들리에 연출에 눈을 뗄 수 없었습니다. 인생 최고의 경험!"</p>
              </div>
              <div class="mt-6 flex items-center gap-3">
                <img src="/img/Default_Profile.png" class="w-10 h-10 rounded-full border border-stage-secondary/50 object-cover" alt="Avatar">
                <div>
                  <p class="text-sm font-bold text-white">뮤지컬러버</p>
                  <p class="text-xs text-stage-text-sub">오페라의 유령</p>
                </div>
              </div>
            </div>
          </div>
          
          <div class="swiper-slide w-80">
            <div class="review-card p-6 rounded-2xl h-full flex flex-col justify-between">
              <div>
                <div class="flex text-stage-secondary text-sm mb-3">
                  <i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-half"></i>
                </div>
                <p class="text-stage-text text-sm leading-relaxed line-clamp-4 italic">"초반의 웅장한 넘버가 시작되는 순간 소름이 돋았습니다. 무대 장치와 조명 하나하나가 예술 그 자체였어요. 다음 티켓팅도 무조건 도전합니다."</p>
              </div>
              <div class="mt-6 flex items-center gap-3">
                <img src="/img/Default_Profile.png" class="w-10 h-10 rounded-full border border-stage-secondary/50 object-cover" alt="Avatar">
                <div>
                  <p class="text-sm font-bold text-white">PhantomFan</p>
                  <p class="text-xs text-stage-text-sub">오페라의 유령</p>
                </div>
              </div>
            </div>
          </div>

          <div class="swiper-slide w-80">
            <div class="review-card p-6 rounded-2xl h-full flex flex-col justify-between">
              <div>
                <div class="flex text-stage-secondary text-sm mb-3">
                  <i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i>
                </div>
                <p class="text-stage-text text-sm leading-relaxed line-clamp-4 italic">"배우들의 눈빛 연기와 절절한 목소리가 아직도 귓가에 맴돕니다. 위대한 극장에서 펼쳐진 최고의 공연에 찬사를 보냅니다."</p>
              </div>
              <div class="mt-6 flex items-center gap-3">
                <img src="/img/Default_Profile.png" class="w-10 h-10 rounded-full border border-stage-secondary/50 object-cover" alt="Avatar">
                <div>
                  <p class="text-sm font-bold text-white">Stageholic</p>
                  <p class="text-xs text-stage-text-sub">레베카</p>
                </div>
              </div>
            </div>
          </div>
          
        </div>
      </div>
    </section>

  </main>

  <!-- Bottom Navigation Mobile -->
  <div class="md:hidden fixed bottom-0 left-0 w-full z-50 glass-nav">
    <div class="flex items-center justify-around h-16 px-4">
      <a href="${baseURL}/main" class="flex flex-col items-center gap-1 text-stage-secondary">
        <i class="bi bi-house-door-fill text-xl"></i>
        <span class="text-[9px] font-bold">HOME</span>
      </a>
      <a href="${baseURL}/community" class="flex flex-col items-center gap-1 text-stage-text-sub hover:text-stage-secondary transition-colors">
        <i class="bi bi-chat-right-text-fill text-xl"></i>
        <span class="text-[9px] font-bold">COMMUNITY</span>
      </a>
      <a href="${baseURL}/mypage/myinfo" class="flex flex-col items-center gap-1 text-stage-text-sub hover:text-stage-secondary transition-colors">
        <i class="bi bi-person-circle text-xl"></i>
        <span class="text-[9px] font-bold">MY PAGE</span>
      </a>
    </div>
  </div>

  <footer class="mt-32 mb-10 text-center opacity-50">
    <p class="text-[10px] font-serif font-bold tracking-[0.4em] uppercase text-stage-secondary">© Weiver 2023. THE STAGE IS YOURS.</p>
  </footer>

  <script>
    document.addEventListener('DOMContentLoaded', function() {
      new Swiper('.nowPlayingSwiper', {
        slidesPerView: 'auto',
        spaceBetween: 24,
        freeMode: true,
        grabCursor: true,
      });

      new Swiper('.reviewSwiper', {
        slidesPerView: 'auto',
        spaceBetween: 20,
        freeMode: true,
        grabCursor: true,
      });
    });
  </script>

</body>
</html>