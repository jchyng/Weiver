<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="config.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
  <title>WIEVER - 문의하기</title>

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
      <a href="${baseURL}/mypage/setting" class="text-2xl hover:text-stage-secondary transition-colors">
        <i class="bi bi-chevron-left"></i>
      </a>
      <span class="text-xl font-serif text-stage-secondary tracking-tighter">WIEVER</span>
      <div class="w-8"></div>
    </div>
  </header>

  <main class="max-w-2xl mx-auto px-4 pt-24 space-y-8">

    <!-- Page Title + Write Button -->
    <div class="flex items-end justify-between">
      <div>
        <span class="text-stage-secondary font-bold tracking-[0.2em] uppercase text-xs">Support</span>
        <h1 class="text-3xl font-bold mt-1">문의하기</h1>
      </div>
      <button onclick="location.href='${baseURL}/inquiry/inquiryForm'" class="bg-stage-primary hover:bg-rose-700 text-white px-5 py-2.5 rounded-xl font-bold text-sm transition-all transform active:scale-95 shadow-lg shadow-rose-900/20">
        <i class="bi bi-pencil-square mr-1.5"></i>작성하기
      </button>
    </div>

    <!-- Inquiry List -->
    <div class="space-y-3">
      <c:choose>
        <c:when test="${not empty inquiryList}">
          <c:forEach var="inquiry" items="${inquiryList}">
            <a href="${baseURL}/inquiry/inquiryDetail/${inquiry.id}" class="block group">
              <div class="bg-stage-surface/30 border border-white/10 hover:border-white/30 p-5 rounded-2xl transition-all spotlight-glow">
                <div class="flex items-start justify-between gap-4">
                  <div class="flex-1 space-y-1">
                    <p class="text-[10px] text-stage-text-sub font-bold">${inquiry.createdTime}</p>
                    <h3 class="font-bold text-base group-hover:text-stage-secondary transition-colors line-clamp-1">${inquiry.title}</h3>
                  </div>
                  <div class="shrink-0">
                    <c:choose>
                      <c:when test="${empty inquiry.answer}">
                        <span class="px-3 py-1 rounded-full bg-stage-surface text-stage-text-sub text-[10px] font-bold uppercase tracking-widest">대기중</span>
                      </c:when>
                      <c:otherwise>
                        <span class="px-3 py-1 rounded-full bg-stage-secondary/20 text-stage-secondary text-[10px] font-bold uppercase tracking-widest">답변완료</span>
                      </c:otherwise>
                    </c:choose>
                  </div>
                </div>
              </div>
            </a>
          </c:forEach>
        </c:when>
        <c:otherwise>
          <div class="py-20 text-center space-y-4 bg-stage-surface/30 rounded-3xl border border-dashed border-white/20">
            <i class="bi bi-question-circle text-5xl text-stage-text-sub"></i>
            <p class="text-stage-text-sub font-medium">아직 문의 내역이 없습니다.</p>
            <p class="text-stage-text-sub text-sm">궁금한 사항이 있으면 문의해주세요!</p>
          </div>
        </c:otherwise>
      </c:choose>
    </div>

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
