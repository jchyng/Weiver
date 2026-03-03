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
              'stage-secondary': '#FBBF24',
              'stage-bg': '#0F172A',
              'stage-surface': '#1E293B',
              'stage-text': '#F8FAFC',
              'stage-text-sub': '#94A3B8',
            },
            fontFamily: {
              sans: ['Pretendard', 'sans-serif'],
              serif: ['Playfair Display', 'serif'],
            },
          }
        }
      }
    </script>

    <!-- Fonts & Icons -->
    <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.8/dist/web/static/pretendard.css" />
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

    <!-- SWIPER -->
    <link rel="stylesheet" href="https://unpkg.com/swiper@8/swiper-bundle.min.css" />
    <script src="https://unpkg.com/swiper@8/swiper-bundle.min.js"></script>
    
    <!-- jquery -->
    <script src="http://code.jquery.com/jquery-latest.js"></script>

    <style>
      .glass-nav {
        background: rgba(15, 23, 42, 0.7);
        backdrop-filter: blur(12px);
        -webkit-backdrop-filter: blur(12px);
        border-bottom: 1px solid rgba(255, 255, 255, 0.1);
      }
      .spotlight-glow:hover {
        box-shadow: 0 0 20px rgba(251, 191, 36, 0.3);
      }
      .subscribed {
        color: var(--stage-secondary) !important;
        transform: scale(1.1);
      }
    </style>
</head>

