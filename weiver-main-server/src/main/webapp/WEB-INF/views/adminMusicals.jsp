<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageName" value="musicals" scope="request"/>
<c:set var="title" value="Musicals" scope="request"/>

<!DOCTYPE html>
<html lang="ko">
<head>
  <title>WIEVER Admin - Musical Data</title>
  <%@ include file="admin/layout/head.jsp" %>
</head>

<body class="flex min-h-screen bg-admin-bg font-sans">
  <%@ include file="admin/layout/sidebar.jsp" %>

  <div class="flex-1 flex flex-col min-w-0">
    <%@ include file="admin/layout/topbar.jsp" %>

    <main class="flex-1 p-8 overflow-y-auto animate-slide-in">
      
      <div class="flex flex-col md:flex-row md:items-end justify-between gap-6 mb-10">
        <div>
          <h3 class="text-3xl font-bold text-white tracking-tight">뮤지컬 데이터</h3>
          <p class="text-admin-text-sub mt-2 max-w-md">공연 정보, 출연진, 상영 일정 등 플랫폼의 핵심 데이터를 관리합니다.</p>
        </div>
        <div class="flex gap-3">
          <div class="px-5 py-3 glass-effect rounded-2xl border border-admin-border flex items-center gap-4">
            <div class="text-right">
              <p class="text-[10px] text-admin-text-sub font-black uppercase tracking-widest">Database Items</p>
              <p class="text-xl font-black text-white leading-none mt-1">${musicals.size()}</p>
            </div>
            <div class="w-10 h-10 bg-admin-primary/10 rounded-xl flex items-center justify-center border border-admin-primary/20">
              <i class="bi bi-music-note-beamed text-admin-primary text-xl"></i>
            </div>
          </div>
        </div>
      </div>

      <div class="glass-effect rounded-[2rem] border border-admin-border shadow-premium overflow-hidden">
        <div class="p-8 border-b border-admin-border bg-white/[0.02] flex items-center justify-between">
          <h4 class="text-sm font-bold uppercase tracking-widest text-admin-text-sub flex items-center gap-2">
            <i class="bi bi-collection-play-fill text-admin-primary"></i>
            Production Index
          </h4>
        </div>

        <div class="p-6">
          <table id="datatablesSimple" class="premium-table w-full">
            <thead>
              <tr>
                <th class="w-24">Key Visual</th>
                <th>Title & Info</th>
                <th>Venue & Dates</th>
                <th class="text-center">Action</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="musical" items="${musicals}">
                <tr class="group hover:bg-white/[0.02] transition-colors">
                  <td>
                    <div class="relative w-16 h-20 rounded-xl overflow-hidden border border-white/5 shadow-2xl group-hover:border-admin-primary/40 transition-all duration-300">
                      <img src="${musical.posterImage}" class="w-full h-full object-cover" alt="${musical.title}">
                    </div>
                  </td>
                  <td>
                    <div class="flex flex-col">
                      <span class="text-base font-bold text-white group-hover:text-admin-primary transition-colors">${musical.title}</span>
                      <div class="flex items-center gap-2 mt-1.5">
                        <span class="text-[9px] font-black uppercase tracking-widest text-admin-text-sub px-1.5 py-0.5 bg-white/5 border border-white/5 rounded-md">ID: ${musical.id}</span>
                      </div>
                    </div>
                  </td>
                  <td>
                    <div class="flex flex-col gap-1">
                      <div class="flex items-center gap-2 text-admin-text-sub text-xs">
                        <i class="bi bi-geo-alt-fill text-[10px]"></i>
                        <span>${musical.theater}</span>
                      </div>
                      <div class="flex items-center gap-2 text-white/40 text-[10px] font-bold">
                        <i class="bi bi-calendar-event"></i>
                        <span>${musical.stDate} ~ ${musical.edDate}</span>
                      </div>
                    </div>
                  </td>
                  <td>
                    <div class="flex items-center justify-center gap-2">
                      <a href="${baseURL}/musical-detail/${musical.id}" target="_blank" class="w-9 h-9 flex items-center justify-center bg-white/5 border border-white/10 rounded-xl hover:bg-white/10 text-admin-text-sub hover:text-white transition-all shadow-sm">
                        <i class="bi bi-box-arrow-up-right text-xs"></i>
                      </a>
                      <button onclick="deleteMusical('${musical.id}')" class="w-9 h-9 flex items-center justify-center bg-rose-500/10 border border-rose-500/20 rounded-xl hover:bg-rose-500 text-rose-500 hover:text-white transition-all shadow-sm">
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
    window.addEventListener('DOMContentLoaded', event => {
      new simpleDatatables.DataTable("#datatablesSimple", {
        searchable: true,
        perPage: 10,
        labels: {
          placeholder: "Search production...",
          perPage: "표시 개수",
          noRows: "No musicals found",
          info: "Showing {start} to {end} of {rows}",
        }
      });
    });

    function deleteMusical(id) {
      if(!confirm("CRITICAL: 해당 뮤지컬과 관련된 모든 캐스팅/리뷰 데이터가 함께 삭제될 수 있습니다. 계속하시겠습니까?")) return;
      axios.get('${baseURL}/admin/deleteMusical/' + id)
        .then(() => {
          alert('데이터가 성공적으로 제거되었습니다.');
          location.reload();
        })
        .catch(err => alert('삭제 요청 중 오류가 발생했습니다.'));
    }
  </script>
</body>
</html>
