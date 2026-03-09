<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="config.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>WIEVER Admin - 계정 생성</title>

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
      background: radial-gradient(circle at top left, rgba(190, 18, 60, 0.1), transparent 50%),
                  radial-gradient(circle at bottom right, rgba(212, 175, 55, 0.05), transparent 50%);
    }
    .glass-card {
      background: rgba(26, 26, 26, 0.8);
      backdrop-filter: blur(20px);
      border: 1px solid rgba(212, 175, 55, 0.2);
      box-shadow: 0 0 40px rgba(0,0,0,0.8), 0 0 15px rgba(212, 175, 55, 0.05);
    }
  </style>
</head>

<body class="bg-stage-bg text-stage-text font-sans min-h-screen flex items-center justify-center admin-bg py-10" style="background: linear-gradient(180deg, #0f0f0f 0%, #000000 100%); min-height: 100vh;">

  <div class="w-full max-w-sm px-6">

    <!-- Header -->
    <div class="flex items-center justify-between mb-8">
      <a href="${baseURL}/admin/login" class="text-stage-text-sub hover:text-stage-secondary transition-colors text-2xl">
        <i class="bi bi-chevron-left"></i>
      </a>
      <div class="text-center">
        <h1 class="text-2xl font-serif text-stage-primary tracking-tighter">WIEVER</h1>
        <p class="text-stage-text-sub text-[10px] font-bold tracking-widest uppercase">Admin</p>
      </div>
      <div class="w-8"></div>
    </div>

    <!-- Title -->
    <div class="text-center mb-8">
      <h2 class="text-2xl font-bold">관리자 계정 생성</h2>
      <p class="text-stage-text-sub text-sm mt-1">새 관리자 계정을 등록합니다.</p>
    </div>

    <!-- Form Card -->
    <div class="glass-card rounded-3xl p-8 shadow-2xl">
      <form id="signupForm" action="${baseURL}/ad/signupTest" method="post" class="space-y-5">

        <div class="space-y-2">
          <label class="text-xs font-bold text-stage-text-sub uppercase tracking-widest ml-1">관리자 아이디</label>
          <input id="adminId" type="text" name="adminId" placeholder="아이디를 입력하세요" required
            class="w-full bg-black/60 border border-stage-secondary/40 rounded-xl py-3.5 px-4 focus:outline-none focus:border-stage-primary transition-all placeholder-stage-text-sub/40" style="text-transform: lowercase">
        </div>

        <div class="space-y-2">
          <label class="text-xs font-bold text-stage-text-sub uppercase tracking-widest ml-1">비밀번호</label>
          <input type="password" name="adminPw" placeholder="비밀번호를 입력하세요" required
            class="w-full bg-black/60 border border-stage-secondary/40 rounded-xl py-3.5 px-4 focus:outline-none focus:border-stage-primary transition-all placeholder-stage-text-sub/40">
        </div>

        <div class="space-y-2">
          <label class="text-xs font-bold text-stage-text-sub uppercase tracking-widest ml-1">비밀번호 확인</label>
          <input type="password" name="adminPwCheck" placeholder="비밀번호를 다시 입력하세요" required
            class="w-full bg-black/60 border border-stage-secondary/40 rounded-xl py-3.5 px-4 focus:outline-none focus:border-stage-primary transition-all placeholder-stage-text-sub/40">
        </div>

        <div class="space-y-2">
          <label class="text-xs font-bold text-stage-text-sub uppercase tracking-widest ml-1">이름</label>
          <input type="text" name="adminName" placeholder="이름을 입력하세요" required
            class="w-full bg-black/60 border border-stage-secondary/40 rounded-xl py-3.5 px-4 focus:outline-none focus:border-stage-primary transition-all placeholder-stage-text-sub/40">
        </div>

        <button type="button" class="signupBtn w-full bg-stage-primary hover:bg-rose-700 text-white font-bold py-3.5 rounded-xl shadow-lg shadow-rose-900/30 transition-all transform active:scale-[0.98]">
          <i class="bi bi-person-plus mr-2"></i>계정 생성하기
        </button>
      </form>
    </div>

    <p class="text-center text-[10px] text-stage-text-sub font-bold uppercase tracking-[0.2em] mt-8">
      &copy; Weiver 2023. Admin Panel.
    </p>
  </div>

  <script>
    const signupButton = document.querySelector(".signupBtn");
    const signupForm = document.querySelector("#signupForm");
    const emailValue = document.querySelector("#adminId");

    emailValue.addEventListener("input", (e) => {
      e.target.value = e.target.value.toLowerCase();
    });

    signupButton.addEventListener("click", (event) => {
      event.preventDefault();
      if (signupForm.checkValidity()) {
        const formData = new FormData(signupForm);
        axios.post("/ad/signupTest", formData)
          .then(response => {
            if (response.status === 200) {
              alert(response.data);
              window.location.href = "${baseURL}/admin/login";
            }
          })
          .catch((error) => {
            alert(error.response.data);
          });
      } else {
        signupForm.reportValidity();
      }
    });
  </script>
</body>
</html>
