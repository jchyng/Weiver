<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="config.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
  <title>WIEVER - 프로필 수정</title>

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
      <h1 class="text-3xl font-bold mt-1">프로필 수정</h1>
    </div>

    <form action="${baseURL}/mypage/update" method="POST" enctype="multipart/form-data" class="space-y-8">

      <!-- Profile Image -->
      <div class="flex flex-col items-center gap-4">
        <div class="relative">
          <div class="w-32 h-32 rounded-full p-1 bg-gradient-to-tr from-stage-primary to-stage-secondary">
            <div class="w-full h-full rounded-full overflow-hidden border-4 border-slate-900 bg-stage-surface">
              <img class="image-box w-full h-full object-cover" src="${requestScope.userInfo.profileImg != null ? requestScope.userInfo.profileImg : '/img/Default_Profile.png'}" alt="profile">
            </div>
          </div>
          <button type="button" onclick="onClickUpload()" class="absolute bottom-0 right-0 w-9 h-9 bg-stage-primary hover:bg-rose-700 text-white rounded-full flex items-center justify-center shadow-lg transition-all">
            <i class="bi bi-camera-fill text-sm"></i>
          </button>
        </div>
        <input id="my-img" type="file" accept="image/*" name="profileImg" class="hidden">
        <p class="text-xs text-stage-text-sub">프로필 사진을 변경하려면 카메라 아이콘을 클릭하세요</p>
      </div>

      <!-- Input Fields -->
      <div class="space-y-5">
        <!-- ID (Read-only) -->
        <div class="space-y-2">
          <label class="text-xs font-bold text-stage-text-sub uppercase tracking-widest ml-1">이메일 (ID)</label>
          <input name="userId" type="email" readonly value="${requestScope.userInfo.id}"
            class="w-full bg-black/40 border border-white/10 rounded-xl py-4 px-4 text-stage-text-sub cursor-not-allowed opacity-60">
        </div>

        <!-- Nickname -->
        <div class="space-y-2">
          <label class="text-xs font-bold text-stage-text-sub uppercase tracking-widest ml-1">닉네임</label>
          <input id="name" name="nickname" type="text" value="${requestScope.userInfo.nickname}"
            class="w-full bg-black/60 border border-white/20 rounded-xl py-4 px-4 focus:outline-none focus:border-stage-secondary transition-all">
        </div>
      </div>

      <!-- Submit Button -->
      <button class="submit_btn w-full bg-slate-700 text-stage-text-sub font-bold py-4 rounded-xl transition-all transform active:scale-[0.98] disabled:cursor-not-allowed" type="submit" disabled>
        저장하기
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

  <script>
    function onClickUpload() {
      document.getElementById("my-img").click();
    }

    $(document).ready(function() {
      $('#my-img, #name').on('change input', function() {
        var btn = document.querySelector(".submit_btn");
        btn.disabled = false;
        btn.classList.remove('bg-slate-700', 'text-stage-text-sub');
        btn.classList.add('bg-stage-primary', 'hover:bg-rose-700', 'text-white', 'shadow-lg', 'shadow-rose-900/20');
      });
    });

    const fileDOM = document.querySelector('#my-img');
    const preview = document.querySelector('.image-box');

    fileDOM.addEventListener('change', () => {
      const reader = new FileReader();
      reader.onload = ({target}) => {
        preview.src = target.result;
      };
      reader.readAsDataURL(fileDOM.files[0]);
    });
  </script>

</body>
</html>
