<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="config.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>WIEVER - Welcome to the Stage</title>

    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
      tailwind.config = {
        theme: {
          extend: {
            colors: {
              'stage-gold': '#D4AF37',
              'stage-gold-glow': '#FFD700',
              'stage-primary': '#BE123C',
              'stage-bg': '#050505',
              'stage-surface': '#121212',
              'stage-text': '#F8FAFC',
              'stage-text-sub': '#94A3B8',
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

    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

    <style>
      /* Autofill background fix */
      input:-webkit-autofill,
      input:-webkit-autofill:hover,
      input:-webkit-autofill:focus {
        -webkit-text-fill-color: #F8FAFC;
        -webkit-box-shadow: 0 0 0px 1000px #0a0a0a inset;
        transition: background-color 5000s ease-in-out 0s;
      }

      .premium-gradient {
        background: radial-gradient(circle at 50% -20%, rgba(190, 18, 60, 0.15) 0%, transparent 50%),
                    radial-gradient(circle at 0% 100%, rgba(212, 175, 55, 0.05) 0%, transparent 40%);
      }

      .glass-container {
        background: rgba(18, 18, 18, 0.7);
        backdrop-filter: blur(24px);
        -webkit-backdrop-filter: blur(24px);
        border: 1px solid rgba(212, 175, 55, 0.15);
        box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.7);
      }

      .input-wrapper:focus-within label,
      .input-wrapper.has-content label {
        transform: translateY(-28px) scale(0.85);
        color: #D4AF37;
      }

      .form-input {
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
      }

      .form-input:focus {
        border-color: #D4AF37;
        box-shadow: 0 0 15px rgba(212, 175, 55, 0.1);
      }

      @keyframes slideUp {
        from { opacity: 0; transform: translateY(20px); }
        to { opacity: 1; transform: translateY(0); }
      }
      .animate-slide-up { animation: slideUp 0.8s ease-out forwards; }
    </style>
</head>

<body class="bg-stage-bg text-stage-text font-sans min-h-screen flex flex-col premium-gradient overflow-hidden">

  <main class="flex-1 flex flex-col items-center justify-center p-6 relative">
    <!-- Decorative background elements -->
    <div class="absolute top-1/4 left-1/4 w-64 h-64 bg-rose-900/10 rounded-full blur-[120px] pointer-events-none"></div>
    <div class="absolute bottom-1/4 right-1/4 w-96 h-96 bg-stage-gold/5 rounded-full blur-[150px] pointer-events-none"></div>

    <div class="w-full max-w-md animate-slide-up">
      
      <!-- Brand Logo -->
      <div class="text-center mb-12">
        <a href="${baseURL}/" class="inline-block group">
          <h1 class="text-6xl font-serif text-stage-gold tracking-tighter mb-3 transition-transform duration-500 group-hover:scale-105">WIEVER</h1>
          <div class="flex items-center justify-center gap-3">
            <span class="h-px w-8 bg-stage-gold/30"></span>
            <p class="text-stage-text-sub text-xs font-bold tracking-[0.4em] uppercase">The Stage is Yours</p>
            <span class="h-px w-8 bg-stage-gold/30"></span>
          </div>
        </a>
      </div>

      <!-- Login Card -->
      <div class="glass-container rounded-[2.5rem] p-10 md:p-12">
        <div class="mb-10 text-center">
          <h2 class="text-2xl font-bold tracking-tight">공연장 입장</h2>
          <p class="text-stage-text-sub text-sm mt-2">당신만의 뮤지컬 이야기가 시작됩니다</p>
        </div>
        
        <form id="login-form" class="space-y-8">
          <div class="input-wrapper relative">
            <label class="absolute left-0 top-3 text-stage-text-sub pointer-events-none transition-all duration-300 origin-left">이메일 주소</label>
            <input type="email" name="userId" required oninput="checkContent(this)"
              class="form-input w-full bg-transparent border-b-2 border-white/10 py-3 focus:outline-none focus:border-stage-gold transition-all text-white">
          </div>

          <div class="input-wrapper relative">
            <label class="absolute left-0 top-3 text-stage-text-sub pointer-events-none transition-all duration-300 origin-left">비밀번호</label>
            <input type="password" name="userPw" required oninput="checkContent(this)"
              class="form-input w-full bg-transparent border-b-2 border-white/10 py-3 focus:outline-none focus:border-stage-gold transition-all text-white">
          </div>

          <div class="pt-4">
            <button type="submit" class="w-full bg-stage-primary hover:bg-rose-700 text-white font-bold py-4 rounded-2xl shadow-2xl shadow-rose-900/40 transition-all transform active:scale-[0.98] flex items-center justify-center gap-2 overflow-hidden relative group">
              <span class="relative z-10">입장하기</span>
              <div class="absolute inset-0 bg-gradient-to-r from-transparent via-white/10 to-transparent -translate-x-full group-hover:translate-x-full transition-transform duration-700"></div>
            </button>
          </div>
        </form>

        <div class="mt-10 flex items-center justify-between text-xs font-bold uppercase tracking-widest text-stage-text-sub">
          <a href="${baseURL}/signup" class="hover:text-stage-gold transition-colors py-2 border-b border-transparent hover:border-stage-gold/50">회원가입</a>
          <span class="w-1 h-1 rounded-full bg-white/10"></span>
          <a href="#" class="hover:text-stage-gold transition-colors py-2 border-b border-transparent hover:border-stage-gold/50">비밀번호 찾기</a>
        </div>
      </div>

      <!-- Admin Link -->
      <div class="mt-8 text-center">
        <a href="${baseURL}/admin/login" class="text-[10px] font-bold text-white/20 hover:text-stage-gold transition-colors uppercase tracking-[0.2em]">
          Administrator Access
        </a>
      </div>
    </div>
  </main>

  <footer class="py-10 text-center opacity-30">
    <p class="text-[9px] font-serif font-bold tracking-[0.5em] uppercase text-stage-gold">&copy; Weiver 2023. All Rights Reserved.</p>
  </footer>

  <script>
    function checkContent(input) {
      if (input.value.length > 0) {
        input.parentElement.classList.add('has-content');
      } else {
        input.parentElement.classList.remove('has-content');
      }
    }

    const loginForm = document.querySelector("#login-form");
    loginForm.addEventListener("submit", function (event) {
        event.preventDefault();
        const formData = new FormData(loginForm);
        const submitBtn = loginForm.querySelector('button[type="submit"]');
        submitBtn.disabled = true;
        submitBtn.innerHTML = '<i class="bi bi-arrow-repeat animate-spin text-xl"></i>';
    
        axios.post("${baseURL}/loginTest", formData)
        		.then(response => {
        			if(response.status === 200) {
        				window.location.href = "${baseURL}/";
        			}
  	   			})
  	   			.catch((error) => {
  	   				alert(error.response.data || "로그인에 실패했습니다.");
              submitBtn.disabled = false;
              submitBtn.innerHTML = '입장하기';
  	   			});
   	});
  </script>
</body>
</html>
