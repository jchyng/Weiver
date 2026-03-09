<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="config.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
  <title>WIEVER - 내 작품 목록</title>

  <script src="https://cdn.tailwindcss.com"></script>
  <script>
    tailwind.config = {
      theme: {
        extend: {
          colors: {
              'stage-gold-glow': '#FFD700',
            'stage-primary': '#BE123C',
            'stage-secondary': '#D4AF37',
            'stage-bg': '#0a0a0a',
            'stage-surface': '#1a1a1a',
            'stage-text': '#F8FAFC',
            'stage-text-sub': '#a1a1aa',
          },
          fontFamily: {
            sans: ['Pretendard', 'sans-serif'],
            serif: ['Cinzel', 'Playfair Display', 'serif'],
          },
        }
      }
    }
  </script>

  <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.8/dist/web/static/pretendard.css" />
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&family=Cinzel:wght@600;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

  <style>
    .glass-nav {
      background: rgba(0, 0, 0, 0.4);
      backdrop-filter: blur(12px);
      -webkit-backdrop-filter: blur(12px);
      border-bottom: 1px solid rgba(212, 175, 55, 0.2);
    }
    .spotlight-glow:hover {
      box-shadow: 0 0 15px rgba(212, 175, 55, 0.3); border-color: rgba(212, 175, 55, 0.5);
    }
    .active-tab {
      background-color: #BE123C;
      color: white;
    }
  </style>
</head>

