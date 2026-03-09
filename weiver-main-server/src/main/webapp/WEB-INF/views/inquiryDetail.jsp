<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="config.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
  <title>WIEVER - 문의 상세</title>

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
      <a href="${baseURL}/inquiry/inquiryMain" class="text-2xl hover:text-stage-secondary transition-colors">
        <i class="bi bi-chevron-left"></i>
      </a>
      <span class="text-xl font-serif text-stage-secondary tracking-tighter">WIEVER</span>
      <div class="w-8"></div>
    </div>
  </header>

  <main class="max-w-2xl mx-auto px-4 pt-24 space-y-6">

    <!-- Page Title -->
    <div>
      <span class="text-stage-secondary font-bold tracking-[0.2em] uppercase text-xs">Support</span>
      <h1 class="text-3xl font-bold mt-1">문의 상세</h1>
    </div>

    <!-- Status Badge -->
    <div class="flex justify-end">
      <c:choose>
        <c:when test="${empty inquiry.answer}">
          <span class="px-4 py-1.5 rounded-full bg-stage-surface text-stage-text-sub text-xs font-bold uppercase tracking-widest">
            <i class="bi bi-clock mr-1"></i>답변 대기중
          </span>
        </c:when>
        <c:otherwise>
          <span class="px-4 py-1.5 rounded-full bg-stage-secondary/20 text-stage-secondary text-xs font-bold uppercase tracking-widest">
            <i class="bi bi-check-circle-fill mr-1"></i>답변 완료
          </span>
        </c:otherwise>
      </c:choose>
    </div>

    <!-- Question Card -->
    <div class="bg-stage-surface/40 border border-white/20 rounded-3xl overflow-hidden">
      <div class="p-6 border-b border-white/10">
        <span class="text-[10px] text-stage-primary font-bold uppercase tracking-widest mb-2 block">내 문의</span>
        <h2 class="text-xl font-bold leading-tight">${inquiry.title}</h2>
      </div>
      <div class="p-6">
        <p class="text-stage-text-sub text-sm leading-relaxed whitespace-pre-wrap">${inquiry.content}</p>
      </div>
    </div>

    <!-- Answer Card (if exists) -->
    <c:if test="${not empty inquiry.answer}">
      <div class="bg-stage-secondary/5 border border-stage-secondary/20 rounded-3xl overflow-hidden">
        <div class="p-6 border-b border-stage-secondary/10">
          <div class="flex items-center gap-2">
            <i class="bi bi-shield-check text-stage-secondary"></i>
            <span class="text-[10px] text-stage-secondary font-bold uppercase tracking-widest">운영팀 답변</span>
          </div>
        </div>
        <div class="p-6">
          <p class="text-stage-text text-sm leading-relaxed whitespace-pre-wrap">${inquiry.answer.answer}</p>
        </div>
      </div>
    </c:if>

    <!-- Awaiting Answer -->
    <c:if test="${empty inquiry.answer}">
      <div class="py-12 text-center space-y-3 bg-stage-surface/20 rounded-3xl border border-dashed border-white/20">
        <i class="bi bi-hourglass-split text-4xl text-stage-text-sub"></i>
        <p class="text-stage-text-sub font-medium">운영팀 검토 후 답변드리겠습니다.</p>
        <p class="text-stage-text-sub text-sm">빠른 시일 내에 답변 드릴 예정입니다.</p>
      </div>
    </c:if>

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

</body>
</html>
