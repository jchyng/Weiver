<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="config.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
  <title>WIEVER - 댓글 스레드</title>

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
    .rereply-card {
      border-left: 2px solid #BE123C;
    }
  </style>
</head>

<body class="bg-stage-bg text-stage-text font-sans pb-32 min-h-screen" style="background: linear-gradient(180deg, #0f0f0f 0%, #000000 100%); min-height: 100vh;">

  <!-- Header -->
  <header class="fixed top-0 left-0 w-full z-50 glass-nav">
    <div class="max-w-7xl mx-auto px-4 h-16 flex items-center justify-between">
      <a href="javascript:history.back();" class="text-2xl hover:text-stage-secondary transition-colors">
        <i class="bi bi-chevron-left"></i>
      </a>
      <span class="text-xl font-serif text-stage-secondary tracking-tighter">WIEVER</span>
      <div class="w-8"></div>
    </div>
  </header>

  <main class="max-w-2xl mx-auto px-4 pt-24 space-y-6">

    <!-- Original Comment -->
    <div class="bg-stage-surface/40 border border-white/20/60 p-5 rounded-2xl space-y-2">
      <div class="flex items-center gap-2">
        <div class="w-7 h-7 rounded-full bg-stage-surface flex items-center justify-center border border-white/20">
          <i class="bi bi-person text-sm text-stage-text-sub"></i>
        </div>
        <span class="font-bold text-sm text-stage-secondary">@${reply.user.nickname}</span>
      </div>
      <p class="text-sm leading-relaxed pl-9">${reply.content}</p>
    </div>

    <!-- Replies -->
    <c:if test="${not empty rereply}">
      <div class="space-y-3 pl-4">
        <p class="text-[10px] text-stage-text-sub font-bold uppercase tracking-widest flex items-center gap-2">
          <i class="bi bi-arrow-return-right"></i>대댓글 ${rereply.size()}개
        </p>
        <c:forEach var="reReply" items="${rereply}">
          <div class="rereply-card bg-stage-surface/20 p-4 rounded-r-2xl space-y-2 pl-4">
            <div class="flex items-center gap-2">
              <div class="w-6 h-6 rounded-full bg-stage-surface flex items-center justify-center border border-white/20">
                <i class="bi bi-person text-[10px] text-stage-text-sub"></i>
              </div>
              <span class="font-bold text-xs text-stage-primary/80">@${reReply.user.nickname}</span>
            </div>
            <p class="text-sm leading-relaxed pl-8">${reReply.content}</p>
          </div>
        </c:forEach>
      </div>
    </c:if>

    <c:if test="${empty rereply}">
      <div class="py-12 text-center space-y-3 bg-stage-surface/20 rounded-3xl border border-dashed border-white/20">
        <i class="bi bi-chat-square text-4xl text-stage-text-sub"></i>
        <p class="text-stage-text-sub text-sm">아직 대댓글이 없습니다. 첫 번째 대댓글을 남겨보세요!</p>
      </div>
    </c:if>

  </main>

  <!-- Reply Input (Fixed Bottom) -->
  <div class="fixed bottom-16 left-0 w-full glass-nav px-4 py-4 z-40 border-t border-white/10">
    <div class="max-w-2xl mx-auto">
      <form action="${baseURL}/community/insert/rereply/${reply.post.id}/${reply.id}" method="post" class="flex gap-3">
        <input name="content" type="text" placeholder="대댓글을 입력하세요..." required
          class="flex-1 bg-black/60 border border-white/20 rounded-xl py-3 px-4 focus:outline-none focus:border-stage-secondary transition-all text-sm placeholder-stage-text-sub/50">
        <button type="submit" class="bg-stage-primary hover:bg-rose-700 text-white px-6 rounded-xl font-bold text-sm transition-all shadow-lg shadow-rose-900/20 shrink-0">
          등록
        </button>
      </form>
    </div>
  </div>

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
