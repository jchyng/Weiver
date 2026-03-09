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

    .spotlight-glow:hover {
      box-shadow: 0 0 15px rgba(212, 175, 55, 0.3);
      border-color: rgba(212, 175, 55, 0.8);
    }

    .review-card {
      background: #1a1a1a;
      border: 1px solid rgba(212, 175, 55, 0.3);
    }

    .swiper-slide { width: auto; }

    /* Hero background animation */
    @keyframes heroShift {
      0%, 100% { transform: scale(1.05) translateX(0); }
      50% { transform: scale(1.1) translateX(-2%); }
    }
    .hero-bg-animate {
      animation: heroShift 20s ease-in-out infinite;
    }

    /* Spotlight radial glow */
    .hero-spotlight {
      background:
        radial-gradient(ellipse 60% 50% at 50% 40%, rgba(212,175,55,0.06) 0%, transparent 70%),
        radial-gradient(ellipse 80% 60% at 50% 100%, rgba(0,0,0,1) 0%, transparent 60%),
        linear-gradient(to bottom, rgba(0,0,0,0.3) 0%, rgba(0,0,0,0.6) 50%, rgba(0,0,0,1) 100%);
    }

    @keyframes fadeInUp {
      from { opacity: 0; transform: translateY(20px); }
      to { opacity: 1; transform: translateY(0); }
    }
    .animate-up { animation: fadeInUp 0.8s cubic-bezier(0.2, 0.8, 0.2, 1) forwards; opacity: 0; }

    .search-glow:focus-within {
      box-shadow: 0 0 20px rgba(212, 175, 55, 0.15);
      border-color: rgba(212, 175, 55, 0.6);
    }

    .post-card {
      background: rgba(26, 26, 26, 0.8);
      border: 1px solid rgba(212, 175, 55, 0.15);
      transition: all 0.3s ease;
    }
    .post-card:hover {
      border-color: rgba(212, 175, 55, 0.5);
      background: rgba(26, 26, 26, 1);
    }

    .actor-card {
      background: linear-gradient(135deg, rgba(26,26,26,0.9) 0%, rgba(10,10,10,0.95) 100%);
      border: 1px solid rgba(212, 175, 55, 0.2);
    }
  </style>
</head>

