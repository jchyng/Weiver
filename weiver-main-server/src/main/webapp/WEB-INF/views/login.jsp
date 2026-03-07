<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="config.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>WIEVER - Login</title>

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
        background: radial-gradient(circle at top right, rgba(190, 18, 60, 0.15), transparent),
                    radial-gradient(circle at bottom left, rgba(212, 175, 55, 0.05), transparent);
      }
      .glass-card {
        background: rgba(26, 26, 26, 0.7);
        backdrop-filter: blur(16px);
        border: 1px solid rgba(212, 175, 55, 0.2);
        box-shadow: 0 0 40px rgba(0,0,0,0.8), 0 0 15px rgba(212, 175, 55, 0.05);
      }
      .input-field:focus + label,
      .input-field:not(:placeholder-shown) + label {
        transform: translateY(-24px) scale(0.85);
        color: var(--stage-secondary);
      }
    </style>
</head>

<body class="bg-stage-bg text-stage-text font-sans min-h-screen flex flex-col login-bg" style="background: linear-gradient(180deg, #0f0f0f 0%, #000000 100%); min-height: 100vh;">

  <main class="flex-1 flex items-center justify-center p-6">
    <div class="w-full max-w-md animate-fade-in">
      
      <!-- Logo Section -->
      <div class="text-center mb-10">
        <h1 class="text-5xl font-serif text-stage-secondary tracking-tighter mb-2 drop-shadow-[0_0_15px_rgba(212,175,55,0.3)]">WIEVER</h1>
        <p class="text-stage-text-sub text-sm font-medium tracking-widest uppercase">The Stage is Yours</p>
      </div>

      <!-- Login Card -->
      <div class="glass-card rounded-3xl p-8 shadow-2xl">
        <h2 class="text-2xl font-bold mb-8 text-center">로그인</h2>
        
        <form id="login-form" class="space-y-6">
          <div class="relative">
            <input type="email" name="userId" placeholder=" " required
              class="input-field w-full bg-black/60 border border-stage-secondary/40 rounded-xl py-4 px-4 focus:outline-none focus:border-stage-secondary transition-all peer">
            <label class="absolute left-4 top-4 text-stage-text-sub pointer-events-none transition-all duration-200 origin-left">이메일 주소</label>
          </div>

          <div class="relative">
            <input type="password" name="userPw" placeholder=" " required
              class="input-field w-full bg-black/60 border border-stage-secondary/40 rounded-xl py-4 px-4 focus:outline-none focus:border-stage-secondary transition-all peer">
            <label class="absolute left-4 top-4 text-stage-text-sub pointer-events-none transition-all duration-200 origin-left">비밀번호</label>
          </div>

          <button type="submit" class="w-full bg-stage-primary hover:bg-rose-700 text-white font-bold py-4 rounded-xl shadow-lg shadow-rose-900/20 transition-all transform active:scale-[0.98]">
            공연장 입장하기
          </button>
        </form>

        <div class="mt-6 flex items-center justify-between text-xs text-stage-text-sub font-medium">
          <a href="${baseURL}/signup" class="hover:text-stage-secondary transition-colors underline decoration-stage-secondary/50 underline-offset-4">회원가입</a>
          <a href="#" class="hover:text-stage-secondary transition-colors">비밀번호 찾기</a>
        </div>
      </div>
    </div>
  </main>


  <footer class="py-10 text-center">
    <p class="text-[10px] font-serif font-bold tracking-[0.4em] uppercase text-stage-secondary">&copy; Weiver 2023. THE STAGE IS YOURS.</p>
  </footer>

  <script>
  	const loginForm = document.querySelector("#login-form");
    
    loginForm.addEventListener("submit", function (event) {
        event.preventDefault();
        const formData = new FormData(loginForm);
    
        axios.post("${baseURL}/loginTest", formData)
        		.then(response => {
        			if(response.status === 200) {
        				window.location.href = "${baseURL}/main";
        			}
  	   			})
  	   			.catch((error) => {
  	   				alert(error.response.data || "로그인에 실패했습니다.");
  	   			});
   	});
  </script>
</body>
</html>
