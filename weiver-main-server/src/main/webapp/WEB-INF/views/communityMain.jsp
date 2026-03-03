<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="config.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>WIEVER COMMUNITY - The Stage</title>

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
        box-shadow: 0 0 20px rgba(251, 191, 36, 0.2);
        border-color: rgba(251, 191, 36, 0.3);
      }
      .post-card:hover .post-title {
        color: var(--stage-secondary);
      }
      .active-tab {
        background-color: var(--stage-primary);
        color: white;
      }
    </style>
</head>

<body class="bg-stage-bg text-stage-text font-sans pb-24">

  <!-- Header -->
  <header class="fixed top-0 left-0 w-full z-50 glass-nav">
    <div class="max-w-7xl mx-auto px-4 h-16 flex items-center justify-between">
      <div class="flex items-center gap-2">
        <span class="text-2xl font-serif text-stage-primary tracking-tighter">WIEVER</span>
        <span class="hidden md:block text-xs text-stage-text-sub font-bold tracking-widest ml-2 uppercase">Community</span>
      </div>
      
      <!-- Search Bar -->
      <form action="${baseURL}/community/search" method="get" class="flex-1 max-w-md mx-4 relative hidden sm:block">
        <input type="text" name="keyword" placeholder="게시글 검색..." class="w-full bg-stage-surface/50 border border-slate-700 text-sm rounded-full py-2 px-10 focus:outline-none focus:border-stage-secondary transition-all">
        <i class="bi bi-search absolute left-4 top-1/2 -translate-y-1/2 text-stage-text-sub"></i>
      </form>

      <div class="flex items-center gap-4">
        <c:choose>
          <c:when test="${empty user}">
            <a href="${baseURL}/login" class="text-sm font-bold hover:text-stage-secondary transition-colors">LOGIN</a>
          </c:when>
          <c:otherwise>
            <a href="${baseURL}/mypage/myinfo" class="w-8 h-8 rounded-full bg-stage-surface border border-slate-700 flex items-center justify-center hover:border-stage-secondary transition-all">
              <i class="bi bi-person text-lg"></i>
            </a>
          </c:otherwise>
        </c:choose>
      </div>
    </div>
  </header>

  <main class="max-w-7xl mx-auto px-4 pt-24 space-y-12">
    
    <!-- Hero / Best Posts Slider -->
    <section>
      <div class="flex items-center justify-between mb-6">
        <h2 class="text-2xl font-bold flex items-center gap-2">인기 게시글 <span class="text-stage-secondary">🔥</span></h2>
      </div>
      <div class="swiper bestSwiper overflow-visible">
        <div class="swiper-wrapper">
          <c:forEach var="card" items="${bestPost}">
            <div class="swiper-slide w-[300px]">
              <a href="${baseURL}/community/${card.id}" class="block group h-full">
                <div class="bg-stage-surface/50 border border-slate-700/50 p-6 rounded-2xl backdrop-blur-sm spotlight-glow transition-all h-full flex flex-col justify-between">
                  <div>
                    <span class="text-[10px] text-stage-primary font-bold uppercase tracking-widest mb-2 block">BEST POST</span>
                    <h3 class="font-bold text-lg line-clamp-2 group-hover:text-stage-secondary transition-colors leading-snug">${card.title}</h3>
                  </div>
                  <div class="mt-6 flex items-center justify-between pt-4 border-t border-slate-700/50">
                    <span class="text-sm text-stage-text-sub italic">@${card.user.nickname}</span>
                    <div class="flex items-center gap-3 text-stage-text-sub text-xs">
                      <span><i class="bi bi-eye"></i> ${card.viewed}</span>
                      <span><i class="bi bi-heart-fill text-stage-primary"></i> 24</span> <!-- Dummy heart count -->
                    </div>
                  </div>
                </div>
              </a>
            </div>
          </c:forEach>
        </div>
      </div>
    </section>

    <!-- Main Content Area: Category + List + Profile -->
    <div class="flex flex-col lg:flex-row gap-8">
      
      <!-- Left: Post List -->
      <div class="flex-1 space-y-6">
        <!-- Category Tabs -->
        <div class="flex items-center justify-between border-b border-slate-800 pb-4 overflow-x-auto gap-4">
          <div class="flex items-center gap-2 shrink-0">
            <button onclick="showPostList('전체', this)" class="category-btn active-tab px-5 py-2 rounded-full text-sm font-bold transition-all">전체</button>
            <button onclick="showPostList('리뷰', this)" class="category-btn bg-stage-surface hover:bg-slate-700 px-5 py-2 rounded-full text-sm font-bold transition-all">리뷰</button>
            <button onclick="showPostList('잡담', this)" class="category-btn bg-stage-surface hover:bg-slate-700 px-5 py-2 rounded-full text-sm font-bold transition-all">잡담</button>
          </div>
          <button onclick="checkLogin()" class="bg-stage-primary hover:bg-rose-700 text-white px-6 py-2 rounded-lg text-sm font-bold transition-all transform active:scale-95 shrink-0">
            <i class="bi bi-pencil-square mr-2"></i> 글 작성하기
          </button>
        </div>

        <!-- Post List Containers -->
        <div id="post-list-container" class="space-y-4">
          <!-- Iterate All Posts (Initially Visible) -->
          <c:forEach var="item" items="${postWithReplyCountList}">
            <div class="post-item ${item.post.type}" data-type="${item.post.type}">
              <a href="${baseURL}/community/${item.post.id}" class="post-card block bg-stage-surface/30 border border-slate-800 hover:border-slate-700 p-5 rounded-2xl transition-all">
                <div class="flex justify-between items-start gap-4">
                  <div class="space-y-2 flex-1">
                    <div class="flex items-center gap-3 mb-1">
                      <span class="px-2 py-0.5 rounded bg-slate-800 text-[10px] font-bold text-stage-text-sub uppercase tracking-wider">${item.post.type == 'Review' ? '리뷰' : '잡담'}</span>
                      <span class="text-xs text-stage-text-sub">@${item.post.user.nickname}</span>
                    </div>
                    <h3 class="post-title font-bold text-xl transition-colors line-clamp-1">${item.post.title}</h3>
                    <p class="text-stage-text-sub text-sm line-clamp-2 leading-relaxed">${item.post.content.replaceAll('<[^>]*>', '')}</p>
                    <div class="flex items-center gap-4 pt-2 text-xs text-stage-text-sub">
                      <span class="flex items-center gap-1"><i class="bi bi-eye"></i> ${item.post.viewed}</span>
                      <span class="flex items-center gap-1"><i class="bi bi-heart-fill text-stage-primary/70"></i> ${item.likeCount}</span>
                      <span class="flex items-center gap-1"><i class="bi bi-chat-text"></i> ${item.replyCount}</span>
                    </div>
                  </div>
                  <c:if test="${not empty item.post.image}">
                    <div class="w-24 h-24 rounded-xl overflow-hidden shrink-0 border border-slate-700">
                      <img src="${item.post.image}" class="w-full h-full object-cover" alt="thumb">
                    </div>
                  </c:if>
                </div>
              </a>
            </div>
          </c:forEach>
        </div>
      </div>

      <!-- Right: Side Info -->
      <aside class="w-full lg:w-80 space-y-6">
        <c:choose>
          <c:when test="${not empty user}">
            <!-- User Profile Card -->
            <div class="bg-stage-surface border border-slate-700 p-6 rounded-2xl space-y-4">
              <div class="flex items-center gap-4">
                <div class="w-12 h-12 rounded-full bg-stage-primary/20 flex items-center justify-center border border-stage-primary/30">
                  <i class="bi bi-person-fill text-2xl text-stage-primary"></i>
                </div>
                <div>
                  <p class="text-xs text-stage-text-sub font-bold uppercase tracking-widest leading-none mb-1">Welcome back</p>
                  <h4 class="font-bold text-lg">${user}</h4>
                </div>
              </div>
              <div class="grid grid-cols-2 gap-2">
                <a href="${baseURL}/mypage/myBoard" class="bg-slate-800/50 hover:bg-slate-800 p-3 rounded-xl text-center transition-colors">
                  <p class="text-[10px] text-stage-text-sub font-bold uppercase mb-1">My Posts</p>
                  <p class="text-xl font-bold font-serif">${postCount}</p>
                </a>
                <a href="${baseURL}/mypage/myComment" class="bg-slate-800/50 hover:bg-slate-800 p-3 rounded-xl text-center transition-colors">
                  <p class="text-[10px] text-stage-text-sub font-bold uppercase mb-1">Comments</p>
                  <p class="text-xl font-bold font-serif">${replyCount}</p>
                </a>
              </div>
              <a href="${baseURL}/mypage/myinfo" class="block w-full text-center py-2.5 rounded-xl border border-slate-700 text-sm font-bold hover:bg-slate-800 transition-all">MY PAGE</a>
            </div>
          </c:when>
          <c:otherwise>
            <div class="bg-stage-surface border border-slate-700 p-6 rounded-2xl text-center space-y-4">
              <i class="bi bi-door-open text-4xl text-stage-text-sub"></i>
              <p class="text-sm text-stage-text-sub font-medium">로그인하고 더 많은<br>커뮤니티 기능을 즐겨보세요!</p>
              <a href="${baseURL}/login" class="block w-full bg-stage-primary hover:bg-rose-700 py-3 rounded-xl text-sm font-bold text-white transition-all">로그인 / 회원가입</a>
            </div>
          </c:otherwise>
        </c:choose>
        
        <!-- Community Rules / Info -->
        <div class="bg-slate-900/50 border border-slate-800/50 p-6 rounded-2xl">
          <h4 class="text-sm font-bold mb-4 flex items-center gap-2"><i class="bi bi-info-circle text-stage-secondary"></i> 커뮤니티 가이드</h4>
          <ul class="text-xs text-stage-text-sub space-y-3">
            <li class="flex gap-2"><span>1.</span> 공연 관련 정보를 자유롭게 공유하세요.</li>
            <li class="flex gap-2"><span>2.</span> 배우와 관객에 대한 예우를 갖춰주세요.</li>
            <li class="flex gap-2"><span>3.</span> 스포일러는 반드시 주의해 주세요!</li>
          </ul>
        </div>
      </aside>

    </div>
  </main>

  <!-- Navigation Bar (Fixed Bottom) -->
  <nav class="fixed bottom-0 left-0 w-full glass-nav z-50">
    <div class="max-w-md mx-auto px-6 h-16 flex items-center justify-between text-stage-text-sub text-[10px] font-bold">
      <a href="${baseURL}/main" class="flex flex-col items-center gap-1 hover:text-stage-text transition-colors">
        <i class="bi bi-house-door text-xl"></i>
        <span>HOME</span>
      </a>
      <a href="${baseURL}/community" class="flex flex-col items-center gap-1 text-stage-primary">
        <i class="bi bi-chat-dots-fill text-xl"></i>
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
    var swiper = new Swiper(".bestSwiper", {
      slidesPerView: "auto",
      spaceBetween: 20,
      freeMode: true,
    });

    // Category Filtering
    function showPostList(category, button) {
      const items = document.querySelectorAll('.post-item');
      const buttons = document.querySelectorAll('.category-btn');
      
      buttons.forEach(btn => btn.classList.remove('active-tab', 'bg-stage-primary'));
      buttons.forEach(btn => btn.classList.add('bg-stage-surface', 'hover:bg-slate-700'));
      button.classList.add('active-tab');
      button.classList.remove('bg-stage-surface', 'hover:bg-slate-700');

      items.forEach(item => {
        if (category === '전체') {
          item.style.display = 'block';
        } else if (category === '리뷰' && item.dataset.type === 'Review') {
          item.style.display = 'block';
        } else if (category === '잡담' && item.dataset.type === 'Chat') {
          item.style.display = 'block';
        } else {
          item.style.display = 'none';
        }
      });
    }

    function checkLogin() {
      var loggedIn = ${not empty user ? "true" : "false"};
      if (loggedIn) {
        location.href = '${baseURL}/community/board';
      } else {
        alert('로그인 해주세요.');
        location.href = '${baseURL}/login';
      }
    }
  </script>

</body>
</html>
