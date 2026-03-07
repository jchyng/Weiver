<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="config.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>WIEVER Admin - 배우</title>

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
          fontFamily: { sans: ['Pretendard', 'sans-serif'] },
        }
      }
    }
  </script>
  <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.8/dist/web/static/pretendard.css" />
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
  <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet">

  <style>
    body { display: flex; min-height: 100vh; }
    #sidebar { width: 240px; min-height: 100vh; flex-shrink: 0; }
    #main-content { flex: 1; min-height: 100vh; overflow-x: auto; }
    .nav-link-item { display: flex; align-items: center; gap: 10px; padding: 10px 16px; border-radius: 10px; font-size: 14px; font-weight: 600; color: #94A3B8; transition: all 0.15s; margin: 2px 8px; }
    .nav-link-item:hover { background: rgba(255,255,255,0.06); color: #F8FAFC; border-left: 3px solid rgba(212,175,55,0.3); }
    .nav-link-item.active { background: rgba(190,18,60,0.15); color: #BE123C; border-left: 3px solid #D4AF37; }
    .dataTable-wrapper { color: #F8FAFC; }
    .dataTable-wrapper .dataTable-search input,
    .dataTable-wrapper .dataTable-selector { background: #1E293B; border: 1px solid #334155; color: #F8FAFC; border-radius: 8px; padding: 6px 12px; }
    .dataTable-table { width: 100%; border-collapse: collapse; }
    .dataTable-table th { background: #1E293B; color: #94A3B8; font-size: 11px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.08em; padding: 12px 16px; border-bottom: 1px solid #334155; }
    .dataTable-table td { padding: 12px 16px; border-bottom: 1px solid rgba(51,65,85,0.5); font-size: 14px; vertical-align: middle; }
    .dataTable-table tr:hover td { background: rgba(255,255,255,0.03); }
    .dataTable-pagination-list li a { color: #94A3B8; border-radius: 6px; }
    .dataTable-pagination-list .active a { background: #BE123C; color: #fff; }
  </style>
</head>

<body class="bg-stage-bg text-stage-text font-sans" style="background: linear-gradient(180deg, #0f0f0f 0%, #000000 100%); min-height: 100vh;">

  <!-- Sidebar -->
  <aside id="sidebar" class="bg-stage-surface border-r border-white/10 flex flex-col">
    <div class="px-6 py-6 border-b border-stage-secondary/30">
      <h1 class="text-2xl font-serif text-stage-primary tracking-tighter">WIEVER</h1>
      <p class="text-[10px] text-stage-text-sub font-bold tracking-widest uppercase mt-0.5">Admin Dashboard</p>
    </div>
    <nav class="flex-1 py-4 overflow-y-auto">
      <p class="text-[10px] text-stage-text-sub font-bold uppercase tracking-widest px-6 mb-3 mt-2">데이터 관리</p>
      <a href="${baseURL}/admin/getAllActors" class="nav-link-item active"><i class="bi bi-person-video3"></i> 배우</a>
      <a href="${baseURL}/admin/getAllMusicals" class="nav-link-item"><i class="bi bi-music-note-beamed"></i> 뮤지컬</a>
      <a href="${baseURL}/admin/getAllUsers" class="nav-link-item"><i class="bi bi-people"></i> 유저</a>
      <a href="${baseURL}/admin/getAllAdmins" class="nav-link-item"><i class="bi bi-shield-check"></i> 관리자</a>
      <a href="${baseURL}/admin/getAllPosts" class="nav-link-item"><i class="bi bi-journals"></i> 게시글</a>
      <a href="${baseURL}/admin/getAllInquirys" class="nav-link-item"><i class="bi bi-question-circle"></i> 문의</a>
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

  <!-- Main -->
  <div id="main-content" class="flex flex-col">
    <header class="h-16 bg-stage-surface/50 border-b border-stage-secondary/20 flex items-center justify-between px-6 flex-shrink-0">
      <div class="flex items-center gap-3">
        <i class="bi bi-person-video3 text-stage-secondary text-xl"></i>
        <div>
          <h2 class="text-lg font-bold leading-none">배우 목록</h2>
          <p class="text-[11px] text-stage-text-sub mt-0.5">Actor Management</p>
        </div>
      </div>
      <span class="text-sm text-stage-text-sub font-bold">안녕하세요, <span class="text-stage-text">${sessionScope.adminName}</span>님</span>
    </header>

    <main class="flex-1 p-6">
      <div class="bg-stage-surface/40 border border-white/10 rounded-2xl overflow-hidden">
        <div class="p-5 border-b border-white/10">
          <span class="text-xs font-bold text-stage-text-sub uppercase tracking-widest">Total Actors</span>
        </div>
        <div class="p-5 overflow-x-auto">
          <table id="datatablesSimple">
            <thead>
              <tr>
                <th>프로필</th>
                <th>ID</th>
                <th>이름</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="actor" items="${actors}">
                <tr>
                  <td>
                    <a href="${baseURL}/actorDetail/${actor.id}">
                      <img src="${actor.profileImage}" class="rounded-full object-cover border-2 border-white/20" height="64" width="64" alt="${actor.name}">
                    </a>
                  </td>
                  <td class="text-stage-text-sub text-xs">${actor.id}</td>
                  <td class="font-bold">${actor.name}</td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
      </div>
    </main>

    <footer class="py-4 px-6 text-center text-[10px] text-stage-text-sub font-bold uppercase tracking-[0.15em] border-t border-stage-secondary/20">
      &copy; Weiver 2023. Admin Panel.
    </footer>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"></script>
  <script>
    const dataTable = new simpleDatatables.DataTable("#datatablesSimple", { searchable: true, fixedHeight: false });
  </script>
</body>
</html>
