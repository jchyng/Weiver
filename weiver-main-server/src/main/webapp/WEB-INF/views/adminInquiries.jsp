<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageName" value="inquiries" scope="request"/>
<c:set var="title" value="Support Desk" scope="request"/>

<!DOCTYPE html>
<html lang="ko">
<head>
<<<<<<< Updated upstream
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>WIEVER Admin - 문의</title>

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
=======
  <title>WIEVER Admin - Inquiry Management</title>
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
          <h3 class="text-3xl font-bold text-white tracking-tight">고객 문의</h3>
          <p class="text-admin-text-sub mt-2 max-w-md">사용자의 질의사항을 확인하고 답변을 등록합니다. 신속한 답변은 서비스 신뢰도의 핵심입니다.</p>
        </div>
        <div class="flex gap-3">
          <div class="px-5 py-3 glass-effect rounded-2xl border border-admin-border flex items-center gap-4">
            <div class="text-right">
              <p class="text-[10px] text-admin-text-sub font-black uppercase tracking-widest">Open Tickets</p>
              <p class="text-xl font-black text-white leading-none mt-1">${inquiries.size()}</p>
            </div>
            <div class="w-10 h-10 bg-admin-primary/10 rounded-xl flex items-center justify-center border border-admin-primary/20">
              <i class="bi bi-headset text-admin-primary text-xl"></i>
            </div>
          </div>
        </div>
      </div>

      <div class="glass-effect rounded-[2rem] border border-admin-border shadow-premium overflow-hidden">
        <div class="p-8 border-b border-admin-border bg-white/[0.02] flex items-center justify-between">
          <h4 class="text-sm font-bold uppercase tracking-widest text-admin-text-sub flex items-center gap-2">
            <i class="bi bi-ticket-perforated-fill text-admin-primary"></i>
            Active Inquiry Tickets
          </h4>
        </div>

        <div class="p-6">
          <table id="datatablesSimple" class="premium-table w-full">
            <thead>
              <tr>
                <th class="w-32">Ticket ID</th>
                <th>Requester</th>
                <th>Subject Preview</th>
                <th class="text-center">Action</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="inquiry" items="${inquiries}">
                <tr class="group hover:bg-white/[0.02] transition-colors">
                  <td>
                    <span class="text-[10px] font-black text-admin-text-sub px-2 py-1 bg-white/5 border border-white/5 rounded-md uppercase tracking-widest">TK-${inquiry.id}</span>
                  </td>
                  <td>
                    <div class="flex items-center gap-3">
                      <div class="w-8 h-8 rounded-full bg-gradient-to-br from-admin-card to-admin-surface border border-white/5 flex items-center justify-center text-[10px] font-bold text-white">
                        ${fn:substring(inquiry.userId, 0, 1)}
                      </div>
                      <span class="text-xs font-bold text-white/90">${inquiry.userId}</span>
                    </div>
                  </td>
                  <td>
                    <div class="flex flex-col">
                      <span class="text-sm font-bold text-white group-hover:text-admin-primary transition-colors truncate">${inquiry.title}</span>
                      <span class="text-[10px] text-admin-text-sub mt-1 font-medium">${inquiry.createdTime}</span>
                    </div>
                  </td>
                  <td>
                    <div class="flex items-center justify-center gap-2">
                      <a href="${baseURL}/admin/getInquiryDetail/${inquiry.id}" class="px-4 py-2 bg-admin-primary hover:bg-rose-700 text-white text-[10px] font-black uppercase tracking-widest rounded-xl transition-all shadow-sm shadow-rose-900/20 flex items-center gap-2">
                        <i class="bi bi-chat-dots-fill"></i>
                        Resolve
                      </a>
                      <button onclick="deleteInquiry('${inquiry.id}')" class="w-10 h-10 flex items-center justify-center bg-white/5 border border-white/10 rounded-xl hover:bg-rose-500 hover:text-white text-admin-text-sub transition-all">
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
    function deleteInquiry(inquiryId) {
      if (!confirm("문의 #" + inquiryId + "을 삭제하시겠습니까?")) return;
      $.ajax({ type: 'GET', url: '${baseURL}/admin/deleteInquiry/' + inquiryId, contentType: 'application/json' });
      setTimeout(() => location.href = "${baseURL}/admin/getAllInquirys", 100);
=======
    window.addEventListener('DOMContentLoaded', event => {
      new simpleDatatables.DataTable("#datatablesSimple", {
        searchable: true,
        perPage: 10,
        labels: {
          placeholder: "Search tickets...",
          perPage: "표시 개수",
          noRows: "All tickets are cleared",
          info: "Showing {start} to {end} of {rows}",
        }
      });
    });

    function deleteInquiry(id) {
      if(!confirm("CONFIRMATION: 이 문의 내역을 삭제하시겠습니까?")) return;
      axios.get('${baseURL}/admin/deleteInquiry/' + id)
        .then(() => {
          alert('내역이 성공적으로 제거되었습니다.');
          location.reload();
        })
        .catch(err => alert('오류 발생: ' + err.message));
>>>>>>> Stashed changes
    }
  </script>
</body>
</html>