<body class="bg-stage-bg text-stage-text font-sans pb-24 min-h-screen" style="background: linear-gradient(180deg, #0f0f0f 0%, #000000 100%); min-height: 100vh;">

  <!-- Header -->
  <header class="fixed top-0 left-0 w-full z-50 glass-nav">
    <div class="max-w-7xl mx-auto px-4 h-16 flex items-center justify-between">
      <a href="${baseURL}/mypage/myinfo" class="text-2xl hover:text-stage-secondary transition-colors">
        <i class="bi bi-chevron-left"></i>
      </a>
      <span class="text-xl font-serif text-stage-secondary tracking-tighter">WIEVER</span>
      <div class="w-8"></div>
    </div>
  </header>

  <main class="max-w-7xl mx-auto px-4 pt-24 space-y-8">

    <!-- Page Title -->
    <div>
      <span class="text-stage-secondary font-bold tracking-[0.2em] uppercase text-xs">My Collection</span>
      <h1 class="text-3xl font-bold mt-1">내 작품 목록</h1>
    </div>

    <!-- Tab Buttons -->
    <div class="flex items-center gap-3">
      <button id="tab-jjim" onclick="showMusicalList('찜', this)" class="tab-btn active-tab px-6 py-2.5 rounded-full font-bold text-sm transition-all">
        <i class="bi bi-bookmark-star-fill mr-2"></i>찜했어요
      </button>
      <button id="tab-watched" onclick="showMusicalList('봤어요', this)" class="tab-btn bg-stage-surface hover:bg-white/10 px-6 py-2.5 rounded-full font-bold text-sm transition-all">
        <i class="bi bi-check-circle-fill mr-2"></i>봤어요
      </button>
    </div>

    <!-- 찜 List -->
    <div id="musical_Jjim">
      <c:choose>
        <c:when test="${not empty JjimList}">
          <div class="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-5 gap-5">
            <c:forEach var="Jjim" items="${JjimList}">
              <a href="${baseURL}/musical-detail/${Jjim.getId()}" class="group block">
                <div class="relative aspect-[3/4] rounded-2xl overflow-hidden bg-stage-surface spotlight-glow transition-all duration-500 border border-white/10">
                  <img src="${Jjim.getPosterImage()}" class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-700" alt="${Jjim.getTitle()}">
                  <div class="absolute top-2 right-2">
                    <span class="bg-stage-secondary/90 text-black text-[9px] font-bold px-2 py-0.5 rounded-full"><i class="bi bi-bookmark-star-fill"></i></span>
                  </div>
                  <div class="absolute inset-0 bg-gradient-to-t from-black/90 via-black/20 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-300 flex flex-col justify-end p-4">
                    <h3 class="font-bold text-white text-sm leading-tight">${Jjim.getTitle()}</h3>
                  </div>
                </div>
                <p class="mt-2 text-sm font-bold truncate group-hover:text-stage-secondary transition-colors">${Jjim.getTitle()}</p>
                <c:if test="${Jjim.getStDate() != null && Jjim.getEdDate() != null}">
                  <p class="text-[10px] text-stage-text-sub mt-0.5">
                    <fmt:formatDate value="${Jjim.getStDate()}" pattern="yyyy.MM.dd" /> ~
                    <fmt:formatDate value="${Jjim.getEdDate()}" pattern="yyyy.MM.dd" />
                  </p>
                </c:if>
              </a>
            </c:forEach>
          </div>
        </c:when>
        <c:otherwise>
          <div class="py-20 text-center space-y-4 bg-stage-surface/30 rounded-3xl border border-dashed border-white/20">
            <i class="bi bi-bookmark text-5xl text-stage-text-sub"></i>
            <p class="text-stage-text-sub font-medium">찜한 작품이 없습니다.</p>
          </div>
        </c:otherwise>
      </c:choose>
    </div>

    <!-- Watched List -->
    <div id="musical_IsWatched" style="display: none">
      <c:choose>
        <c:when test="${not empty WatchedList}">
          <div class="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-5 gap-5">
            <c:forEach var="IsWatched" items="${WatchedList}">
              <a href="${baseURL}/musical-detail/${IsWatched.getId()}" class="group block">
                <div class="relative aspect-[3/4] rounded-2xl overflow-hidden bg-stage-surface spotlight-glow transition-all duration-500 border border-white/10">
                  <img src="${IsWatched.getPosterImage()}" class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-700" alt="${IsWatched.getTitle()}">
                  <div class="absolute top-2 right-2">
                    <span class="bg-stage-primary/90 text-white text-[9px] font-bold px-2 py-0.5 rounded-full"><i class="bi bi-check-circle-fill"></i></span>
                  </div>
                  <div class="absolute inset-0 bg-gradient-to-t from-black/90 via-black/20 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-300 flex flex-col justify-end p-4">
                    <h3 class="font-bold text-white text-sm leading-tight">${IsWatched.getTitle()}</h3>
                  </div>
                </div>
                <p class="mt-2 text-sm font-bold truncate group-hover:text-stage-secondary transition-colors">${IsWatched.getTitle()}</p>
                <c:if test="${IsWatched.getStDate() != null && IsWatched.getEdDate() != null}">
                  <p class="text-[10px] text-stage-text-sub mt-0.5">
                    <fmt:formatDate value="${IsWatched.getStDate()}" pattern="yyyy.MM.dd" /> ~
                    <fmt:formatDate value="${IsWatched.getEdDate()}" pattern="yyyy.MM.dd" />
                  </p>
                </c:if>
              </a>
            </c:forEach>
          </div>
        </c:when>
        <c:otherwise>
          <div class="py-20 text-center space-y-4 bg-stage-surface/30 rounded-3xl border border-dashed border-white/20">
            <i class="bi bi-eye text-5xl text-stage-text-sub"></i>
            <p class="text-stage-text-sub font-medium">본 작품이 없습니다.</p>
          </div>
        </c:otherwise>
      </c:choose>
    </div>

  </main>

  <!-- Bottom Nav -->
  <nav class="fixed bottom-0 left-0 w-full glass-nav z-50">
    <div class="max-w-md mx-auto px-6 h-16 flex items-center justify-between text-stage-text-sub text-[10px] font-bold">
      <a href="${baseURL}/" class="flex flex-col items-center gap-1 hover:text-stage-text transition-colors">
        <i class="bi bi-house-door text-xl"></i>
        <span>HOME</span>
      </a>
      <a href="${baseURL}/community" class="flex flex-col items-center gap-1 hover:text-stage-text transition-colors">
        <i class="bi bi-chat-dots text-xl"></i>
        <span>COMMUNITY</span>
      </a>
      <a href="${baseURL}/mypage/myinfo" class="flex flex-col items-center gap-1 text-stage-secondary">
        <i class="bi bi-person-fill text-xl"></i>
        <span>MY PAGE</span>
      </a>
    </div>
  </nav>

  <footer class="mt-10 mb-10 text-center text-[10px] text-center">
    <p class="text-[10px] font-serif font-bold tracking-[0.4em] uppercase text-stage-secondary">&copy; Weiver 2023. THE STAGE IS YOURS.</p>
  </footer>

  <script>
    function showMusicalList(category, button) {
      var jjimList = document.getElementById("musical_Jjim");
      var isWatchedList = document.getElementById("musical_IsWatched");
      var buttons = document.querySelectorAll('.tab-btn');

      buttons.forEach(btn => {
        btn.classList.remove('active-tab');
        btn.classList.add('bg-stage-surface', 'hover:bg-white/10');
      });
      button.classList.add('active-tab');
      button.classList.remove('bg-stage-surface', 'hover:bg-white/10');

      if (category === '찜') {
        jjimList.style.display = "block";
        isWatchedList.style.display = "none";
      } else if (category === '봤어요') {
        jjimList.style.display = "none";
        isWatchedList.style.display = "block";
      }
    }
  </script>

</body>
</html>
