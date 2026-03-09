<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="config.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
  <title>WIEVER - 커뮤니티 검색</title>

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
  </style>
</head>

<body class="bg-stage-bg text-stage-text font-sans pb-24 min-h-screen" style="background: linear-gradient(180deg, #0f0f0f 0%, #000000 100%); min-height: 100vh;">

  <!-- Header -->
  <header class="fixed top-0 left-0 w-full z-50 glass-nav">
    <div class="max-w-7xl mx-auto px-4 h-16 flex items-center justify-between">
      <a href="${baseURL}/community" class="text-2xl hover:text-stage-secondary transition-colors">
        <i class="bi bi-chevron-left"></i>
      </a>
      <span class="text-xl font-serif text-stage-secondary tracking-tighter">WIEVER</span>
      <div class="w-8"></div>
    </div>
  </header>

  <main class="max-w-4xl mx-auto px-4 pt-24 space-y-8">

    <!-- Page Title -->
    <div>
      <span class="text-stage-secondary font-bold tracking-[0.2em] uppercase text-xs">Community</span>
      <h1 class="text-3xl font-bold mt-1">게시글 검색</h1>
    </div>

    <!-- Search Form -->
    <form action="${baseURL}/community/search" method="get" class="relative">
      <input type="text" name="keyword" placeholder="게시글 제목, 내용을 검색하세요..."
        class="w-full bg-stage-surface border border-white/20 rounded-2xl py-4 px-6 pl-12 focus:outline-none focus:border-stage-secondary transition-all text-stage-text placeholder-stage-text-sub">
      <i class="bi bi-search absolute left-4 top-1/2 -translate-y-1/2 text-stage-text-sub text-lg"></i>
      <button type="submit" class="absolute right-3 top-1/2 -translate-y-1/2 bg-stage-primary hover:bg-rose-700 text-white px-6 py-2 rounded-xl font-bold text-sm transition-all">
        검색
      </button>
    </form>

    <!-- Results -->
    <c:choose>
      <c:when test="${not empty searchResults}">
        <p class="text-stage-text-sub text-sm">검색 결과 <span class="text-stage-text font-bold">${searchResults.size()}</span>건</p>
        <div class="space-y-4">
          <c:forEach var="post" items="${searchResults}">
            <a href="${baseURL}/community/${post.id}" class="block group">
              <div class="bg-stage-surface/30 border border-white/10 hover:border-white/30 p-5 rounded-2xl transition-all spotlight-glow">
                <div class="flex gap-4 items-start">
                  <div class="flex-1 space-y-2">
                    <h3 class="font-bold text-lg group-hover:text-stage-secondary transition-colors line-clamp-1">${post.title}</h3>
                    <p class="text-stage-text-sub text-sm line-clamp-2 leading-relaxed">${post.content.replaceAll('<[^>]*>', '')}</p>
                  </div>
                  <c:if test="${not empty post.image}">
                    <div class="w-20 h-20 rounded-xl overflow-hidden shrink-0 border border-white/20">
                      <img src="${post.image}" class="w-full h-full object-cover" alt="thumb">
                    </div>
                  </c:if>
                </div>
              </div>
            </a>
          </c:forEach>
        </div>
      </c:when>
      <c:otherwise>
        <div class="py-20 text-center space-y-4 bg-stage-surface/30 rounded-3xl border border-dashed border-white/20">
          <i class="bi bi-search text-5xl text-stage-text-sub"></i>
          <p class="text-stage-text-sub font-medium">검색 결과가 없습니다.</p>
          <p class="text-stage-text-sub text-sm">다른 키워드로 검색해보세요.</p>
        </div>
      </c:otherwise>
    </c:choose>

  </main>

  <!-- Bottom Nav -->
  <nav class="fixed bottom-0 left-0 w-full glass-nav z-50">
    <div class="max-w-md mx-auto px-6 h-16 flex items-center justify-between text-stage-text-sub text-[10px] font-bold">
      <a href="${baseURL}/" class="flex flex-col items-center gap-1 hover:text-stage-text transition-colors">
        <i class="bi bi-house-door text-xl"></i>
        <span>HOME</span>
      </a>
      <a href="${baseURL}/community" class="flex flex-col items-center gap-1 text-stage-secondary">
        <i class="bi bi-chat-dots-fill text-xl"></i>
        <span>COMMUNITY</span>
      </a>
      <a href="${baseURL}/mypage/myinfo" class="flex flex-col items-center gap-1 hover:text-stage-text transition-colors">
        <i class="bi bi-person text-xl"></i>
        <span>MY PAGE</span>
      </a>
    </div>
  </nav>

  <footer class="mt-10 mb-10 text-center text-[10px] text-center">
    <p class="text-[10px] font-serif font-bold tracking-[0.4em] uppercase text-stage-secondary">&copy; Weiver 2023. THE STAGE IS YOURS.</p>
  </footer>

</body>
</html>