<body class="bg-stage-bg text-stage-text font-sans pb-24">

  <!-- Header -->
  <header class="fixed top-0 left-0 w-full z-50 glass-nav">
    <div class="max-w-7xl mx-auto px-4 h-16 flex items-center justify-between">
      <a href="javascript:history.back();" class="text-2xl hover:text-stage-secondary transition-colors">
        <i class="bi bi-chevron-left"></i>
      </a>
      <span class="text-xl font-serif text-stage-primary tracking-tighter">WIEVER</span>
      <div class="w-8"></div> <!-- Spacer -->
    </div>
  </header>

  <!-- Hero Section -->
  <section class="relative pt-24 pb-12 px-6 overflow-hidden">
    <!-- Blurry Background Poster -->
    <div class="absolute inset-0 z-0">
      <img src="${musical.posterImage}" class="w-full h-full object-cover blur-3xl opacity-20 scale-110" alt="bg">
      <div class="absolute inset-0 bg-gradient-to-b from-stage-bg/50 via-stage-bg to-stage-bg"></div>
    </div>

    <div class="relative z-10 max-w-5xl mx-auto flex flex-col md:flex-row gap-8 items-center md:items-start text-center md:text-left">
      <!-- Main Poster -->
      <div class="w-48 md:w-64 aspect-[3/4] rounded-2xl overflow-hidden shadow-2xl border border-white/10 transform transition-transform hover:scale-105 duration-500">
        <img src="${musical.posterImage}" class="w-full h-full object-cover" alt="${musical.title}">
      </div>

      <!-- Musical Main Info -->
      <div class="flex-1 space-y-6">
        <div>
          <h1 class="text-3xl md:text-5xl font-bold mb-2 leading-tight">${musical.title}</h1>
          <p class="text-stage-secondary font-medium tracking-wide"><i class="bi bi-geo-alt-fill"></i> ${musical.theater}</p>
        </div>

        <div class="grid grid-cols-1 sm:grid-cols-2 gap-4 text-sm bg-stage-surface/40 backdrop-blur-md p-6 rounded-2xl border border-white/5">
          <c:if test="${not empty musical.stDate}">
            <div class="flex flex-col gap-1">
              <span class="text-stage-text-sub uppercase text-[10px] font-bold tracking-widest">공연 기간</span>
              <span class="font-medium">
                <fmt:formatDate value="${musical.stDate}" pattern="yyyy.MM.dd" /> ~
                <fmt:formatDate value="${musical.edDate}" pattern="yyyy.MM.dd" />
              </span>
            </div>
          </c:if>
          <c:if test="${not empty musical.runningTime}">
            <div class="flex flex-col gap-1">
              <span class="text-stage-text-sub uppercase text-[10px] font-bold tracking-widest">러닝 타임</span>
              <span class="font-medium">${musical.runningTime}</span>
            </div>
          </c:if>
          <c:if test="${not empty musical.viewAge}">
            <div class="flex flex-col gap-1">
              <span class="text-stage-text-sub uppercase text-[10px] font-bold tracking-widest">관람 연령</span>
              <span class="font-medium">${musical.viewAge}</span>
            </div>
          </c:if>
        </div>

        <!-- Action Buttons -->
        <div class="flex gap-4 justify-center md:justify-start">
          <button onclick="addSubscirbe(${musical.id}, '찜했어요')" class="group flex items-center gap-2 bg-white/10 hover:bg-white/20 px-6 py-3 rounded-xl border border-white/10 transition-all active:scale-95">
            <i class="bi bi-bookmark-star-fill icon1 transition-all text-xl"></i>
            <span class="font-bold">찜하기</span>
          </button>
          <button onclick="addSubscirbe(${musical.id}, '봤어요')" class="group flex items-center gap-2 bg-stage-primary hover:bg-rose-700 px-6 py-3 rounded-xl shadow-lg shadow-rose-900/20 transition-all active:scale-95">
            <i class="bi bi-check-circle-fill icon2 transition-all text-xl"></i>
            <span class="font-bold text-white">봤어요</span>
          </button>
        </div>
      </div>
    </div>
  </section>

  <!-- Content Sections -->
  <main class="max-w-5xl mx-auto px-6 space-y-16">
    
    <!-- Casting Section -->
    <section>
      <h2 class="text-2xl font-bold mb-6 flex items-center gap-2">
        출연진 정보 <span class="text-stage-secondary">✨</span>
      </h2>
      <div class="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-6 gap-4">
        <c:forEach items="${castingList}" var="casting">
          <a href="${baseURL}/actorDetail/${casting.id}" class="group text-center">
            <div class="aspect-square rounded-full overflow-hidden border-2 border-slate-700 group-hover:border-stage-secondary transition-all mb-3 relative spotlight-glow">
              <img src="${casting.profileImage}" class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500" alt="${casting.name}">
            </div>
            <p class="font-bold text-sm group-hover:text-stage-secondary transition-colors">${casting.name}</p>
            <p class="text-[10px] text-stage-text-sub uppercase tracking-wider">${casting.role}</p>
          </a>
        </c:forEach>
      </div>
    </section>

    <!-- YouTube Clips Section -->
    <c:if test="${not empty clips}">
      <section>
        <h2 class="text-2xl font-bold mb-6 flex items-center gap-2">
          공연 하이라이트 <i class="bi bi-youtube text-red-600"></i>
        </h2>
        <div class="swiper mySwiper rounded-2xl overflow-hidden border border-white/10 aspect-video">
          <div class="swiper-wrapper">
            <c:forEach var="clip" items="${clips}">
              <div class="swiper-slide">
                <iframe class="w-full h-full" src="https://www.youtube.com/embed/${clip}" frameborder="0" allowfullscreen></iframe>
              </div>
            </c:forEach>
          </div>
          <div class="swiper-pagination"></div>
          <div class="swiper-button-next text-stage-secondary"></div>
          <div class="swiper-button-prev text-stage-secondary"></div>
        </div>
      </section>
    </c:if>

  </main>

  <!-- Bottom Nav -->
  <nav class="fixed bottom-0 left-0 w-full glass-nav z-50">
    <div class="max-w-md mx-auto px-6 h-16 flex items-center justify-between text-stage-text-sub text-[10px] font-bold">
      <a href="${baseURL}/main" class="flex flex-col items-center gap-1 hover:text-stage-text transition-colors">
        <i class="bi bi-house-door text-xl"></i>
        <span>HOME</span>
      </a>
      <a href="${baseURL}/community" class="flex flex-col items-center gap-1 hover:text-stage-text transition-colors">
        <i class="bi bi-chat-dots text-xl"></i>
        <span>COMMUNITY</span>
      </a>
      <a href="${baseURL}/mypage/myinfo" class="flex flex-col items-center gap-1 hover:text-stage-text transition-colors">
        <i class="bi bi-person text-xl"></i>
        <span>MY PAGE</span>
      </a>
    </div>
  </nav>

  <footer class="mt-20">
    <p>&copy; Weiver 2023. All Rights Reserved.</p>
  </footer>

  <script>
    // Swiper Init
    var swiper = new Swiper(".mySwiper", {
      pagination: { el: ".swiper-pagination", clickable: true },
      navigation: { nextEl: ".swiper-button-next", prevEl: ".swiper-button-prev" },
    });

    // Subscribe State Management
    let isSubscribed1 = false;
    let isSubscribed2 = false;

    $(document).ready(function() {
      isSubscribed1 = ${not empty subscribeJjim ? "true" : "false"};
      isSubscribed2 = ${not empty subscribeWatched ? "true" : "false"};
      
      $('.icon1').toggleClass('subscribed', isSubscribed1);
      $('.icon2').toggleClass('text-stage-secondary', isSubscribed2);
    });

    function addSubscirbe(musicalId, type) {
      $.ajax({
        type: 'GET',
        url: '${baseURL}/addSubscribe/' + musicalId + "/" + type,
        success: function () {
          if (type === '찜했어요') {
            isSubscribed1 = !isSubscribed1;
            $('.icon1').toggleClass('subscribed', isSubscribed1);
          } else if (type === '봤어요') {
            isSubscribed2 = !isSubscribed2;
            $('.icon2').toggleClass('text-stage-secondary', isSubscribed2);
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
