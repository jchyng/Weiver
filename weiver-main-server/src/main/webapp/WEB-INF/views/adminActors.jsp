<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageName" value="actors" scope="request"/>
<c:set var="title" value="Talent Pool" scope="request"/>

<!DOCTYPE html>
<html lang="ko">
<head>
<<<<<<< Updated upstream
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

  <%@ include file="adminStyles.jsp" %>
=======
  <title>WIEVER Admin - Actor Management</title>
  <%@ include file="admin/layout/head.jsp" %>
>>>>>>> Stashed changes
</head>

<body class="flex min-h-screen bg-admin-bg font-sans">
  <%@ include file="admin/layout/sidebar.jsp" %>

  <div class="flex-1 flex flex-col min-w-0">
    <%@ include file="admin/layout/topbar.jsp" %>

    <main class="flex-1 p-8 overflow-y-auto animate-slide-in">
      
      <div class="flex flex-col md:flex-row md:items-end justify-between gap-6 mb-10">
        <div>
          <h3 class="text-3xl font-bold text-white tracking-tight">배우 관리</h3>
          <p class="text-admin-text-sub mt-2 max-w-md">플랫폼에 등록된 아티스트 정보를 모니터링하고 프로필 상태를 관리합니다.</p>
        </div>
        <div class="flex gap-3">
          <div class="px-5 py-3 glass-effect rounded-2xl border border-admin-border flex items-center gap-4">
            <div class="text-right">
              <p class="text-[10px] text-admin-text-sub font-black uppercase tracking-widest">Total Artists</p>
              <p class="text-xl font-black text-white leading-none mt-1">${actors.size()}</p>
            </div>
            <div class="w-10 h-10 bg-admin-primary/10 rounded-xl flex items-center justify-center border border-admin-primary/20">
              <i class="bi bi-person-lines-fill text-admin-primary text-xl"></i>
            </div>
          </div>
        </div>
      </div>

      <div class="glass-effect rounded-[2rem] border border-admin-border shadow-premium overflow-hidden">
        <div class="p-8 border-b border-admin-border bg-white/[0.02] flex items-center justify-between">
          <h4 class="text-sm font-bold uppercase tracking-widest text-admin-text-sub flex items-center gap-2">
            <i class="bi bi-grid-3x3-gap-fill text-admin-primary"></i>
            Artist Registry
          </h4>
        </div>

        <div class="p-6">
          <table id="datatablesSimple" class="premium-table w-full">
            <thead>
              <tr>
                <th class="w-20">Portrait</th>
                <th>Database ID</th>
                <th>Artist Name</th>
                <th class="text-center">Action</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="actor" items="${actors}">
                <tr class="group hover:bg-white/[0.02] transition-colors">
                  <td>
                    <div class="relative w-14 h-14">
                      <img src="${actor.profileImage}" 
                           class="w-full h-full rounded-2xl object-cover border border-white/5 shadow-lg group-hover:border-admin-primary/40 transition-all duration-300" 
                           alt="${actor.name}" 
                           onerror="this.src='/img/Default_Profile.png'">
                      <div class="absolute inset-0 rounded-2xl bg-gradient-to-t from-black/40 to-transparent opacity-0 group-hover:opacity-100 transition-opacity"></div>
                    </div>
                  </td>
                  <td>
                    <div class="flex flex-col">
                      <span class="text-white font-black text-xs tracking-widest uppercase">${actor.id}</span>
                      <span class="text-[9px] text-admin-text-sub font-bold mt-1">ENTITY_UID</span>
                    </div>
                  </td>
                  <td>
                    <span class="text-base font-bold text-white/90 group-hover:text-admin-primary transition-colors">${actor.name}</span>
                  </td>
                  <td>
                    <div class="flex items-center justify-center gap-2">
                      <a href="${baseURL}/admin/getActorDetail/${actor.id}" class="px-4 py-2 bg-white/5 border border-white/10 rounded-xl text-[10px] font-black uppercase tracking-widest hover:bg-white/10 text-admin-text-sub hover:text-white transition-all flex items-center gap-2">
                        <i class="bi bi-pencil-square"></i>
                        Edit Profile
                      </a>
                      <a href="${baseURL}/actor-detail/${actor.id}" target="_blank" class="w-10 h-10 flex items-center justify-center bg-white/5 border border-white/10 rounded-xl hover:bg-white/10 text-admin-text-sub hover:text-white transition-all">
                        <i class="bi bi-eye-fill text-xs"></i>
                      </a>
                      <button onclick="deleteActor('${actor.id}')" class="w-10 h-10 flex items-center justify-center bg-rose-500/10 border border-rose-500/20 rounded-xl hover:bg-rose-500 text-rose-500 hover:text-white transition-all shadow-sm">
                        <i class="bi bi-trash3-fill text-xs"></i>
                      </button>
                    </div>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
      </div>
    </main>

    <%@ include file="admin/layout/footer.jsp" %>
  </div>

  <script>
<<<<<<< Updated upstream
    const dataTable = new simpleDatatables.DataTable("#datatablesSimple", {
      searchable: true, fixedHeight: false,
      labels: { placeholder: "검색...", perPage: "개씩 보기", noRows: "데이터가 없습니다", info: "{start}~{end} / 총 {rows}건" }
    });
=======
    window.addEventListener('DOMContentLoaded', event => {
      new simpleDatatables.DataTable("#datatablesSimple", {
        searchable: true,
        perPage: 10,
        labels: {
          placeholder: "Search artist...",
          perPage: "표시 개수",
          noRows: "No artists found",
          info: "Showing {start} to {end} of {rows}",
        }
      });
    });

    function deleteActor(id) {
      if(!confirm("Warning: 배우 데이터를 삭제하시겠습니까? 관련 캐스팅 정보에 영향을 줄 수 있습니다.")) return;
      axios.get('${baseURL}/admin/deleteActor/' + id)
        .then(() => {
          alert('삭제되었습니다.');
          location.reload();
        })
        .catch(err => alert('오류가 발생했습니다.'));
    }
>>>>>>> Stashed changes
  </script>
</body>
</html>
