<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="config.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>WIEVER - My Page</title>

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

    <style>
      .glass-nav {
        background: rgba(15, 23, 42, 0.7);
        backdrop-filter: blur(12px);
        -webkit-backdrop-filter: blur(12px);
        border-bottom: 1px solid rgba(255, 255, 255, 0.1);
      }
      .profile-card {
        background: linear-gradient(135deg, rgba(30, 41, 59, 0.8), rgba(15, 23, 42, 0.9));
        border: 1px solid rgba(255, 255, 255, 0.05);
      }
      .stat-item:hover {
        background: rgba(255, 255, 255, 0.03);
      }
    </style>
</head>

<body class="bg-stage-bg text-stage-text font-sans pb-24 min-h-screen">

  <!-- Header -->
  <header class="fixed top-0 left-0 w-full z-50 glass-nav">
    <div class="max-w-7xl mx-auto px-4 h-16 flex items-center justify-between">
      <div class="flex items-center gap-2">
        <span class="text-2xl font-serif text-stage-primary tracking-tighter">WIEVER</span>
      </div>
      <div class="flex items-center gap-4 text-stage-text-sub">
        <a href="${baseURL}/mypage/profileUpdate" class="hover:text-stage-secondary transition-colors"><i class="bi bi-pencil-square text-xl"></i></a>
        <a href="${baseURL}/mypage/setting" class="hover:text-stage-secondary transition-colors"><i class="bi bi-gear text-xl"></i></a>
      </div>
    </div>
  </header>

  <main class="max-w-lg mx-auto px-6 pt-24 space-y-8">
    
    <!-- User Profile Card -->
    <section class="profile-card rounded-3xl p-8 flex flex-col items-center text-center shadow-2xl relative overflow-hidden">
      <!-- Abstract Glow -->
      <div class="absolute -top-12 -right-12 w-32 h-32 bg-stage-primary/10 rounded-full blur-3xl"></div>
      
      <div class="w-32 h-32 rounded-full p-1 bg-gradient-to-tr from-stage-primary to-stage-secondary mb-4">
        <div class="w-full h-full rounded-full overflow-hidden border-4 border-slate-900 bg-slate-800">
          <img src="${requestScope.userInfo.profileImg != null ? requestScope.userInfo.profileImg : '/img/Default_Profile.png'}" class="w-full h-full object-cover" alt="profile">
        </div>
      </div>
      
      <h2 class="text-2xl font-bold mb-1">${requestScope.userInfo.nickname}</h2>
      <p class="text-xs text-stage-text-sub font-bold tracking-widest uppercase">Weiver Enthusiast</p>
    </section>

    <!-- Subscribe Stats -->
    <section class="grid grid-cols-2 gap-4">
      <a href="${baseURL}/mypage/mySubscribe" class="stat-item bg-stage-surface/50 border border-slate-800 p-6 rounded-2xl text-center transition-all hover:border-slate-700">
        <p class="text-[10px] text-stage-text-sub font-bold uppercase tracking-widest mb-1">찜했어요</p>
        <p class="text-3xl font-serif font-bold text-stage-secondary">${requestScope.userInfo.countJjim}</p>
      </a>
      <a href="${baseURL}/mypage/mySubscribe" class="stat-item bg-stage-surface/50 border border-slate-800 p-6 rounded-2xl text-center transition-all hover:border-slate-700">
        <p class="text-[10px] text-stage-text-sub font-bold uppercase tracking-widest mb-1">봤어요</p>
        <p class="text-3xl font-serif font-bold text-stage-primary">${requestScope.userInfo.countIsWatched}</p>
      </a>
    </section>

    <!-- Activity Menu -->
    <section class="space-y-3">
      <h3 class="text-sm font-bold text-stage-text-sub uppercase tracking-widest ml-1 mb-4">My Activity</h3>
      
      <a href="${baseURL}/mypage/myBoard" class="flex items-center justify-between bg-stage-surface/30 border border-slate-800 hover:bg-stage-surface/50 p-5 rounded-2xl transition-all group">
        <div class="flex items-center gap-4">
          <div class="w-10 h-10 rounded-xl bg-slate-800 flex items-center justify-center group-hover:bg-stage-primary/20 transition-colors">
            <i class="bi bi-journal-text text-lg text-stage-text-sub group-hover:text-stage-primary"></i>
          </div>
          <span class="font-bold">내가 쓴 글</span>
        </div>
        <div class="flex items-center gap-3">
          <span class="text-sm font-serif text-stage-text-sub">${requestScope.userInfo.countPosts}</span>
          <i class="bi bi-chevron-right text-slate-700 group-hover:text-stage-secondary"></i>
        </div>
      </a>

      <a href="${baseURL}/mypage/myComment" class="flex items-center justify-between bg-stage-surface/30 border border-slate-800 hover:bg-stage-surface/50 p-5 rounded-2xl transition-all group">
        <div class="flex items-center gap-4">
          <div class="w-10 h-10 rounded-xl bg-slate-800 flex items-center justify-center group-hover:bg-stage-primary/20 transition-colors">
            <i class="bi bi-chat-left-dots text-lg text-stage-text-sub group-hover:text-stage-primary"></i>
          </div>
          <span class="font-bold">내가 쓴 댓글</span>
        </div>
        <div class="flex items-center gap-3">
          <span class="text-sm font-serif text-stage-text-sub">${requestScope.userInfo.countReplies}</span>
          <i class="bi bi-chevron-right text-slate-700 group-hover:text-stage-secondary"></i>
        </div>
      </a>

      <a href="${baseURL}/mypage/myLike" class="flex items-center justify-between bg-stage-surface/30 border border-slate-800 hover:bg-stage-surface/50 p-5 rounded-2xl transition-all group">
        <div class="flex items-center gap-4">
          <div class="w-10 h-10 rounded-xl bg-slate-800 flex items-center justify-center group-hover:bg-stage-primary/20 transition-colors">
            <i class="bi bi-heart text-lg text-stage-text-sub group-hover:text-stage-primary"></i>
          </div>
          <span class="font-bold">좋아요한 글</span>
        </div>
        <div class="flex items-center gap-3">
          <span class="text-sm font-serif text-stage-text-sub">${requestScope.userInfo.countPostLikes}</span>
          <i class="bi bi-chevron-right text-slate-700 group-hover:text-stage-secondary"></i>
        </div>
      </a>
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
      <a href="${baseURL}/mypage/myinfo" class="flex flex-col items-center gap-1 text-stage-primary">
        <i class="bi bi-person-fill text-xl"></i>
        <span>MY PAGE</span>
      </a>
    </div>
  </nav>

  <footer class="mt-10 mb-10 text-center text-[10px] text-stage-text-sub font-bold uppercase tracking-[0.2em]">
    &copy; Weiver 2023. All Rights Reserved.
  </footer>

</body>
</html>
