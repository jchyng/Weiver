<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="config.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>WIEVER - ${musical.title}</title>

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

    <!-- Fonts & Icons -->
    <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.8/dist/web/static/pretendard.css" />
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&family=Cinzel:wght@600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

    <!-- SWIPER -->
    <link rel="stylesheet" href="https://unpkg.com/swiper@8/swiper-bundle.min.css" />
    <script src="https://unpkg.com/swiper@8/swiper-bundle.min.js"></script>
    
    <!-- jquery -->
    <script src="http://code.jquery.com/jquery-latest.js"></script>

    <style>
      body {
        background: linear-gradient(180deg, #0f0f0f 0%, #000000 100%);
        min-height: 100vh;
      }
      .glass-nav {
        background: rgba(0, 0, 0, 0.4);
        backdrop-filter: blur(12px);
        -webkit-backdrop-filter: blur(12px);
        border-bottom: 1px solid rgba(212, 175, 55, 0.2);
      }
      .poster-shadow {
        box-shadow: 0 20px 50px rgba(0,0,0,0.8), 0 0 30px rgba(212,175,55,0.2);
      }
      .metadata-icon {
        color: #D4AF37;
        margin-right: 0.5rem;
      }
      .review-forum-card {
        background: #1a1a1a;
        border: 1px solid rgba(212, 175, 55, 0.3);
        box-shadow: inset 0 0 20px rgba(0,0,0,0.5);
      }
      .subscribed {
        color: #D4AF37 !important;
        transform: scale(1.1);
      }
    </style>
</head>

<body class="text-stage-text font-sans pb-24">

  <!-- Header -->
  <header class="fixed top-0 left-0 w-full z-50 glass-nav">
    <div class="max-w-7xl mx-auto px-6 h-16 flex items-center justify-between">
      <div class="flex items-center gap-4">
        <a href="javascript:history.back();" class="text-2xl text-stage-secondary hover:text-stage-gold-glow transition-colors">
          <i class="bi bi-chevron-left"></i>
        </a>
        <span class="text-xl font-serif text-stage-secondary tracking-tighter">WIEVER</span>
      </div>
      <div class="w-8"></div>
    </div>
  </header>

  <!-- Hero Section -->
  <section class="relative pt-28 pb-16 px-6">
    <div class="absolute inset-0 z-0">
      <img src="${musical.posterImage}" class="w-full h-full object-cover blur-3xl opacity-10" alt="bg">
      <div class="absolute inset-0 bg-gradient-to-b from-transparent via-black/80 to-black"></div>
    </div>

    <div class="relative z-10 max-w-6xl mx-auto flex flex-col md:flex-row gap-12 items-start">
      <!-- Left side: Large high-res musical poster -->
      <div class="w-full md:w-1/3 flex justify-center md:justify-end shrink-0">
        <div class="w-64 md:w-80 aspect-[2/3] rounded-sm overflow-hidden poster-shadow border border-stage-secondary/20 bg-stage-surface">
          <img src="${musical.posterImage}" class="w-full h-full object-cover" alt="${musical.title}">
        </div>
      </div>

      <!-- Right side: Organized metadata -->
      <div class="w-full md:w-2/3 space-y-8 pt-4">
        <div>
          <h1 class="text-4xl md:text-5xl font-bold mb-4 leading-tight text-white drop-shadow-md">${musical.title}</h1>
          <p class="text-stage-text-sub text-lg font-light tracking-wide flex items-center">
            <i class="bi bi-geo-alt-fill metadata-icon"></i> ${musical.theater}
          </p>
        </div>

        <div class="grid grid-cols-1 sm:grid-cols-2 gap-6 text-sm">
          <c:if test="${not empty musical.stDate}">
            <div class="flex items-start gap-3">
              <i class="bi bi-calendar-event metadata-icon text-xl"></i>
              <div class="flex flex-col gap-1">
                <span class="text-stage-text-sub uppercase text-xs font-bold tracking-widest">공연 기간</span>
                <span class="font-medium text-white text-base">
                  <fmt:formatDate value="${musical.stDate}" pattern="yyyy.MM.dd" /> ~
                  <fmt:formatDate value="${musical.edDate}" pattern="yyyy.MM.dd" />
                </span>
              </div>
            </div>
          </c:if>
          <c:if test="${not empty musical.runningTime}">
            <div class="flex items-start gap-3">
              <i class="bi bi-clock-history metadata-icon text-xl"></i>
              <div class="flex flex-col gap-1">
                <span class="text-stage-text-sub uppercase text-xs font-bold tracking-widest">러닝 타임</span>
                <span class="font-medium text-white text-base">${musical.runningTime}</span>
              </div>
            </div>
          </c:if>
          <c:if test="${not empty musical.viewAge}">
            <div class="flex items-start gap-3">
              <i class="bi bi-person-badge metadata-icon text-xl"></i>
              <div class="flex flex-col gap-1">
                <span class="text-stage-text-sub uppercase text-xs font-bold tracking-widest">관람 연령</span>
                <span class="font-medium text-white text-base">${musical.viewAge}</span>
              </div>
            </div>
          </c:if>
        </div>

        <!-- Casting Compact View -->
        <c:if test="${not empty castingList}">
          <div>
            <span class="text-stage-text-sub uppercase text-xs font-bold tracking-widest mb-3 block"><i class="bi bi-people-fill metadata-icon"></i>주요 출연진</span>
            <div class="flex flex-wrap gap-4">
              <c:forEach items="${castingList}" var="casting" end="4">
                <a href="${baseURL}/actorDetail/${casting.id}" class="flex items-center gap-2 bg-stage-surface/50 border border-white/10 pr-4 rounded-full hover:border-stage-secondary transition-colors">
                  <img src="${casting.profileImage}" class="w-8 h-8 rounded-full object-cover bg-stage-bg" alt="${casting.name}">
                  <span class="text-sm font-medium text-white">${casting.name}</span>
                </a>
              </c:forEach>
              <c:if test="${castingList.size() > 5}">
                <button class="flex items-center gap-2 bg-stage-surface/50 border border-white/10 px-4 rounded-full text-sm hover:text-stage-secondary transition-colors h-8">
                  + 더보기
                </button>
              </c:if>
            </div>
          </div>
        </c:if>

        <!-- Action Buttons -->
        <div class="flex gap-4 pt-4 border-t border-stage-secondary/20">
          <button onclick="addSubscirbe('${musical.id}', '찜했어요')" class="group flex-1 md:flex-none flex items-center justify-center gap-2 bg-transparent hover:bg-stage-secondary/10 px-8 py-3 rounded-sm border border-stage-secondary transition-all active:scale-[0.98]">
            <i class="bi bi-bookmark-star icon1 text-stage-secondary text-lg"></i>
            <span class="font-bold text-stage-secondary tracking-widest">찜하기</span>
          </button>
          <button onclick="addSubscirbe('${musical.id}', '봤어요')" class="group flex-1 md:flex-none flex items-center justify-center gap-2 bg-transparent hover:bg-stage-secondary/10 px-8 py-3 rounded-sm border border-stage-secondary transition-all active:scale-[0.98]">
            <i class="bi bi-check2-circle icon2 text-stage-secondary text-lg"></i>
            <span class="font-bold text-stage-secondary tracking-widest">봤어요</span>
          </button>
        </div>
      </div>
    </div>
  </section>

  <main class="max-w-6xl mx-auto px-6 space-y-16 mt-10">
    
    <!-- User Reviews Area -->
    <section>
      <div class="flex items-end justify-between border-b border-stage-secondary/30 pb-4 mb-8">
        <div>
          <h2 class="text-3xl font-serif font-bold text-stage-secondary">Stage Reviews</h2>
          <p class="text-stage-text-sub text-sm mt-1">관객들의 생생한 리뷰를 확인하세요.</p>
        </div>
        <!-- Write Review Button -->
        <a href="${baseURL}/community?type=Review" class="bg-stage-primary hover:bg-rose-800 text-white px-6 py-2.5 rounded-sm font-bold text-sm transition-all shadow-[0_0_15px_rgba(190,18,60,0.4)] flex items-center gap-2">
          <i class="bi bi-pencil-square"></i> 리뷰 작성
        </a>
      </div>

      <div class="space-y-4">
        <!-- Static review cards for layout demo -->
        <div class="review-forum-card p-6 rounded-md flex gap-6">
          <div class="shrink-0 flex flex-col items-center gap-2 w-20">
            <img src="/img/Default_Profile.png" class="w-12 h-12 rounded-full border border-stage-secondary object-cover bg-stage-bg" alt="user">
            <span class="text-xs font-bold text-center break-all text-stage-text-sub">뮤지컬매니아</span>
          </div>
          <div class="flex-1">
            <div class="flex justify-between items-start mb-2">
              <div class="flex text-stage-secondary text-xs">
                <i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i>
              </div>
              <span class="text-xs text-stage-text-sub">2023.10.15</span>
            </div>
            <h4 class="font-bold text-white mb-2 text-lg">최고의 무대였습니다!</h4>
            <p class="text-sm text-stage-text-sub leading-relaxed">
              무대 장치와 조명, 배우들의 연기까지 모든 것이 완벽했습니다. 좌석이 조금 멀었지만 오페라 글라스를 챙겨가서 표정 연기까지 놓치지 않고 볼 수 있었어요.
            </p>
          </div>
        </div>

        <div class="review-forum-card p-6 rounded-md flex gap-6">
          <div class="shrink-0 flex flex-col items-center gap-2 w-20">
            <img src="/img/Default_Profile.png" class="w-12 h-12 rounded-full border border-stage-secondary object-cover bg-stage-bg" alt="user">
            <span class="text-xs font-bold text-center break-all text-stage-text-sub">StageLover</span>
          </div>
          <div class="flex-1">
            <div class="flex justify-between items-start mb-2">
              <div class="flex text-stage-secondary text-xs">
                <i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-half"></i>
              </div>
              <span class="text-xs text-stage-text-sub">2023.10.12</span>
            </div>
            <h4 class="font-bold text-white mb-2 text-lg">음향이 아쉬웠지만 배우들이 하드캐리</h4>
            <p class="text-sm text-stage-text-sub leading-relaxed">
              극장의 음향 시스템이 약간 울리는 감이 있었지만, 주연 배우의 압도적인 성량으로 극복해냈습니다. 앙상블 합창도 훌륭했어요.
            </p>
          </div>
        </div>

        <div class="text-center mt-6">
          <a href="${baseURL}/community" class="inline-block text-stage-secondary hover:text-stage-gold-glow text-sm font-bold border-b border-stage-secondary pb-1 transition-colors">리뷰 더보기</a>
        </div>
      </div>
    </section>

  </main>

  <!-- Bottom Nav Mobile -->
  <div class="md:hidden fixed bottom-0 left-0 w-full z-50 glass-nav">
    <div class="flex items-center justify-around h-16 px-4">
      <a href="${baseURL}/main" class="flex flex-col items-center gap-1 text-stage-text-sub hover:text-stage-secondary transition-colors">
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
    let isSubscribed1 = false;
    let isSubscribed2 = false;

    $(document).ready(function() {
      isSubscribed1 = ${not empty subscribeJjim ? "true" : "false"};
      isSubscribed2 = ${not empty subscribeWatched ? "true" : "false"};
      
      if(isSubscribed1) {
        $('.icon1').removeClass('bi-bookmark-star').addClass('bi-bookmark-star-fill subscribed');
      }
      if(isSubscribed2) {
        $('.icon2').removeClass('bi-check2-circle').addClass('bi-check-circle-fill subscribed');
      }
    });

    function addSubscirbe(musicalId, type) {
      $.ajax({
        type: 'GET',
        url: '${baseURL}/addSubscribe/' + musicalId + "/" + type,
        success: function () {
          if (type === '찜했어요') {
            isSubscribed1 = !isSubscribed1;
            if(isSubscribed1) {
              $('.icon1').removeClass('bi-bookmark-star').addClass('bi-bookmark-star-fill subscribed');
            } else {
              $('.icon1').removeClass('bi-bookmark-star-fill subscribed').addClass('bi-bookmark-star');
            }
          } else if (type === '봤어요') {
            isSubscribed2 = !isSubscribed2;
            if(isSubscribed2) {
              $('.icon2').removeClass('bi-check2-circle').addClass('bi-check-circle-fill subscribed');
            } else {
              $('.icon2').removeClass('bi-check-circle-fill subscribed').addClass('bi-check2-circle');
            }
          }
        },
        error: function () {
          window.location.href = "${baseURL}/login";
        }
      });
    }
  </script>
</body>
</html>