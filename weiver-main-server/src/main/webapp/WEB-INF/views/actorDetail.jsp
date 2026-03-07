<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="config.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>WIEVER - 배우 ${actor.name}</title>

    <!-- Tailwind CSS CDN -->
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

    <!-- Fonts & Icons -->
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
      .profile-ring {
        background: linear-gradient(45deg, var(--stage-primary), var(--stage-secondary));
        padding: 4px;
      }
    </style>
</head>

<body class="bg-stage-bg text-stage-text font-sans pb-24" style="background: linear-gradient(180deg, #0f0f0f 0%, #000000 100%); min-height: 100vh;">

  <!-- Header -->
  <header class="fixed top-0 left-0 w-full z-50 glass-nav">
    <div class="max-w-7xl mx-auto px-4 h-16 flex items-center justify-between">
      <a href="javascript:history.back();" class="text-2xl hover:text-stage-secondary transition-colors">
        <i class="bi bi-chevron-left"></i>
      </a>
      <span class="text-xl font-serif text-stage-secondary tracking-tighter">WIEVER</span>
      <div class="w-8"></div> <!-- Spacer -->
    </div>
  </header>

  <!-- Hero Section: Actor Profile -->
  <section class="relative pt-32 pb-16 px-6 overflow-hidden">
    <!-- Abstract Background -->
    <div class="absolute inset-0 z-0">
      <div class="absolute top-0 left-1/2 -translate-x-1/2 w-[600px] h-[600px] bg-stage-primary/10 rounded-full blur-[120px]"></div>
      <div class="absolute bottom-0 right-0 w-[400px] h-[400px] bg-stage-secondary/5 rounded-full blur-[100px]"></div>
    </div>

    <div class="relative z-10 max-w-4xl mx-auto flex flex-col items-center text-center">
      <!-- Profile Image -->
      <div class="profile-ring rounded-full mb-8 shadow-2xl transform transition-transform hover:rotate-3 duration-500">
        <div class="w-48 h-48 md:w-56 md:h-56 rounded-full overflow-hidden border-4 border-stage-bg">
          <img src="${actor.profileImage}" class="w-full h-full object-cover" alt="${actor.name}">
        </div>
      </div>

      <!-- Actor Info -->
      <div class="space-y-2">
        <span class="text-stage-secondary font-bold tracking-[0.2em] uppercase text-xs">The Artist</span>
        <h1 class="text-4xl md:text-6xl font-serif font-bold text-white tracking-tight">${actor.name}</h1>
        <div class="h-1 w-12 bg-stage-primary mx-auto mt-4 rounded-full"></div>
      </div>
    </div>
  </section>

  <!-- Content Section: Filmography -->
  <main class="max-w-6xl mx-auto px-6 space-y-16">
    
    <section>
      <div class="flex items-center gap-4 mb-8">
        <h2 class="text-2xl font-bold">출연 작품</h2>
        <div class="flex-1 h-px bg-stage-surface"></div>
        <span class="text-stage-text-sub text-sm font-medium">${requestScope.musicalList.size()} Projects</span>
      </div>

      <div class="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-4 gap-6">
        <c:forEach items="${requestScope.musicalList}" var="musical">
          <a href="${baseURL}/musical-detail/${musical.id}" class="group block relative aspect-[3/4] rounded-2xl overflow-hidden bg-stage-surface spotlight-glow transition-all duration-500 border border-white/10">
            <img src="${musical.posterImage}" class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-700" alt="${musical.title}">
            
            <!-- Overlay Info -->
            <div class="absolute inset-0 bg-gradient-to-t from-black/90 via-black/20 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-300 flex flex-col justify-end p-6">
              <h3 class="font-bold text-white text-lg mb-1 leading-tight transform translate-y-4 group-hover:translate-y-0 transition-transform duration-500">${musical.title}</h3>
              <p class="text-stage-secondary text-xs font-bold uppercase tracking-wider transform translate-y-4 group-hover:translate-y-0 transition-transform duration-500 delay-75">View Details <i class="bi bi-arrow-right ml-1"></i></p>
            </div>
          </a>
        </c:forEach>
      </div>
      
      <c:if test="${empty requestScope.musicalList}">
        <div class="py-20 text-center space-y-4 bg-stage-surface/30 rounded-3xl border border-dashed border-white/20">
          <i class="bi bi-journal-x text-5xl text-stage-text-sub"></i>
          <p class="text-stage-text-sub">등록된 출연 작품이 없습니다.</p>
        </div>
      </c:if>
    </section>

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

  <footer class="mt-20 mb-10 text-center text-[10px] text-center">
    <p class="text-[10px] font-serif font-bold tracking-[0.4em] uppercase text-stage-secondary">&copy; Weiver 2023. THE STAGE IS YOURS.</p>
  </footer>

</body>
</html>
