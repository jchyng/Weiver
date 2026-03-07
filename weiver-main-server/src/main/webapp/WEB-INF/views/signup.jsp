<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="config.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>WIEVER - Become a Member</title>

    <!-- Tailwind CSS CDN -->
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

    <!-- Fonts & Icons -->
    <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.8/dist/web/static/pretendard.css" />
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&family=Cinzel:wght@600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

    <!-- axios -->
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

    <style>
      .login-bg {
        background: radial-gradient(circle at top left, rgba(190, 18, 60, 0.1), transparent),
                    radial-gradient(circle at bottom right, rgba(212, 175, 55, 0.05), transparent);
      }
      .glass-card {
        background: rgba(26, 26, 26, 0.7);
        backdrop-filter: blur(16px);
        border: 1px solid rgba(212, 175, 55, 0.2);
        box-shadow: 0 0 40px rgba(0,0,0,0.8), 0 0 15px rgba(212, 175, 55, 0.05);
      }
      .modal-bg {
        background: rgba(10, 10, 10, 0.8);
        backdrop-filter: blur(8px);
      }
    </style>
</head>

<body class="bg-stage-bg text-stage-text font-sans min-h-screen login-bg pb-20" style="background: linear-gradient(180deg, #0f0f0f 0%, #000000 100%); min-height: 100vh;">

  <!-- Header -->
  <header class="max-w-7xl mx-auto px-4 h-20 flex items-center justify-between">
    <a href="${baseURL}/login" class="text-2xl hover:text-stage-secondary transition-colors">
      <i class="bi bi-chevron-left"></i>
    </a>
    <h1 class="text-3xl font-serif text-stage-secondary tracking-tighter drop-shadow-[0_0_15px_rgba(212,175,55,0.3)]">WIEVER</h1>
    <div class="w-8"></div>
  </header>

  <main class="max-w-xl mx-auto px-6 pt-10">
    <div class="text-center mb-10">
      <h2 class="text-3xl font-bold mb-2">BECOME A MEMBER</h2>
      <p class="text-stage-text-sub text-sm">환영합니다! 무대의 주인공이 되어보세요.</p>
    </div>

    <div class="glass-card rounded-3xl p-8 shadow-2xl">
      <form id="signupForm" class="space-y-6">
        <!-- ID (Email) -->
        <div class="space-y-2">
          <label class="text-xs font-bold text-stage-text-sub uppercase tracking-widest ml-1">이메일 주소</label>
          <input id="userId" type="email" name="userId" placeholder="example@weiver.com" required
            class="w-full bg-black/60 border border-stage-secondary/40 rounded-xl py-4 px-4 focus:outline-none focus:border-stage-secondary transition-all">
        </div>

        <!-- Password -->
        <div class="space-y-2">
          <label class="text-xs font-bold text-stage-text-sub uppercase tracking-widest ml-1">비밀번호</label>
          <input type="password" name="userPw" placeholder="6~20자 사이의 비밀번호" minlength="6" maxlength="20" required
            class="w-full bg-black/60 border border-stage-secondary/40 rounded-xl py-4 px-4 focus:outline-none focus:border-stage-secondary transition-all">
        </div>

        <div class="space-y-2">
          <label class="text-xs font-bold text-stage-text-sub uppercase tracking-widest ml-1">비밀번호 확인</label>
          <input type="password" name="userPwCheck" placeholder="비밀번호를 다시 입력하세요" required
            class="w-full bg-black/60 border border-stage-secondary/40 rounded-xl py-4 px-4 focus:outline-none focus:border-stage-secondary transition-all">
        </div>

        <!-- Nickname -->
        <div class="space-y-2">
          <label class="text-xs font-bold text-stage-text-sub uppercase tracking-widest ml-1">닉네임</label>
          <input type="text" name="userNickname" placeholder="무대에서 불릴 이름" required
            class="w-full bg-black/60 border border-stage-secondary/40 rounded-xl py-4 px-4 focus:outline-none focus:border-stage-secondary transition-all">
        </div>

        <!-- Clauses -->
        <div class="pt-4 space-y-4">
          <div class="clause-item flex items-center justify-between p-4 bg-black/40 rounded-xl border border-white/10">
            <div class="flex items-center gap-3">
              <input type="checkbox" class="signupCheckBox w-5 h-5 rounded border-stage-secondary/40 bg-stage-bg text-stage-primary focus:ring-stage-primary focus:ring-offset-stage-bg">
              <span class="text-sm font-medium">[필수] 이용약관 동의</span>
            </div>
            <button type="button" onclick="openModal('modal-terms')" class="text-[10px] font-bold text-stage-text-sub hover:text-stage-secondary transition-colors uppercase tracking-widest underline decoration-stage-secondary/50">약관보기</button>
          </div>

          <div class="clause-item flex items-center justify-between p-4 bg-black/40 rounded-xl border border-white/10">
            <div class="flex items-center gap-3">
              <input type="checkbox" class="signupCheckBox w-5 h-5 rounded border-stage-secondary/40 bg-stage-bg text-stage-primary focus:ring-stage-primary focus:ring-offset-stage-bg">
              <span class="text-sm font-medium">[필수] 개인정보 수집 동의</span>
            </div>
            <button type="button" onclick="openModal('modal-privacy')" class="text-[10px] font-bold text-stage-text-sub hover:text-stage-secondary transition-colors uppercase tracking-widest underline decoration-stage-secondary/50">약관보기</button>
          </div>

          <div class="clause-item flex items-center justify-between p-4 bg-black/40 rounded-xl border border-white/10">
            <div class="flex items-center gap-3">
              <input type="checkbox" class="signupCheckBox w-5 h-5 rounded border-stage-secondary/40 bg-stage-bg text-stage-primary focus:ring-stage-primary focus:ring-offset-stage-bg">
              <span class="text-sm font-medium">[필수] 만 14세 이상 확인</span>
            </div>
            <button type="button" onclick="openModal('modal-age')" class="text-[10px] font-bold text-stage-text-sub hover:text-stage-secondary transition-colors uppercase tracking-widest underline decoration-stage-secondary/50">약관보기</button>
          </div>
        </div>

        <button id="signupBtn" type="button" disabled class="w-full bg-slate-700 text-stage-text-sub font-bold py-4 rounded-xl transition-all transform active:scale-[0.98] disabled:cursor-not-allowed">
          가입하기
        </button>
      </form>
    </div>
  </main>

  <!-- Modals -->
  <div id="modal-terms" class="fixed inset-0 z-[100] hidden flex items-center justify-center p-6">
    <div class="modal-bg absolute inset-0" onclick="closeModal('modal-terms')"></div>
    <div class="relative w-full max-w-lg bg-stage-surface border border-stage-secondary/40 rounded-3xl p-8 shadow-2xl animate-fade-in-up">
      <h3 class="text-xl font-bold mb-4">이용약관</h3>
      <div class="h-64 overflow-y-auto text-sm text-stage-text-sub leading-relaxed pr-2 custom-scrollbar">
        본 서비스 약관에는 WEIVER의 사업 운영 방식, WEIVER에 적용되는 법률, WEIVER이 항상 진실이라고 여기는 특정 내용이 반영되어 있습니다. 따라서 귀하가 WEIVER 서비스와 상호작용하면 본 서비스 약관을 근거로 WEIVER과의 관계가 정의됩니다.
      </div>
      <button onclick="closeModal('modal-terms')" class="w-full mt-6 bg-stage-surface hover:bg-white/10 py-3 rounded-xl font-bold transition-all">확인</button>
    </div>
  </div>
  <!-- ... Privacy and Age modals can be added similarly ... -->

  <footer class="mt-10 py-10 text-center">
    <p class="text-[10px] font-serif font-bold tracking-[0.4em] uppercase text-stage-secondary">&copy; Weiver 2023. THE STAGE IS YOURS.</p>
  </footer>

  <script>
    function openModal(id) { document.getElementById(id).classList.remove('hidden'); }
    function closeModal(id) { document.getElementById(id).classList.add('hidden'); }

    const signupForm = document.querySelector("#signupForm");
    const signupBtn = document.querySelector("#signupBtn");
    const checkBoxes = document.querySelectorAll(".signupCheckBox");

    checkBoxes.forEach(box => {
      box.addEventListener("change", () => {
        const allChecked = Array.from(checkBoxes).every(b => b.checked);
        signupBtn.disabled = !allChecked;
        if (allChecked) {
          signupBtn.classList.remove('bg-slate-700', 'text-stage-text-sub');
          signupBtn.classList.add('bg-stage-primary', 'text-white', 'shadow-lg', 'shadow-rose-900/20');
        } else {
          signupBtn.classList.add('bg-slate-700', 'text-stage-text-sub');
          signupBtn.classList.remove('bg-stage-primary', 'text-white', 'shadow-lg', 'shadow-rose-900/20');
        }
      });
    });

    signupBtn.addEventListener("click", () => {
      if (signupForm.checkValidity()) {
        const formData = new FormData(signupForm);
        axios.post("${baseURL}/signupTest", formData)
          .then(res => {
            alert(res.data);
            window.location.href = "${baseURL}/login";
          })
          .catch(err => alert(err.response.data || "회원가입에 실패했습니다."));
      } else {
        signupForm.reportValidity();
      }
    });
  </script>
</body>
</html>
