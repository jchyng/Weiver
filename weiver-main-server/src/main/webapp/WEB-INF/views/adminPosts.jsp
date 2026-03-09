<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="config.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>WIEVER Admin - 게시글</title>

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
  <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

  <%@ include file="adminStyles.jsp" %>
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
      <a href="${baseURL}/admin/getAllPosts" class="nav-link-item active"><i class="bi bi-journals"></i> 게시글</a>
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

  <div id="main-content" class="flex flex-col">
    <header class="h-16 bg-stage-surface/50 border-b border-stage-secondary/20 flex items-center justify-between px-6 flex-shrink-0">
      <div class="flex items-center gap-3">
        <i class="bi bi-journals text-stage-secondary text-xl"></i>
        <div>
          <h2 class="text-lg font-bold leading-none">게시글 목록</h2>
          <p class="text-[11px] text-stage-text-sub mt-0.5">Post Management</p>
        </div>
      </div>
      <span class="text-sm text-stage-text-sub font-bold">안녕하세요, <span class="text-stage-text">${sessionScope.adminName}</span>님</span>
    </header>

    <main class="flex-1 p-6">
      <div class="bg-stage-surface/40 border border-white/10 rounded-2xl overflow-hidden">
        <div class="p-5 border-b border-white/10">
          <span class="text-xs font-bold text-stage-text-sub uppercase tracking-widest">Total Posts</span>
        </div>
        <div class="p-5 overflow-x-auto">
          <table id="datatablesSimple">
            <thead>
              <tr>
                <th>ID</th>
                <th>제목</th>
                <th>타입</th>
                <th>작성자</th>
                <th>작성 일자</th>
                <th>삭제</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="post" items="${posts}">
                <tr>
                  <td class="text-stage-text-sub text-xs">${post.id}</td>
                  <td class="font-bold max-w-xs truncate">${post.title}</td>
                  <td>
                    <c:choose>
                      <c:when test="${post.type == 'Review'}"><span class="badge-review">리뷰</span></c:when>
                      <c:otherwise><span class="badge-chat">잡담</span></c:otherwise>
                    </c:choose>
                  </td>
                  <td class="text-stage-text-sub text-sm">${post.user.id}</td>
                  <td class="text-stage-text-sub text-xs whitespace-nowrap">${post.createdTime}</td>
                  <td><button class="btn-delete" onclick="deletePost(${post.id})"><i class="bi bi-trash3 mr-1"></i>삭제</button></td>
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
    const dataTable = new simpleDatatables.DataTable("#datatablesSimple", {
      searchable: true, fixedHeight: false,
      labels: { placeholder: "검색...", perPage: "개씩 보기", noRows: "데이터가 없습니다", info: "{start}~{end} / 총 {rows}건" }
    });
    function deletePost(postId) {
      if (!confirm("게시글 #" + postId + "을 삭제하시겠습니까?")) return;
      $.ajax({ type: 'GET', url: '/admin/deletePost/' + postId, contentType: 'application/json' });
      setTimeout(() => location.href = "${baseURL}/admin/getAllPosts", 100);
    }
  </script>
</body>
</html>
