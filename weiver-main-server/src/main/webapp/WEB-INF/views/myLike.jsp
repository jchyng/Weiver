<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="config.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
  <title>WIEVER - 좋아요한 글</title>

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
    .active-sort {
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

  <main class="max-w-4xl mx-auto px-4 pt-24 space-y-8">

    <!-- Page Title + Stats -->
    <div class="flex items-end justify-between">
      <div>
        <span class="text-stage-secondary font-bold tracking-[0.2em] uppercase text-xs">My Activity</span>
        <h1 class="text-3xl font-bold mt-1">좋아요한 글</h1>
      </div>
      <span class="text-stage-text-sub text-sm font-bold">총 <span class="text-stage-text">${postCount}</span>편</span>
    </div>

    <!-- Sort Tabs -->
    <div class="flex items-center gap-2">
      <button onclick="sortTypeChange('작성', this)" class="sort-btn active-sort px-5 py-2 rounded-full text-sm font-bold transition-all">
        최신순
      </button>
      <button onclick="sortTypeChange('추천', this)" class="sort-btn bg-stage-surface hover:bg-white/10 px-5 py-2 rounded-full text-sm font-bold transition-all">
        추천순
      </button>
    </div>

    <!-- Post List - Date Sort -->
    <div id="sortDate" class="space-y-3">
      <c:forEach var="post" items="${postListTime}">
        <a href="${baseURL}/community/${post.id}" class="block group">
          <div class="bg-stage-surface/30 border border-white/10 hover:border-white/30 p-5 rounded-2xl transition-all spotlight-glow">
            <div class="flex items-start justify-between gap-4">
              <div class="flex-1 space-y-1.5">
                <p class="text-[10px] text-stage-text-sub font-bold">${post.createdTime}</p>
                <h3 class="font-bold text-lg group-hover:text-stage-secondary transition-colors line-clamp-1">${post.title}</h3>
              </div>
              <div class="flex items-center gap-1.5 shrink-0">
                <i class="bi bi-heart-fill text-stage-primary"></i>
                <span class="font-bold text-sm">${post.countLikes}</span>
              </div>
            </div>
          </div>
        </a>
      </c:forEach>
      <c:if test="${empty postListTime}">
        <div class="py-20 text-center space-y-4 bg-stage-surface/30 rounded-3xl border border-dashed border-white/20">
          <i class="bi bi-heart text-5xl text-stage-text-sub"></i>
          <p class="text-stage-text-sub font-medium">좋아요한 글이 없습니다.</p>
        </div>
      </c:if>
    </div>

    <!-- Post List - Like Sort -->
    <div id="sortLike" class="space-y-3" style="display: none">
      <c:forEach var="post" items="${postListLike}">
        <a href="${baseURL}/community/${post.id}" class="block group">
          <div class="bg-stage-surface/30 border border-white/10 hover:border-white/30 p-5 rounded-2xl transition-all spotlight-glow">
            <div class="flex items-start justify-between gap-4">
              <div class="flex-1 space-y-1.5">
                <p class="text-[10px] text-stage-text-sub font-bold">${post.createdTime}</p>
                <h3 class="font-bold text-lg group-hover:text-stage-secondary transition-colors line-clamp-1">${post.title}</h3>
              </div>
              <div class="flex items-center gap-1.5 shrink-0">
                <i class="bi bi-heart-fill text-stage-primary"></i>
                <span class="font-bold text-sm text-stage-text">${post.countLikes}</span>
              </div>
            </div>
          </div>
        </a>
      </c:forEach>
      <c:if test="${empty postListLike}">
        <div class="py-20 text-center space-y-4 bg-stage-surface/30 rounded-3xl border border-dashed border-white/20">
          <i class="bi bi-heart text-5xl text-stage-text-sub"></i>
          <p class="text-stage-text-sub font-medium">좋아요한 글이 없습니다.</p>
        </div>
      </c:if>
    </div>

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
    function sortTypeChange(value, button) {
      const sortDate = document.getElementById('sortDate');
      const sortLike = document.getElementById('sortLike');
      const buttons = document.querySelectorAll('.sort-btn');

      buttons.forEach(btn => {
        btn.classList.remove('active-sort');
        btn.classList.add('bg-stage-surface', 'hover:bg-white/10');
      });
      button.classList.add('active-sort');
      button.classList.remove('bg-stage-surface', 'hover:bg-white/10');

      if (value === '작성') {
        sortDate.style.display = "block";
        sortLike.style.display = "none";
      } else if (value === '추천') {
        sortDate.style.display = "none";
        sortLike.style.display = "block";
      }
    }
  </script>

</body>
</html>
