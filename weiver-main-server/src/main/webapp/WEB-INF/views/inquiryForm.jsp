<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="config.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
  <title>WIEVER - 문의 작성</title>

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
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

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
      <a href="${baseURL}/inquiry/inquiryMain" class="text-2xl hover:text-stage-secondary transition-colors">
        <i class="bi bi-chevron-left"></i>
      </a>
      <span class="text-xl font-serif text-stage-secondary tracking-tighter">WIEVER</span>
      <div class="w-8"></div>
    </div>
  </header>

  <main class="max-w-2xl mx-auto px-4 pt-24 space-y-8">

    <!-- Page Title -->
    <div>
      <span class="text-stage-secondary font-bold tracking-[0.2em] uppercase text-xs">Support</span>
      <h1 class="text-3xl font-bold mt-1">문의 작성</h1>
    </div>

    <!-- Info Banner -->
    <div class="bg-stage-surface/50 border border-white/20 p-4 rounded-2xl flex items-start gap-3">
      <i class="bi bi-info-circle text-stage-secondary text-lg mt-0.5"></i>
      <p class="text-sm text-stage-text-sub leading-relaxed">문의하신 내용은 운영팀이 검토 후 답변드립니다. 빠른 답변을 위해 최대한 상세히 작성해주세요.</p>
    </div>

    <form id="inquiryForm" action="${baseURL}/inquiry/inquiryInsert" method="POST" class="space-y-6">

      <!-- Title -->
      <div class="space-y-2">
        <label class="text-xs font-bold text-stage-text-sub uppercase tracking-widest ml-1">제목</label>
        <input name="title" type="text" id="inquiryTitle" placeholder="문의 제목을 입력하세요" required
          class="w-full bg-black/60 border border-white/20 rounded-xl py-4 px-4 focus:outline-none focus:border-stage-secondary transition-all placeholder-stage-text-sub/50">
      </div>

      <!-- Content -->
      <div class="space-y-2">
        <label class="text-xs font-bold text-stage-text-sub uppercase tracking-widest ml-1">문의 내용</label>
        <textarea name="content" id="editor" rows="10" placeholder="문의하실 내용을 자세히 입력해주세요..." required
          class="w-full bg-black/60 border border-white/20 rounded-xl py-4 px-4 focus:outline-none focus:border-stage-secondary transition-all resize-none leading-relaxed placeholder-stage-text-sub/50"></textarea>
      </div>

      <!-- Submit -->
      <button type="submit" class="w-full bg-stage-primary hover:bg-rose-700 text-white font-bold py-4 rounded-xl shadow-lg shadow-rose-900/20 transition-all transform active:scale-[0.98]">
        <i class="bi bi-send mr-2"></i>문의 제출하기
      </button>

    </form>
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

</body>
</html>
