<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="config.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
  <title>WIEVER - 설정</title>

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

  <main class="max-w-lg mx-auto px-4 pt-24 space-y-8">

    <!-- Page Title -->
    <div>
      <span class="text-stage-secondary font-bold tracking-[0.2em] uppercase text-xs">Account</span>
      <h1 class="text-3xl font-bold mt-1">설정</h1>
    </div>

    <!-- Settings Menu -->
    <div class="space-y-3">

      <!-- Logout -->
      <button onclick="logutConfirm()" class="w-full flex items-center justify-between bg-stage-surface/30 border border-white/10 hover:bg-stage-surface/60 hover:border-white/20 p-5 rounded-2xl transition-all group text-left">
        <div class="flex items-center gap-4">
          <div class="w-10 h-10 rounded-xl bg-stage-surface flex items-center justify-center group-hover:bg-amber-500/20 transition-colors">
            <i class="bi bi-box-arrow-right text-lg text-stage-text-sub group-hover:text-stage-secondary"></i>
          </div>
          <span class="font-bold">로그아웃</span>
        </div>
        <i class="bi bi-chevron-right text-stage-text-sub group-hover:text-stage-secondary transition-colors"></i>
      </button>

      <!-- Password Change -->
      <a href="${baseURL}/mypage/password" class="flex items-center justify-between bg-stage-surface/30 border border-white/10 hover:bg-stage-surface/60 hover:border-white/20 p-5 rounded-2xl transition-all group">
        <div class="flex items-center gap-4">
          <div class="w-10 h-10 rounded-xl bg-stage-surface flex items-center justify-center group-hover:bg-stage-primary/20 transition-colors">
            <i class="bi bi-shield-lock text-lg text-stage-text-sub group-hover:text-stage-primary"></i>
          </div>
          <span class="font-bold">비밀번호 변경</span>
        </div>
        <i class="bi bi-chevron-right text-stage-text-sub group-hover:text-stage-secondary transition-colors"></i>
      </a>

      <!-- Inquiry -->
      <a href="${baseURL}/inquiry/inquiryMain" class="flex items-center justify-between bg-stage-surface/30 border border-white/10 hover:bg-stage-surface/60 hover:border-white/20 p-5 rounded-2xl transition-all group">
        <div class="flex items-center gap-4">
          <div class="w-10 h-10 rounded-xl bg-stage-surface flex items-center justify-center group-hover:bg-stage-primary/20 transition-colors">
            <i class="bi bi-question-circle text-lg text-stage-text-sub group-hover:text-stage-primary"></i>
          </div>
          <span class="font-bold">문의하기</span>
        </div>
        <i class="bi bi-chevron-right text-stage-text-sub group-hover:text-stage-secondary transition-colors"></i>
      </a>

      <!-- Divider -->
      <div class="border-t border-white/10 my-2"></div>

      <!-- Withdraw -->
      <button onclick="signOut()" class="w-full flex items-center justify-between bg-rose-900/10 border border-rose-900/20 hover:bg-rose-900/20 hover:border-rose-900/40 p-5 rounded-2xl transition-all group text-left">
        <div class="flex items-center gap-4">
          <div class="w-10 h-10 rounded-xl bg-rose-900/20 flex items-center justify-center">
            <i class="bi bi-person-x text-lg text-rose-500"></i>
          </div>
          <span class="font-bold text-rose-500">회원 탈퇴</span>
        </div>
        <i class="bi bi-chevron-right text-rose-800 group-hover:text-rose-500 transition-colors"></i>
      </button>

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
    function logutConfirm() {
      const result = confirm("로그아웃 하시겠습니까?");
      if (result) {
        alert("로그아웃 되었습니다.");
        window.location.href = "${baseURL}/logout";
      }
    }

    function signOut() {
      const result = confirm("클릭하시면 즉시 회원탈퇴 됩니다.");
      if (result) {
        alert("정상적으로 탈퇴 되었습니다.");
        window.location.href = "${baseURL}/signOut";
      }
    }
  </script>

</body>
</html>
