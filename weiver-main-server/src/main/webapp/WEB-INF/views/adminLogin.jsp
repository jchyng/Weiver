<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="config.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
  <title>WIEVER Admin - Secure Terminal</title>

  <script src="https://cdn.tailwindcss.com"></script>
  <script>
    tailwind.config = {
      theme: {
        extend: {
          colors: {
            'admin-bg': '#020617',
            'admin-surface': '#0F172A',
            'admin-primary': '#E11D48',
            'admin-secondary': '#FB7185',
            'admin-text': '#F8FAFC',
            'admin-text-sub': '#94A3B8',
          },
          fontFamily: {
            sans: ['Inter', 'Pretendard', 'sans-serif'],
            serif: ['Cinzel', 'serif'],
          },
        }
      }
    }
  </script>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.8/dist/web/static/pretendard.css" />
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;800&family=Cinzel:wght@700;900&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
  <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

  <style>
    /* 브라우저 자동완성 배경 제거 - 가장 중요 */
    input:-webkit-autofill,
    input:-webkit-autofill:hover,
    input:-webkit-autofill:focus,
    input:-webkit-autofill:active {
      -webkit-text-fill-color: #F8FAFC !important;
      -webkit-box-shadow: 0 0 0px 1000px #1e293b inset !important;
      transition: background-color 5000s ease-in-out 0s;
    }

    body { 
      background-color: #020617;
      letter-spacing: -0.01em;
    }

    .premium-glass {
      background: rgba(15, 23, 42, 0.7);
      backdrop-filter: blur(40px) saturate(180%);
      border: 1px solid rgba(255, 255, 255, 0.08);
      box-shadow: 
        0 4px 6px -1px rgba(0, 0, 0, 0.2),
        0 20px 50px -12px rgba(0, 0, 0, 0.5),
        inset 0 1px 1px rgba(255, 255, 255, 0.05);
    }

    .input-container {
      position: relative;
      transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    }

    .input-field {
      background: rgba(30, 41, 59, 0.5);
      border: 1px solid rgba(255, 255, 255, 0.05);
      transition: all 0.3s ease;
    }

    .input-field:focus {
      background: rgba(30, 41, 59, 0.8);
      border-color: rgba(225, 29, 72, 0.5);
      box-shadow: 0 0 20px rgba(225, 29, 72, 0.1);
    }

    .btn-shine {
      position: relative;
      overflow: hidden;
    }
    
    .btn-shine::after {
      content: '';
      position: absolute;
      top: -50%;
      left: -50%;
      width: 200%;
      height: 200%;
      background: linear-gradient(
        to bottom right,
        rgba(255, 255, 255, 0) 0%,
        rgba(255, 255, 255, 0) 40%,
        rgba(255, 255, 255, 0.1) 50%,
        rgba(255, 255, 255, 0) 60%,
        rgba(255, 255, 255, 0) 100%
      );
      transform: rotate(45deg);
      transition: transform 0.6s ease;
    }

    .btn-shine:hover::after {
      transform: rotate(45deg) translate(20%, 20%);
    }

    @keyframes entry {
      from { opacity: 0; transform: translateY(30px) scale(0.95); }
      to { opacity: 1; transform: translateY(0) scale(1); }
    }
    .animate-entry { animation: entry 1s cubic-bezier(0.16, 1, 0.3, 1) forwards; }
  </style>
</head>

