<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageName" value="admins" scope="request"/>
<c:set var="title" value="Access Control" scope="request"/>

<!DOCTYPE html>
<html lang="ko">
<head>
  <title>WIEVER Admin - System Access</title>
  <%@ include file="admin/layout/head.jsp" %>
</head>

<body class="flex min-h-screen bg-admin-bg font-sans">
  <%@ include file="admin/layout/sidebar.jsp" %>

  <div class="flex-1 flex flex-col min-w-0">
    <%@ include file="admin/layout/topbar.jsp" %>

    <main class="flex-1 p-8 overflow-y-auto animate-slide-in">
      
      <div class="flex flex-col md:flex-row md:items-end justify-between gap-6 mb-10">
        <div>
          <h3 class="text-3xl font-bold text-white tracking-tight">운영진 설정</h3>
          <p class="text-admin-text-sub mt-2 max-w-md">관리자 계정을 생성하고 권한을 부여합니다. 승인되지 않은 접근을 철저히 차단하십시오.</p>
        </div>
        <div class="flex gap-3">
          <div class="px-5 py-3 glass-effect rounded-2xl border border-admin-border flex items-center gap-4">
            <div class="text-right">
              <p class="text-[10px] text-admin-text-sub font-black uppercase tracking-widest">Authorized Staff</p>
              <p class="text-xl font-black text-white leading-none mt-1">${admins.size()}</p>
            </div>
            <div class="w-10 h-10 bg-admin-primary/10 rounded-xl flex items-center justify-center border border-admin-primary/20">
              <i class="bi bi-shield-lock-fill text-admin-primary text-xl"></i>
            </div>
          </div>
          <a href="${baseURL}/admin/signup" class="h-full px-6 bg-admin-primary hover:bg-rose-700 text-white font-bold rounded-2xl transition-all shadow-glow flex items-center gap-2 group">
            <i class="bi bi-person-plus-fill transition-transform group-hover:scale-110"></i>
            <span>Add Admin</span>
          </a>
        </div>
      </div>

      <div class="glass-effect rounded-[2rem] border border-admin-border shadow-premium overflow-hidden">
        <div class="p-8 border-b border-admin-border bg-white/[0.02] flex items-center justify-between">
          <h4 class="text-sm font-bold uppercase tracking-widest text-admin-text-sub flex items-center gap-2">
            <i class="bi bi-key-fill text-admin-primary"></i>
            Privilege Matrix
          </h4>
        </div>

        <div class="p-6">
          <table id="datatablesSimple" class="premium-table w-full">
            <thead>
              <tr>
                <th>Admin Identity</th>
                <th>Role & Scope</th>
                <th class="text-center">Action</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="admin" items="${admins}">
                <tr class="group hover:bg-white/[0.02] transition-colors">
                  <td>
                    <div class="flex items-center gap-4">
                      <div class="w-10 h-10 bg-admin-surface rounded-xl flex items-center justify-center border border-white/5 group-hover:border-admin-primary/40 transition-all">
                        <i class="bi bi-person-badge text-admin-text-sub group-hover:text-admin-primary"></i>
                      </div>
                      <div class="flex flex-col">
                        <span class="text-sm font-bold text-white">${admin.id}</span>
                        <span class="text-[9px] text-admin-text-sub font-black uppercase tracking-widest mt-0.5">Verified Principal</span>
                      </div>
                    </div>
                  </td>
                  <td>
                    <div class="flex items-center gap-3">
                      <span class="px-3 py-1 rounded-lg bg-admin-primary/10 border border-admin-primary/20 text-admin-primary text-[10px] font-black uppercase tracking-widest">Full Access</span>
                      <div class="w-1.5 h-1.5 rounded-full bg-green-500"></div>
                      <span class="text-[10px] text-admin-text-sub font-bold uppercase tracking-widest">Active Status</span>
                    </div>
                  </td>
                  <td>
                    <div class="flex items-center justify-center gap-2">
                      <button class="w-9 h-9 flex items-center justify-center bg-white/5 border border-white/10 rounded-xl hover:bg-white/10 text-admin-text-sub hover:text-white transition-all shadow-sm">
                        <i class="bi bi-gear-fill text-xs"></i>
                      </button>
                      <button onclick="deleteAdmin('${admin.id}')" class="w-9 h-9 flex items-center justify-center bg-rose-500/10 border border-rose-500/20 rounded-xl hover:bg-rose-500 text-rose-500 hover:text-white transition-all shadow-sm">
                        <i class="bi bi-shield-slash-fill text-xs"></i>
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
          placeholder: "Search access...",
          perPage: "표시 개수",
          noRows: "No admin records found",
          info: "Showing {start} to {end} of {rows}",
        }
      });
    });

    function deleteAdmin(id) {
      if(!confirm("DANGER: " + id + " 관리자의 모든 권한을 회수하시겠습니까?")) return;
      axios.get('${baseURL}/admin/deleteAdmin/' + id)
        .then(() => {
          alert('권한이 회수되었습니다.');
          location.reload();
        })
        .catch(err => alert('처리 실패: ' + err.message));
    }
  </script>
</body>
</html>
