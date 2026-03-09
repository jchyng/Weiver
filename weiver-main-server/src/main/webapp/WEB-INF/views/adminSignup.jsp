<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="config.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
  <title>WIEVER Admin - Issue New Credentials</title>

  <script src="https://cdn.tailwindcss.com"></script>
  <script>
    tailwind.config = {
      theme: {
        extend: {
          colors: {
            'admin-bg': '#020617',
            'admin-surface': '#0F172A',
            'admin-primary': '#E11D48',
            'admin-text': '#F8FAFC',
            'admin-text-sub': '#94A3B8',
          },
          fontFamily: {
            sans: ['Pretendard', 'sans-serif'],
            serif: ['Cinzel', 'serif'],
          },
        }
      }
    }
  </script>
  <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.8/dist/web/static/pretendard.css" />
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
  <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

  <style>
    body { background-color: #020617; }
    .glass-card {
      background: rgba(15, 23, 42, 0.6);
      backdrop-filter: blur(24px);
      border: 1px solid rgba(226, 232, 240, 0.05);
      box-shadow: 0 40px 100px -20px rgba(0, 0, 0, 0.8);
    }
    .input-field:focus + label,
    .input-field:not(:placeholder-shown) + label {
      transform: translateY(-24px) scale(0.8);
      color: #E11D48;
    }
    @keyframes slideRight {
      from { opacity: 0; transform: translateX(-20px); }
      to { opacity: 1; transform: translateX(0); }
    }
    .animate-slide { animation: slideRight 0.8s cubic-bezier(0.16, 1, 0.3, 1) forwards; }
  </style>
</head>

<body class="text-admin-text font-sans min-h-screen flex items-center justify-center py-20 overflow-x-hidden">
  
  <div class="fixed inset-0 overflow-hidden pointer-events-none opacity-50">
    <div class="absolute top-[20%] right-[10%] w-[40%] h-[40%] bg-blue-600/5 rounded-full blur-[120px]"></div>
    <div class="absolute bottom-[20%] left-[10%] w-[30%] h-[30%] bg-admin-primary/5 rounded-full blur-[100px]"></div>
  </div>

  <div class="w-full max-w-lg px-6 relative z-10 animate-slide">

    <!-- Header -->
    <div class="mb-12">
      <div class="flex items-center gap-4 mb-4">
        <div class="w-1.5 h-8 bg-admin-primary rounded-full shadow-glow"></div>
        <h1 class="text-4xl font-serif text-white tracking-tighter">ISSUE CREDENTIALS</h1>
      </div>
      <p class="text-[11px] text-admin-text-sub font-black tracking-[0.2em] uppercase opacity-60">
        시스템 운영 권한을 가진 새로운 관리자 계정을 생성합니다.
      </p>
    </div>

    <!-- Signup Card -->
    <div class="glass-card rounded-[3rem] p-10 md:p-14 relative overflow-hidden">
      <div class="absolute top-0 right-0 w-24 h-24 bg-admin-primary/5 rounded-bl-[5rem]"></div>
      
      <form id="signup-form" class="space-y-12">
        <div class="relative group">
          <input type="text" name="adminId" required placeholder=" "
            class="input-field w-full bg-transparent border-b border-white/10 py-3 focus:outline-none focus:border-admin-primary transition-all text-white font-bold tracking-wide">
          <label class="absolute left-0 top-3 text-admin-text-sub pointer-events-none transition-all duration-300 origin-left text-[10px] uppercase tracking-widest font-black opacity-50">Desired Administrator ID</label>
        </div>

        <div class="relative group">
          <input type="password" name="adminPw" required placeholder=" "
            class="input-field w-full bg-transparent border-b border-white/10 py-3 focus:outline-none focus:border-admin-primary transition-all text-white font-bold tracking-wide">
          <label class="absolute left-0 top-3 text-admin-text-sub pointer-events-none transition-all duration-300 origin-left text-[10px] uppercase tracking-widest font-black opacity-50">Master Password</label>
        </div>

        <div class="relative group">
          <input type="password" name="adminPwCheck" required placeholder=" "
            class="input-field w-full bg-transparent border-b border-white/10 py-3 focus:outline-none focus:border-admin-primary transition-all text-white font-bold tracking-wide">
          <label class="absolute left-0 top-3 text-admin-text-sub pointer-events-none transition-all duration-300 origin-left text-[10px] uppercase tracking-widest font-black opacity-50">Confirm Credentials</label>
        </div>

        <div class="pt-6 flex flex-col sm:flex-row gap-4">
          <button type="submit" class="flex-1 bg-admin-primary hover:bg-rose-700 text-white font-black py-4 rounded-2xl shadow-2xl shadow-rose-900/40 transition-all transform active:scale-[0.98] flex items-center justify-center gap-3 group tracking-widest text-[10px] uppercase">
            <span>Provision Account</span>
            <i class="bi bi-shield-check transition-transform group-hover:scale-125"></i>
          </button>
          
          <a href="${baseURL}/admin/getAllAdmins" class="px-8 py-4 bg-white/5 hover:bg-white/10 border border-white/10 text-white font-black rounded-2xl transition-all flex items-center justify-center text-[10px] tracking-widest uppercase">
            Cancel
          </a>
        </div>
      </form>
    </div>

    <p class="text-center text-[9px] text-white/10 font-bold uppercase tracking-[0.3em] mt-12">
      Access to this terminal is strictly monitored. Unauthorized attempts will be logged.
    </p>
  </div>

  <script>
    const signupForm = document.querySelector("#signup-form");
    signupForm.addEventListener("submit", function(event) {
      event.preventDefault();
      
      const pw = signupForm.adminPw.value;
      const pwCheck = signupForm.adminPwCheck.value;
      
      if (pw !== pwCheck) {
        alert("패스워드가 일치하지 않습니다.");
        return;
      }

      const formData = new FormData(signupForm);
      const submitBtn = signupForm.querySelector('button[type="submit"]');
      submitBtn.disabled = true;
      submitBtn.innerHTML = '<i class="bi bi-arrow-repeat animate-spin text-xl"></i>';

      axios.post("/ad/signup", formData)
        .then(response => {
          alert('새로운 관리자 계정이 성공적으로 생성되었습니다.');
          window.location.href = "${baseURL}/admin/getAllAdmins";
        })
        .catch((error) => {
          alert(error.response?.data || "계정 생성 중 오류가 발생했습니다.");
          submitBtn.disabled = false;
          submitBtn.innerHTML = '<span>Provision Account</span><i class="bi bi-shield-check"></i>';
        });
    });
  </script>
</body>
</html>
