<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="config.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no, viewport-fit=cover">
  <title>WIEVER - Welcome</title>

  <script src="https://cdn.tailwindcss.com"></script>
  <script>
    tailwind.config = {
      theme: {
        extend: {
          colors: {
            'stage-primary': '#BE123C',
            'stage-secondary': '#D4AF37',
            'stage-bg': '#0a0a0a',
            'stage-surface': '#1a1a1a',
            'stage-text': '#F8FAFC',
            'stage-text-sub': '#a1a1aa',
            'stage-gold-glow': '#FFD700',
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
    body {
      background: linear-gradient(180deg, #0f0f0f 0%, #000000 100%);
      min-height: 100vh;
    }
    .glass-card {
      background: rgba(26, 26, 26, 0.7);
      backdrop-filter: blur(16px);
      border: 1px solid rgba(212, 175, 55, 0.2);
      box-shadow: 0 0 40px rgba(0,0,0,0.8), 0 0 15px rgba(212, 175, 55, 0.05);
    }
    .login-bg {
      background: radial-gradient(circle at top right, rgba(190, 18, 60, 0.1), transparent 50%),
                  radial-gradient(circle at bottom left, rgba(212, 175, 55, 0.05), transparent 50%);
    }
  </style>
</head>

<body class="text-stage-text font-sans min-h-screen flex flex-col items-center justify-center login-bg">

  <main class="flex-1 flex items-center justify-center p-6 w-full">
    <div class="w-full max-w-md">

      <!-- Logo -->
      <div class="text-center mb-10">
        <h1 class="text-5xl font-serif text-stage-secondary tracking-tighter mb-2 drop-shadow-[0_0_15px_rgba(212,175,55,0.3)]">WIEVER</h1>
        <p class="text-stage-text-sub text-sm font-medium tracking-widest uppercase">The Stage is Yours</p>
      </div>

      <!-- Card -->
      <div class="glass-card rounded-3xl p-8 shadow-2xl space-y-6">

        <div class="flex justify-center">
          <div class="w-16 h-16 rounded-full bg-stage-secondary/10 flex items-center justify-center border border-stage-secondary/30">
            <i class="bi bi-star-fill text-stage-secondary text-2xl"></i>
          </div>
        </div>

        <div class="text-center">
          <h2 class="text-2xl font-bold mb-1">Welcome</h2>
          <p class="text-stage-text-sub text-sm">카카오 로그인이 완료되었습니다.</p>
        </div>

        <div class="border-t border-stage-secondary/20"></div>

        <!-- User Info -->
        <div class="space-y-4">
          <c:if test="${not empty code}">
            <div class="space-y-1.5">
              <label class="text-[10px] font-bold text-stage-text-sub uppercase tracking-widest">Authorization Code</label>
              <div class="bg-black/60 border border-stage-secondary/30 rounded-xl p-3 font-mono text-xs text-stage-secondary break-all">${code}</div>
            </div>
          </c:if>

          <c:if test="${not empty userInfo}">
            <div class="space-y-1.5">
              <label class="text-[10px] font-bold text-stage-text-sub uppercase tracking-widest">User Information</label>
              <div class="bg-black/60 border border-stage-secondary/30 rounded-xl p-3 font-mono text-xs text-stage-secondary break-all">${userInfo}</div>
            </div>
          </c:if>
        </div>

        <div class="border-t border-stage-secondary/20"></div>

        <!-- Actions -->
        <div class="space-y-3">
          <a href="https://kauth.kakao.com/oauth/logout?client_id=2aad40910868e3c5fa9594f8de34a07b&logout_redirect_uri=${baseURL}/member/do"
             class="w-full bg-stage-primary hover:bg-rose-700 text-white font-bold py-3.5 rounded-xl shadow-lg shadow-rose-900/20 transition-all transform active:scale-[0.98] flex items-center justify-center gap-2">
            <i class="bi bi-box-arrow-right"></i> 로그아웃
          </a>
          <a href="${baseURL}/"
             class="w-full bg-stage-surface hover:bg-white/10 text-stage-text font-bold py-3.5 rounded-xl border border-white/20 transition-all transform active:scale-[0.98] flex items-center justify-center gap-2">
            <i class="bi bi-house-door"></i> 홈으로 이동
          </a>
        </div>
      </div>

      <p class="text-center text-[10px] text-stage-text-sub mt-6">
        <i class="bi bi-shield-check text-stage-secondary"></i> Secure OAuth Session
      </p>
    </div>
  </main>

  <footer class="py-10 text-center">
    <p class="text-[10px] font-serif font-bold tracking-[0.4em] uppercase text-stage-secondary">&copy; Weiver 2023. THE STAGE IS YOURS.</p>
  </footer>

</body>
</html>