<body class="text-stage-text antialiased pb-32">

  <!-- Top Navigation -->
  <header class="fixed top-0 left-0 w-full z-[100] glass-nav">
    <div class="max-w-7xl mx-auto px-6 h-16 flex items-center justify-between">
      <div class="flex items-center gap-8">
        <a href="${baseURL}/" class="text-2xl font-serif font-bold text-stage-secondary tracking-tighter">WIEVER</a>
        <nav class="hidden md:flex items-center gap-6">
          <a href="${baseURL}/musical-search" class="font-serif text-sm text-stage-secondary hover:text-stage-gold-glow transition-colors">Musical DB</a>
          <a href="${baseURL}/community" class="font-serif text-sm text-stage-secondary hover:text-stage-gold-glow transition-colors">Community</a>
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

  <!-- Hero Section - Featured Spotlight -->
  <section class="relative w-full pt-16 overflow-hidden" style="min-height: min(70vh, 560px);">
    <!-- Dark Background -->
    <div class="absolute inset-0 z-0 bg-black">
      <div class="absolute inset-0 hero-spotlight"></div>
    </div>

    <div class="relative z-10 flex flex-col items-center justify-center px-6 text-center" style="min-height: min(calc(70vh - 64px), 496px);">
      <!-- Brand Mark -->
      <div class="animate-up" style="animation-delay: 0.1s;">
        <p class="text-stage-secondary/60 font-serif text-xs tracking-[0.5em] uppercase mb-5">Musical Review Platform</p>
        <h1 class="font-serif font-bold tracking-tight text-white drop-shadow-[0_2px_30px_rgba(0,0,0,0.8)]"
            style="font-size: clamp(2.2rem, 6vw, 4.5rem); line-height: 1.1; white-space: nowrap;">
          THE STAGE IS YOURS
        </h1>
        <p class="text-stage-text-sub text-base md:text-lg font-light mt-4 max-w-lg mx-auto leading-relaxed">
          보고, 느끼고, 기록하세요.<br class="md:hidden"> 당신만의 뮤지컬 이야기가 시작됩니다.
        </p>
      </div>

      <!-- Search Bar -->
      <div class="animate-up mt-8 w-full max-w-xl" style="animation-delay: 0.3s;">
        <form action="${baseURL}/musical-search" method="get"
              class="search-glow flex items-center bg-black/60 backdrop-blur-md border border-white/15 rounded-full px-5 py-3 transition-all duration-300">
          <i class="bi bi-search text-stage-secondary/70 text-lg mr-3"></i>
          <input type="text" name="keyword" placeholder="뮤지컬 제목, 배우를 검색해보세요"
                 class="flex-1 bg-transparent text-stage-text placeholder-stage-text-sub/50 text-sm md:text-base outline-none">
          <button type="submit" class="ml-2 bg-stage-primary hover:bg-rose-800 text-white px-5 py-2 rounded-full text-sm font-bold transition-colors">
            검색
          </button>
        </form>
      </div>

      <!-- Quick Tags -->
      <div class="animate-up mt-5 flex flex-wrap justify-center gap-2" style="animation-delay: 0.45s;">
        <a href="${baseURL}/musical-search?keyword=오페라의 유령" class="px-3 py-1.5 rounded-full border border-white/10 bg-white/5 text-stage-text-sub text-xs hover:border-stage-secondary/50 hover:text-stage-secondary transition-all">#오페라의유령</a>
        <a href="${baseURL}/musical-search?keyword=레미제라블" class="px-3 py-1.5 rounded-full border border-white/10 bg-white/5 text-stage-text-sub text-xs hover:border-stage-secondary/50 hover:text-stage-secondary transition-all">#레미제라블</a>
        <a href="${baseURL}/musical-search?keyword=위키드" class="px-3 py-1.5 rounded-full border border-white/10 bg-white/5 text-stage-text-sub text-xs hover:border-stage-secondary/50 hover:text-stage-secondary transition-all">#위키드</a>
        <a href="${baseURL}/community" class="px-3 py-1.5 rounded-full border border-white/10 bg-white/5 text-stage-text-sub text-xs hover:border-stage-secondary/50 hover:text-stage-secondary transition-all">#커뮤니티</a>
      </div>
    </div>
  </section>

  <!-- Main Content Area -->
  <main class="max-w-7xl mx-auto px-6 space-y-20 mt-6 relative z-20">

    <!-- Now Showing -->
    <section class="animate-up" style="animation-delay: 0.2s;">
      <div class="flex items-end justify-between mb-8 border-b border-stage-secondary/20 pb-4">
        <div>
          <h2 class="text-2xl md:text-3xl font-serif font-bold text-stage-secondary tracking-tight">Now Showing</h2>
          <p class="text-stage-text-sub text-sm mt-1">현재 공연 중인 작품</p>
        </div>
        <a href="${baseURL}/musical-search" class="text-stage-secondary hover:text-stage-gold-glow text-sm font-serif transition-colors">View All <i class="bi bi-chevron-right text-xs ml-1"></i></a>
      </div>

      <div class="swiper nowPlayingSwiper !overflow-visible">
        <div class="swiper-wrapper">
          <c:choose>
            <c:when test="${not empty performingMusicals}">
              <c:forEach var="musical" items="${performingMusicals}">
                <div class="swiper-slide w-40 md:w-52">
                  <a href="${baseURL}/musical-detail/${musical.id}" class="group block relative spotlight-glow rounded-xl overflow-hidden transition-all duration-500 border border-stage-secondary/20">
                    <div class="aspect-[2/3] w-full">
                      <img src="${musical.posterImage}" class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-700" alt="Musical" loading="lazy">
                    </div>
                    <div class="absolute inset-0 bg-black/80 flex items-center justify-center opacity-0 group-hover:opacity-100 transition-opacity duration-300">
                      <div class="text-center">
                        <i class="bi bi-eye text-2xl text-stage-secondary mb-1 block drop-shadow-[0_0_10px_rgba(212,175,55,0.8)]"></i>
                        <span class="text-stage-secondary font-serif text-xs tracking-widest uppercase">Details</span>
                      </div>
                    </div>
                  </a>
                </div>
              </c:forEach>
            </c:when>
            <c:otherwise>
              <c:forEach begin="1" end="6">
                <div class="swiper-slide w-40 md:w-52">
                  <div class="aspect-[2/3] rounded-xl bg-stage-surface border border-white/5 animate-pulse"></div>
                </div>
              </c:forEach>
            </c:otherwise>
          </c:choose>
        </div>
      </div>
    </section>

    <!-- Popular Musicals -->
    <c:if test="${not empty popularMusicals}">
    <section class="animate-up" style="animation-delay: 0.3s;">
      <div class="flex items-end justify-between mb-8 border-b border-stage-secondary/20 pb-4">
        <div>
          <h2 class="text-2xl md:text-3xl font-serif font-bold text-stage-secondary tracking-tight">Popular</h2>
          <p class="text-stage-text-sub text-sm mt-1">관객들이 가장 많이 찾는 작품</p>
        </div>
      </div>

      <div class="swiper popularSwiper !overflow-visible">
        <div class="swiper-wrapper">
          <c:forEach var="pm" items="${popularMusicals}" varStatus="rank">
            <div class="swiper-slide w-40 md:w-52">
              <a href="${baseURL}/musical-detail/${pm.id}" class="group block relative spotlight-glow rounded-xl overflow-hidden transition-all duration-500 border border-stage-secondary/20">
                <div class="aspect-[2/3] w-full relative">
                  <img src="${pm.posterImage}" class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-700" alt="${pm.title}" loading="lazy">
                  <!-- Rank Badge -->
                  <div class="absolute top-2 left-2 w-8 h-8 rounded-full bg-stage-primary flex items-center justify-center text-white text-xs font-bold shadow-lg">
                    ${rank.index + 1}
                  </div>
                  <!-- Bottom gradient with title -->
                  <div class="absolute bottom-0 left-0 right-0 bg-gradient-to-t from-black/90 via-black/40 to-transparent p-3 pt-8">
                    <p class="text-white text-xs font-bold truncate">${pm.title}</p>
                  </div>
                </div>
                <div class="absolute inset-0 bg-black/80 flex items-center justify-center opacity-0 group-hover:opacity-100 transition-opacity duration-300">
                  <div class="text-center">
                    <i class="bi bi-eye text-2xl text-stage-secondary mb-1 block drop-shadow-[0_0_10px_rgba(212,175,55,0.8)]"></i>
                    <span class="text-stage-secondary font-serif text-xs tracking-widest uppercase">Details</span>
                  </div>
                </div>
              </a>
            </div>
          </c:forEach>
        </div>
      </div>
    </section>
    </c:if>

    <!-- Today's Actor Spotlight -->
    <c:if test="${not empty randomActor}">
    <section class="animate-up" style="animation-delay: 0.4s;">
      <div class="flex items-end justify-between mb-8 border-b border-stage-secondary/20 pb-4">
        <div>
          <h2 class="text-2xl md:text-3xl font-serif font-bold text-stage-secondary tracking-tight">Today's Spotlight</h2>
          <p class="text-stage-text-sub text-sm mt-1">오늘의 추천 배우</p>
        </div>
      </div>

      <div class="actor-card rounded-2xl p-6 md:p-8">
        <div class="flex flex-col md:flex-row gap-6 items-start">
          <!-- Actor Info -->
          <a href="${baseURL}/actor-detail/${randomActor.id}" class="flex items-center gap-4 group shrink-0">
            <div class="w-20 h-20 md:w-24 md:h-24 rounded-full overflow-hidden border-2 border-stage-secondary/40 group-hover:border-stage-secondary transition-colors">
              <img src="${randomActor.profileImage}" class="w-full h-full object-cover" alt="${randomActor.name}"
                   onerror="this.src='/img/Default_Profile.png'">
            </div>
            <div>
              <p class="text-xl md:text-2xl font-bold text-white group-hover:text-stage-secondary transition-colors">${randomActor.name}</p>
              <p class="text-stage-text-sub text-sm mt-1">프로필 보기 <i class="bi bi-chevron-right text-xs"></i></p>
            </div>
          </a>

          <!-- Actor's Musicals -->
          <c:if test="${not empty limitedMusicalList}">
          <div class="flex-1 w-full overflow-x-auto">
            <div class="flex gap-3 pb-2">
              <c:forEach var="am" items="${limitedMusicalList}">
                <a href="${baseURL}/musical-detail/${am.id}" class="shrink-0 w-24 md:w-28 spotlight-glow rounded-lg overflow-hidden border border-stage-secondary/20 transition-all duration-300 block">
                  <div class="aspect-[2/3]">
                    <img src="${am.posterImage}" class="w-full h-full object-cover hover:scale-105 transition-transform duration-500" alt="Musical" loading="lazy">
                  </div>
                </a>
              </c:forEach>
            </div>
          </div>
          </c:if>
        </div>
      </div>
    </section>
    </c:if>

    <!-- Hot Posts from Community -->
    <c:if test="${not empty bestPost}">
    <section class="animate-up" style="animation-delay: 0.5s;">
      <div class="flex items-end justify-between mb-8 border-b border-stage-secondary/20 pb-4">
        <div>
          <h2 class="text-2xl md:text-3xl font-serif font-bold text-stage-secondary tracking-tight">Hot Posts</h2>
          <p class="text-stage-text-sub text-sm mt-1">커뮤니티 인기 게시글</p>
        </div>
        <a href="${baseURL}/community" class="text-stage-secondary hover:text-stage-gold-glow text-sm font-serif transition-colors">View All <i class="bi bi-chevron-right text-xs ml-1"></i></a>
      </div>

      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
        <c:forEach var="post" items="${bestPost}" end="5">
          <a href="${baseURL}/community/${post.id}" class="post-card rounded-xl p-5 block group">
            <div class="flex items-start justify-between gap-3">
              <div class="flex-1 min-w-0">
                <c:if test="${not empty post.type}">
                  <span class="inline-block px-2 py-0.5 rounded text-[10px] font-bold mb-2
                    ${post.type == 'Review' ? 'bg-stage-primary/20 text-stage-primary' : 'bg-stage-secondary/20 text-stage-secondary'}">
                    ${post.type}
                  </span>
                </c:if>
                <h3 class="text-sm font-bold text-white truncate group-hover:text-stage-secondary transition-colors">${post.title}</h3>
                <p class="text-stage-text-sub text-xs mt-1.5 line-clamp-2">${post.content}</p>
              </div>
              <c:if test="${not empty post.image}">
                <div class="w-16 h-16 rounded-lg overflow-hidden shrink-0 border border-white/10">
                  <img src="${post.image}" class="w-full h-full object-cover" alt="" loading="lazy">
                </div>
              </c:if>
            </div>
            <div class="flex items-center gap-4 mt-3 text-stage-text-sub text-[11px]">
              <span><i class="bi bi-eye-fill mr-1"></i>${post.viewed}</span>
            </div>
          </a>
        </c:forEach>
      </div>
    </section>
    </c:if>

    <!-- Stage Reviews -->
    <section class="animate-up" style="animation-delay: 0.6s;">
      <div class="flex items-end justify-between mb-8 border-b border-stage-secondary/20 pb-4">
        <div>
          <h2 class="text-2xl md:text-3xl font-serif font-bold text-stage-secondary tracking-tight">Stage Reviews</h2>
          <p class="text-stage-text-sub text-sm mt-1">관객들의 생생한 감동</p>
        </div>
      </div>

      <div class="swiper reviewSwiper !overflow-visible">
        <div class="swiper-wrapper">
          <div class="swiper-slide w-72 md:w-80">
            <div class="review-card p-5 rounded-2xl h-full flex flex-col justify-between">
              <div>
                <div class="flex text-stage-secondary text-xs mb-3 gap-0.5">
                  <i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i>
                </div>
                <p class="text-stage-text text-sm leading-relaxed line-clamp-4 italic">"배우들의 압도적인 가창력과 화려한 샹들리에 연출에 눈을 뗄 수 없었습니다. 인생 최고의 뮤지컬 경험이었어요."</p>
              </div>
              <div class="mt-5 flex items-center gap-3">
                <img src="/img/Default_Profile.png" class="w-9 h-9 rounded-full border border-stage-secondary/40 object-cover" alt="Avatar">
                <div>
                  <p class="text-xs font-bold text-white">뮤지컬러버</p>
                  <p class="text-[10px] text-stage-text-sub">오페라의 유령</p>
                </div>
              </div>
            </div>
          </div>

          <div class="swiper-slide w-72 md:w-80">
            <div class="review-card p-5 rounded-2xl h-full flex flex-col justify-between">
              <div>
                <div class="flex text-stage-secondary text-xs mb-3 gap-0.5">
                  <i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-half"></i>
                </div>
                <p class="text-stage-text text-sm leading-relaxed line-clamp-4 italic">"웅장한 넘버가 시작되는 순간 소름이 돋았습니다. 무대 장치와 조명이 예술 그 자체. 다음 티켓팅도 무조건 도전!"</p>
              </div>
              <div class="mt-5 flex items-center gap-3">
                <img src="/img/Default_Profile.png" class="w-9 h-9 rounded-full border border-stage-secondary/40 object-cover" alt="Avatar">
                <div>
                  <p class="text-xs font-bold text-white">PhantomFan</p>
                  <p class="text-[10px] text-stage-text-sub">오페라의 유령</p>
                </div>
              </div>
            </div>
          </div>

          <div class="swiper-slide w-72 md:w-80">
            <div class="review-card p-5 rounded-2xl h-full flex flex-col justify-between">
              <div>
                <div class="flex text-stage-secondary text-xs mb-3 gap-0.5">
                  <i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i>
                </div>
                <p class="text-stage-text text-sm leading-relaxed line-clamp-4 italic">"배우들의 절절한 목소리가 아직도 귓가에 맴돕니다. 위대한 극장에서 펼쳐진 최고의 공연에 찬사를 보냅니다."</p>
              </div>
              <div class="mt-5 flex items-center gap-3">
                <img src="/img/Default_Profile.png" class="w-9 h-9 rounded-full border border-stage-secondary/40 object-cover" alt="Avatar">
                <div>
                  <p class="text-xs font-bold text-white">Stageholic</p>
                  <p class="text-[10px] text-stage-text-sub">레베카</p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

  </main>

  <footer class="mt-24 mb-10 text-center opacity-50">
    <p class="text-[10px] font-serif font-bold tracking-[0.4em] uppercase text-stage-secondary">&copy; Weiver 2023. THE STAGE IS YOURS.</p>
  </footer>

  <script>
    document.addEventListener('DOMContentLoaded', function() {
      // Now Showing carousel
      new Swiper('.nowPlayingSwiper', {
        slidesPerView: 'auto',
        spaceBetween: 16,
        freeMode: true,
        grabCursor: true,
      });

      // Popular carousel
      if (document.querySelector('.popularSwiper')) {
        new Swiper('.popularSwiper', {
          slidesPerView: 'auto',
          spaceBetween: 16,
          freeMode: true,
          grabCursor: true,
        });
      }

      // Review carousel
      new Swiper('.reviewSwiper', {
        slidesPerView: 'auto',
        spaceBetween: 16,
        freeMode: true,
        grabCursor: true,
      });

      // Intersection Observer for scroll animations
      const observer = new IntersectionObserver(function(entries) {
        entries.forEach(function(entry) {
          if (entry.isIntersecting) {
            entry.target.style.animationPlayState = 'running';
            observer.unobserve(entry.target);
          }
        });
      }, { threshold: 0.1 });

      document.querySelectorAll('.animate-up').forEach(function(el) {
        el.style.animationPlayState = 'paused';
        observer.observe(el);
      });
    });
  </script>

</body>
</html>
