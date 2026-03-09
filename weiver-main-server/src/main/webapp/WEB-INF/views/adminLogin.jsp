<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="config.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>WIEVER Admin - Login</title>

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
  <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

  <style>
    .admin-bg {
      background: radial-gradient(circle at top right, rgba(190, 18, 60, 0.12), transparent 50%),
                  radial-gradient(circle at bottom left, rgba(212, 175, 55, 0.05), transparent 50%);
    }
    .glass-card {
      background: rgba(26, 26, 26, 0.8);
      backdrop-filter: blur(20px);
      border: 1px solid rgba(212, 175, 55, 0.2);
      box-shadow: 0 0 40px rgba(0,0,0,0.8), 0 0 15px rgba(212, 175, 55, 0.05);
    }
  </style>
</head>

<body class="bg-stage-bg text-stage-text font-sans min-h-screen flex items-center justify-center admin-bg" style="background: linear-gradient(180deg, #0f0f0f 0%, #000000 100%); min-height: 100vh;">

  <div class="w-full max-w-sm px-6">

    <!-- Logo -->
    <div class="text-center mb-10">
      <div class="inline-flex items-center justify-center w-16 h-16 bg-stage-primary/10 rounded-2xl border border-stage-primary/20 mb-4">
        <i class="bi bi-shield-lock-fill text-3xl text-stage-primary"></i>
      </div>
      <h1 class="text-4xl font-serif text-stage-primary tracking-tighter">WIEVER</h1>
      <p class="text-stage-text-sub text-xs font-bold tracking-[0.2em] uppercase mt-1">Admin Dashboard</p>
    </div>

    <!-- Login Card -->
    <div class="glass-card rounded-3xl p-8 shadow-2xl">
      <h2 class="text-xl font-bold mb-6 text-center">관리자 로그인</h2>

      <form id="login-form" class="space-y-5">
        <div class="space-y-2">
          <label class="text-xs font-bold text-stage-text-sub uppercase tracking-widest ml-1">관리자 아이디</label>
          <div class="relative">
            <input type="text" name="adminId" placeholder="아이디를 입력하세요" required
              class="w-full bg-black/60 border border-stage-secondary/40 rounded-xl py-3.5 px-4 pl-10 focus:outline-none focus:border-stage-primary transition-all placeholder-stage-text-sub/40">
            <i class="bi bi-person absolute left-3.5 top-1/2 -translate-y-1/2 text-stage-text-sub"></i>
          </div>
        </div>

        <div class="space-y-2">
          <label class="text-xs font-bold text-stage-text-sub uppercase tracking-widest ml-1">비밀번호</label>
          <div class="relative">
            <input type="password" name="adminPw" placeholder="비밀번호를 입력하세요" required
              class="w-full bg-black/60 border border-stage-secondary/40 rounded-xl py-3.5 px-4 pl-10 focus:outline-none focus:border-stage-primary transition-all placeholder-stage-text-sub/40">
            <i class="bi bi-lock absolute left-3.5 top-1/2 -translate-y-1/2 text-stage-text-sub"></i>
          </div>
        </div>

        <button type="submit" class="w-full bg-stage-primary hover:bg-rose-700 text-white font-bold py-3.5 rounded-xl shadow-lg shadow-rose-900/30 transition-all transform active:scale-[0.98] mt-2">
          <i class="bi bi-box-arrow-in-right mr-2"></i>입장하기
        </button>
      </form>

      <div class="mt-5 text-center">
        <a href="${baseURL}/admin/signup" class="text-xs text-stage-text-sub hover:text-stage-secondary transition-colors underline underline-offset-4 decoration-stage-secondary/50">
          관리자 계정 생성
        </a>
      </div>
    </div>

    <p class="text-center text-[10px] text-stage-text-sub font-bold uppercase tracking-[0.2em] mt-8">
      &copy; Weiver 2023. Admin Panel.
    </p>
  </div>

  <script>
    const loginForm = document.querySelector("#login-form");
    loginForm.addEventListener("submit", function(event) {
      event.preventDefault();
      const formData = new FormData(loginForm);
      axios.post("/ad/loginTest", formData)
        .then(response => {
          if (response.status === 200) {
            alert(response.data);
            window.location.href = "${baseURL}/admin/main";
          }
        })
        .catch((error) => {
          alert(error.response.data);
        });
    });
  </script>
</body>
</html>