<body class="text-admin-text font-sans min-h-screen flex items-center justify-center">
  
  <!-- Ambient Background -->
  <div class="fixed inset-0 z-0 pointer-events-none">
    <div class="absolute top-[-20%] left-[-10%] w-[60%] h-[60%] bg-admin-primary/10 rounded-full blur-[160px]"></div>
    <div class="absolute bottom-[-20%] right-[-10%] w-[50%] h-[50%] bg-blue-500/5 rounded-full blur-[140px]"></div>
  </div>

  <div class="w-full max-w-[420px] px-8 relative z-10 animate-entry">

    <!-- Header Section -->
    <div class="text-center mb-12">
      <div class="inline-flex items-center justify-center p-5 mb-8 rounded-[2.5rem] bg-gradient-to-b from-admin-primary/20 to-transparent border border-admin-primary/20 shadow-[0_0_40px_rgba(225,29,72,0.15)] group transition-all duration-500 hover:scale-105">
        <i class="bi bi-shield-lock-fill text-5xl text-admin-primary group-hover:drop-shadow-[0_0_10px_rgba(225,29,72,0.5)] transition-all"></i>
      </div>
      <h1 class="text-6xl font-serif text-white tracking-[-0.05em] mb-3 leading-none">WIEVER</h1>
      <div class="flex items-center justify-center gap-3">
        <div class="h-[1px] w-8 bg-admin-primary/30"></div>
        <p class="text-[11px] text-admin-primary font-black tracking-[0.4em] uppercase">Security Terminal</p>
        <div class="h-[1px] w-8 bg-admin-primary/30"></div>
      </div>
    </div>

    <!-- Login Card -->
    <div class="premium-glass rounded-[3.5rem] p-12 relative">
      <div class="space-y-10">
        <div class="text-center">
          <h2 class="text-xs font-black text-white/30 uppercase tracking-[0.4em]">Identity Verification</h2>
        </div>

        <form id="login-form" class="space-y-8">
          <div class="input-container">
            <label class="block text-[10px] font-black text-admin-text-sub uppercase tracking-widest mb-3 ml-4 opacity-50">Administrator ID</label>
            <div class="relative">
              <i class="bi bi-person absolute left-5 top-1/2 -translate-y-1/2 text-admin-text-sub/40 text-lg"></i>
              <input type="text" name="adminId" required placeholder="Enter your ID"
                class="input-field w-full h-16 pl-14 pr-6 rounded-2xl outline-none text-white font-semibold transition-all">
            </div>
          </div>

          <div class="input-container">
            <label class="block text-[10px] font-black text-admin-text-sub uppercase tracking-widest mb-3 ml-4 opacity-50">Security Key</label>
            <div class="relative">
              <i class="bi bi-key absolute left-5 top-1/2 -translate-y-1/2 text-admin-text-sub/40 text-lg"></i>
              <input type="password" name="adminPw" required placeholder="••••••••"
                class="input-field w-full h-16 pl-14 pr-6 rounded-2xl outline-none text-white font-semibold transition-all">
            </div>
          </div>

          <div class="pt-4">
            <button type="submit" class="btn-shine w-full h-16 bg-admin-primary hover:bg-rose-700 text-white font-black rounded-2xl shadow-2xl shadow-rose-900/40 transition-all active:scale-[0.98] flex items-center justify-center gap-3 group tracking-[0.15em] text-xs uppercase">
              <span>Initialize Authorization</span>
              <i class="bi bi-arrow-right-short text-2xl transition-transform group-hover:translate-x-1"></i>
            </button>
          </div>
        </form>
      </div>
    </div>

    <!-- Footer Meta -->
    <div class="mt-12 text-center">
      <a href="${baseURL}/" class="inline-flex items-center gap-2 text-[10px] font-black text-white/20 hover:text-admin-primary transition-colors uppercase tracking-[0.3em] group">
        <i class="bi bi-arrow-left transition-transform group-hover:-translate-x-1"></i>
        Return to Front Stage
      </a>
      <div class="mt-10 flex flex-col items-center gap-2">
        <div class="w-1 h-1 rounded-full bg-white/10"></div>
        <p class="text-[9px] text-white/10 font-bold uppercase tracking-[0.4em]">
          &copy; <%= java.util.Calendar.getInstance().get(java.util.Calendar.YEAR) %> WIEVER SYSTEMS CORE
        </p>
      </div>
    </div>
  </div>

  <script>
    const loginForm = document.querySelector("#login-form");
    loginForm.addEventListener("submit", function(event) {
      event.preventDefault();
      const formData = new FormData(loginForm);
      const submitBtn = loginForm.querySelector('button[type="submit"]');
      
      submitBtn.disabled = true;
      submitBtn.innerHTML = '<i class="bi bi-arrow-repeat animate-spin text-2xl"></i>';

      axios.post("/ad/loginTest", formData)
        .then(response => {
          if (response.status === 200) {
            window.location.href = "${baseURL}/admin/main";
          }
        })
        .catch((error) => {
          alert(error.response?.data || "인증 실패: 데이터베이스 연결을 확인하십시오.");
          submitBtn.disabled = false;
          submitBtn.innerHTML = '<span>Initialize Authorization</span><i class="bi bi-arrow-right-short text-2xl"></i>';
        });
    });
  </script>
</body>
</html>
