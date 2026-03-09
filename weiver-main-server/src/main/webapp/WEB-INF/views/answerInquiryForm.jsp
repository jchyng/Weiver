<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="config.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>WIEVER Admin - 문의 답변</title>

  <script src="https://cdn.tailwindcss.com"></script>
  <script>
    tailwind.config = {
      theme: {
        extend: {
          colors: {
              'stage-gold-glow': '#FFD700',
            'stage-primary': '#BE123C', 'stage-secondary': '#D4AF37',
            'stage-bg': '#0a0a0a', 'stage-surface': '#1a1a1a',
            'stage-text': '#F8FAFC', 'stage-text-sub': '#a1a1aa',
          },
          fontFamily: { sans: ['Pretendard', 'sans-serif'] },
        }
      }
    }
  </script>
  <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.8/dist/web/static/pretendard.css" />
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

  <style>
    body { display: flex; min-height: 100vh; }
    #sidebar { width: 240px; min-height: 100vh; flex-shrink: 0; }
    #main-content { flex: 1; min-height: 100vh; }
    .nav-link-item { display: flex; align-items: center; gap: 10px; padding: 10px 16px; border-radius: 10px; font-size: 14px; font-weight: 600; color: #94A3B8; transition: all 0.15s; margin: 2px 8px; }
    .nav-link-item:hover { background: rgba(255,255,255,0.06); color: #F8FAFC; border-left: 3px solid rgba(212,175,55,0.3); }
    .nav-link-item.active { background: rgba(190,18,60,0.15); color: #BE123C; border-left: 3px solid #D4AF37; }
  </style>
</head>

<body class="bg-stage-bg text-stage-text font-sans" style="background: linear-gradient(180deg, #0f0f0f 0%, #000000 100%); min-height: 100vh;">

  <aside id="sidebar" class="bg-stage-surface border-r border-white/10 flex flex-col">
    <div class="px-6 py-6 border-b border-stage-secondary/30">
      <h1 class="text-2xl font-serif text-stage-primary tracking-tighter">WIEVER</h1>
      <p class="text-[10px] text-stage-text-sub font-bold tracking-widest uppercase mt-0.5">Admin Dashboard</p>
    </div>
    <nav class="flex-1 py-4 overflow-y-auto">
      <p class="text-[10px] text-stage-text-sub font-bold uppercase tracking-widest px-6 mb-3 mt-2">데이터 관리</p>
      <a href="${baseURL}/admin/getAllActors" class="nav-link-item"><i class="bi bi-person-video3"></i> 배우</a>
      <a href="${baseURL}/admin/getAllMusicals" class="nav-link-item"><i class="bi bi-music-note-beamed"></i> 뮤지컬</a>
      <a href="${baseURL}/admin/getAllUsers" class="nav-link-item"><i class="bi bi-people"></i> 유저</a>
      <a href="${baseURL}/admin/getAllAdmins" class="nav-link-item"><i class="bi bi-shield-check"></i> 관리자</a>
      <a href="${baseURL}/admin/getAllPosts" class="nav-link-item"><i class="bi bi-journals"></i> 게시글</a>
      <a href="${baseURL}/admin/getAllInquirys" class="nav-link-item active"><i class="bi bi-question-circle"></i> 문의</a>
      <a href="${baseURL}/admin/crawling" class="nav-link-item"><i class="bi bi-arrow-repeat"></i> 크롤링 상태</a>
    </nav>
    <div class="px-4 py-4 border-t border-stage-secondary/20">
      <div class="flex items-center gap-3 p-3 rounded-xl bg-black/60">
        <div class="w-8 h-8 rounded-full bg-stage-primary/20 flex items-center justify-center border border-stage-primary/30 flex-shrink-0">
          <i class="bi bi-person-fill text-stage-primary text-sm"></i>
        </div>
        <div class="overflow-hidden">
          <p class="text-[10px] text-stage-text-sub font-bold uppercase leading-none mb-0.5">Logged in</p>
          <p class="text-sm font-bold truncate">${sessionScope.adminId}</p>
        </div>
      </div>
      <a href="${baseURL}/admin/logout" class="flex items-center gap-2 mt-3 px-3 py-2 rounded-xl text-stage-text-sub hover:text-rose-400 hover:bg-rose-900/10 transition-all text-sm font-bold">
        <i class="bi bi-box-arrow-right"></i> 로그아웃
      </a>
    </div>
  </aside>

  <div id="main-content" class="flex flex-col">
    <header class="h-16 bg-stage-surface/50 border-b border-stage-secondary/20 flex items-center justify-between px-6 flex-shrink-0">
      <div class="flex items-center gap-3">
        <a href="${baseURL}/admin/getAllInquirys" class="text-stage-text-sub hover:text-stage-secondary transition-colors text-xl mr-1">
          <i class="bi bi-chevron-left"></i>
        </a>
        <i class="bi bi-reply text-stage-secondary text-xl"></i>
        <div>
          <h2 class="text-lg font-bold leading-none">문의 답변</h2>
          <p class="text-[11px] text-stage-text-sub mt-0.5">Answer Inquiry</p>
        </div>
      </div>
      <span class="text-sm text-stage-text-sub font-bold">안녕하세요, <span class="text-stage-text">${sessionScope.adminName}</span>님</span>
    </header>

    <main class="flex-1 p-6">
      <div class="max-w-2xl space-y-5">

        <!-- Inquiry Info -->
        <div class="bg-stage-surface/40 border border-white/10 rounded-2xl overflow-hidden">
          <div class="p-4 border-b border-white/10 flex items-center gap-2">
            <i class="bi bi-chat-left-text text-stage-text-sub"></i>
            <span class="text-xs font-bold text-stage-text-sub uppercase tracking-widest">문의 내용</span>
          </div>
          <div class="p-5 space-y-4">
            <div class="grid grid-cols-3 gap-4">
              <div class="space-y-1">
                <p class="text-[10px] text-stage-text-sub font-bold uppercase tracking-widest">문의 제목</p>
                <p class="font-bold text-sm">${inquiry.title}</p>
              </div>
              <div class="space-y-1">
                <p class="text-[10px] text-stage-text-sub font-bold uppercase tracking-widest">작성자</p>
                <p class="text-sm text-stage-text-sub">${inquiry.userId}</p>
              </div>
              <div class="space-y-1">
                <p class="text-[10px] text-stage-text-sub font-bold uppercase tracking-widest">문의 시각</p>
                <p class="text-sm text-stage-text-sub">${inquiry.createdTime}</p>
              </div>
            </div>
            <div class="space-y-2">
              <p class="text-[10px] text-stage-text-sub font-bold uppercase tracking-widest">문의 내용</p>
              <div class="bg-black/60 border border-white/20 rounded-xl p-4 text-sm text-stage-text-sub leading-relaxed whitespace-pre-wrap">${inquiry.content}</div>
            </div>
          </div>
        </div>

        <!-- Answer Form -->
        <form action="${baseURL}/answerInquiry" method="POST" class="bg-stage-surface/40 border border-stage-secondary/20 rounded-2xl overflow-hidden">
          <input type="hidden" name="id" value="${inquiry.id}">
          <div class="p-4 border-b border-stage-secondary/10 flex items-center gap-2 bg-stage-secondary/5">
            <i class="bi bi-shield-check text-stage-secondary"></i>
            <span class="text-xs font-bold text-stage-secondary uppercase tracking-widest">관리자 답변 작성</span>
          </div>
          <div class="p-5 space-y-4">
            <div class="space-y-2">
              <label class="text-[10px] text-stage-text-sub font-bold uppercase tracking-widest">답변 내용</label>
              <textarea name="answerContent" rows="8" placeholder="문의에 대한 답변을 입력하세요..." required
                class="w-full bg-black/60 border border-white/20 rounded-xl py-4 px-4 focus:outline-none focus:border-stage-secondary transition-all resize-none leading-relaxed text-sm placeholder-stage-text-sub/40"></textarea>
            </div>
            <button type="submit" class="w-full bg-stage-secondary hover:bg-amber-400 text-black font-bold py-3.5 rounded-xl transition-all transform active:scale-[0.98] shadow-lg shadow-amber-900/20">
              <i class="bi bi-send mr-2"></i>답변 등록하기
            </button>
          </div>
        </form>

      </div>
    </main>

    <footer class="py-4 px-6 text-center text-[10px] text-stage-text-sub font-bold uppercase tracking-[0.15em] border-t border-stage-secondary/20">
      &copy; Weiver 2023. Admin Panel.
    </footer>
  </div>

</body>
</html>
