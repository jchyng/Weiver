<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="config.jsp" %>

<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
  <title>WIEVER - The Stage</title>

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
            sans: ['Pretendard', '-apple-system', 'sans-serif'],
            serif: ['Playfair Display', 'serif'],
            impact: ['GmarketSansBold', 'sans-serif'],
          },
        }
      }
    }
  </script>

  <!-- CSS & Fonts -->
  <link rel="stylesheet" href="/css/public.css">

  <!-- SWIPER -->
  <link rel="stylesheet" href="https://unpkg.com/swiper@8/swiper-bundle.min.css" />
  <script src="https://unpkg.com/swiper@8/swiper-bundle.min.js"></script>

  <style>
    .glass-nav {
      background: rgba(15, 23, 42, 0.7);
      backdrop-filter: blur(12px);
      border-bottom: 1px solid rgba(255, 255, 255, 0.1);
    }
    .spotlight-glow:hover {
      box-shadow: 0 0 20px rgba(251, 191, 36, 0.3);
    }
    .hero-title {
      line-height: 1.1;
      letter-spacing: -0.03em;
    }
  </style>
</head>

<body class="bg-stage-bg text-stage-text selection:bg-stage-primary selection:text-white pb-24">

  <!-- Header -->
  <header class="fixed top-0 left-0 w-full z-50 glass-nav">
    <div class="max-w-7xl mx-auto px-4 h-16 flex items-center justify-between">
      <div class="flex items-center gap-2">
        <span class="text-3xl font-serif text-stage-primary tracking-tighter italic font-black">WIEVER</span>
      </div>
      <div class="flex items-center gap-5">
        <button class="text-xl hover:text-stage-secondary transition-colors"><i class="bi bi-search"></i></button>
        <button class="text-xl hover:text-stage-secondary transition-colors"><i class="bi bi-bell"></i></button>
      </div>
    </div>
  </header>

  <!-- Hero Section -->
  <section class="relative h-[80vh] w-full overflow-hidden flex items-end pb-24 px-6">
    <div class="absolute inset-0 bg-gradient-to-t from-stage-bg via-stage-bg/40 to-transparent z-10"></div>
    
    <!-- Video or High-res Image Placeholder -->
    <div class="absolute inset-0 bg-slate-800 flex items-center justify-center">
      <img src="https://images.unsplash.com/photo-1503095396549-807759245b35?auto=format&fit=crop&q=80&w=2000" class="w-full h-full object-cover opacity-60" alt="Hero">
    </div>
    
    <div class="relative z-20 max-w-4xl animate-fade-in-up">
      <div class="flex items-center gap-2 mb-4">
        <span class="bg-stage-primary text-white text-[10px] font-impact px-2 py-0.5 rounded tracking-tighter">PREMIUM</span>
        <span class="text-stage-secondary font-impact text-sm tracking-widest uppercase">The Stage is Yours</span>
      </div>
      <h1 class="hero-title text-5xl md:text-7xl font-bold mb-6 text-shadow-lg">조명 아래 펼쳐지는<br><span class="text-stage-primary">감동의 무대</span>, WIEVER</h1>
      <div class="flex gap-4">
        <button class="bg-stage-primary hover:bg-rose-700 text-white px-8 py-3.5 rounded-xl font-impact text-lg transition-all transform hover:scale-105 shadow-xl shadow-rose-900/40">지금 예매하기</button>
        <button class="bg-white/10 hover:bg-white/20 backdrop-blur-md text-white px-8 py-3.5 rounded-xl font-impact text-lg border border-white/20 transition-all">찜한 목록</button>
      </div>
    </div>
  </section>

  <!-- Main Content Area -->
  <main class="max-w-7xl mx-auto px-4 -mt-12 relative z-30 space-y-16">
    
    <!-- 인기 뮤지컬 -->
    <section>
      <div class="flex items-center justify-between mb-6">
        <h2 class="text-3xl font-impact tracking-tighter">BEST MUSICALS <span class="text-stage-primary">🔥</span></h2>
        <a href="#" class="text-stage-text-sub hover:text-stage-secondary text-sm font-bold uppercase tracking-widest">View All</a>
      </div>
      <div class="grid grid-cols-2 md:grid-cols-4 lg:grid-cols-5 gap-6">
        <c:choose>
          <c:when test="${not empty popularMusicals}">
            <c:forEach var="musical" items="${popularMusicals}">
              <div class="group relative aspect-[3/4] rounded-2xl overflow-hidden bg-stage-surface spotlight-glow transition-all duration-500 border border-slate-800">
                <img src="${musical.posterImage}" class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-700" alt="${musical.title}">
                <div class="absolute inset-0 bg-gradient-to-t from-black via-black/20 to-transparent opacity-0 group-hover:opacity-100 transition-opacity flex flex-col justify-end p-5">
                  <span class="text-stage-secondary font-impact text-[10px] uppercase tracking-widest mb-1">Trending</span>
                  <span class="font-bold text-sm truncate leading-tight">${musical.title}</span>
                </div>
              </div>
            </c:forEach>
          </c:when>
          <c:otherwise>
            <c:forEach begin="1" end="5">
              <div class="aspect-[3/4] rounded-2xl bg-stage-surface/50 border border-slate-800 animate-pulse"></div>
            </c:forEach>
          </c:otherwise>
        </c:choose>
      </div>
    </section>

    <!-- 커뮤니티 섹션 -->
    <section class="bg-stage-surface/30 rounded-[32px] p-10 border border-slate-800 shadow-inner">
      <div class="flex flex-col md:flex-row md:items-end justify-between gap-6 mb-10">
        <div>
          <span class="text-stage-primary font-impact tracking-widest text-xs uppercase mb-2 block">Hot Discussions</span>
          <h2 class="text-4xl font-impact tracking-tighter italic">LATEST REVIEWS</h2>
        </div>
        <button class="bg-stage-secondary hover:bg-amber-500 text-slate-900 px-6 py-2 rounded-full font-impact text-sm transition-all transform hover:-rotate-2">커뮤니티 입장</button>
      </div>
      
      <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
        <c:forEach var="card" items="${bestPost}" begin="0" end="2">
          <div class="bg-slate-900/50 border border-slate-800/80 backdrop-blur-sm p-7 rounded-3xl spotlight-glow transition-all hover:-translate-y-2">
            <div class="flex justify-between items-start mb-4">
              <i class="bi bi-quote text-3xl text-stage-primary/40"></i>
              <span class="text-[10px] font-impact text-stage-text-sub uppercase tracking-widest">${card.type}</span>
            </div>
            <h3 class="text-xl font-bold mb-6 line-clamp-2 hover:text-stage-secondary cursor-pointer transition-colors leading-tight">${card.title}</h3>
            <div class="flex items-center justify-between border-t border-slate-800/80 pt-4">
              <div class="flex items-center gap-2">
                <div class="w-6 h-6 rounded-full bg-stage-surface flex items-center justify-center text-[10px] border border-slate-700 font-bold italic">W</div>
                <span class="text-xs font-bold text-stage-text-sub italic">@${card.user.nickname}</span>
              </div>
              <div class="flex items-center gap-3 text-stage-text-sub text-[10px]">
                <span><i class="bi bi-eye"></i> ${card.viewed}</span>
                <span><i class="bi bi-heart-fill text-stage-primary"></i> 24</span>
              </div>
            </div>
          </div>
        </c:forEach>
      </div>
    </section>

  </main>

  <!-- Navigation Bar -->
  <nav class="fixed bottom-0 left-0 w-full glass-nav z-50">
    <div class="max-w-md mx-auto px-10 h-16 flex items-center justify-between text-stage-text-sub">
      <a href="${baseURL}/main" class="flex flex-col items-center gap-1 text-stage-primary group">
        <i class="bi bi-house-door-fill text-2xl group-hover:scale-110 transition-transform"></i>
        <span class="text-[9px] font-impact tracking-tighter">HOME</span>
      </a>
      <a href="${baseURL}/community" class="flex flex-col items-center gap-1 hover:text-stage-text transition-colors group">
        <i class="bi bi-chat-right-dots-fill text-2xl group-hover:scale-110 transition-transform"></i>
        <span class="text-[9px] font-impact tracking-tighter">COMMUNITY</span>
      </a>
      <a href="${baseURL}/mypage/myinfo" class="flex flex-col items-center gap-1 hover:text-stage-text transition-colors group">
        <i class="bi bi-person-bounding-box text-2xl group-hover:scale-110 transition-transform"></i>
        <span class="text-[9px] font-impact tracking-tighter">MY PAGE</span>
      </a>
    </div>
  </nav>

  <footer class="mt-20">
    <p>&copy; Weiver 2023. THE STAGE IS YOURS.</p>
  </footer>

</body>

</html>
