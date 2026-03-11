<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageName" value="users" scope="request"/>
<c:set var="title" value="User Base" scope="request"/>

<!DOCTYPE html>
<html lang="ko">
<head>
  <title>WIEVER Admin - User Management</title>
  <%@ include file="admin/layout/head.jsp" %>
</head>

<body class="flex min-h-screen bg-admin-bg font-sans">

  <!-- Sidebar Component -->
  <%@ include file="admin/layout/sidebar.jsp" %>

  <!-- Main Content Layout -->
  <div class="flex-1 flex flex-col min-w-0">
    
    <!-- Top Header -->
    <%@ include file="admin/layout/topbar.jsp" %>

    <!-- Content Area -->
    <main class="flex-1 p-8 overflow-y-auto animate-slide-in">
      
      <!-- Statistics / Header Actions -->
      <div class="flex flex-col md:flex-row md:items-end justify-between gap-6 mb-10">
        <div>
          <h3 class="text-3xl font-bold text-white tracking-tight">유저 베이스</h3>
          <p class="text-admin-text-sub mt-2 max-w-md">시스템에 등록된 전체 사용자 데이터를 관리합니다. 보안을 위해 민감한 데이터 노출에 주의하십시오.</p>
        </div>
        <div class="flex gap-3">
          <div class="px-5 py-3 glass-effect rounded-2xl border border-admin-border flex items-center gap-4">
            <div class="text-right">
              <p class="text-[10px] text-admin-text-sub font-black uppercase tracking-widest">Active Users</p>
              <p class="text-xl font-black text-white leading-none mt-1">${users.size()}</p>
            </div>
            <div class="w-10 h-10 bg-admin-primary/10 rounded-xl flex items-center justify-center border border-admin-primary/20">
              <i class="bi bi-people-fill text-admin-primary text-xl"></i>
            </div>
          </div>
          <button class="h-full px-6 bg-admin-primary hover:bg-rose-700 text-white font-bold rounded-2xl transition-all shadow-glow flex items-center gap-2 group">
            <i class="bi bi-file-earmark-spreadsheet-fill transition-transform group-hover:scale-110"></i>
            <span>Export CSV</span>
          </button>
        </div>
      </div>

      <!-- Main Data Card -->
      <div class="glass-effect rounded-[2rem] border border-admin-border shadow-premium overflow-hidden">
        
        <!-- Search & Filter Bar -->
        <div class="p-8 border-b border-admin-border bg-white/[0.02] flex items-center justify-between">
          <h4 class="text-sm font-bold uppercase tracking-widest text-admin-text-sub flex items-center gap-2">
            <i class="bi bi-table text-admin-primary"></i>
            User Directory
          </h4>
          <div class="flex items-center gap-4">
             <!-- DataTables search will be injected here automatically if used with default label mapping -->
          </div>
        </div>

        <!-- Table Implementation -->
        <div class="p-6">
          <table id="datatablesSimple" class="premium-table w-full">
            <thead>
              <tr>
                <th class="w-20">Identity</th>
                <th>Credential ID</th>
                <th>Public Profile</th>
                <th>Security Level</th>
                <th class="text-center">System Action</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="user" items="${users}">
                <tr class="group hover:bg-white/[0.02] transition-colors">
                  <td>
                    <div class="relative w-12 h-12">
                      <img src="${user.profileImg != null ? user.profileImg : '/img/Default_Profile.png'}" 
                           class="w-full h-full rounded-2xl object-cover border border-white/5 shadow-lg group-hover:border-admin-primary/40 transition-all duration-300" alt="profile">
                      <div class="absolute -bottom-1 -right-1 w-3.5 h-3.5 bg-green-500 border-4 border-admin-surface rounded-full"></div>
                    </div>
                  </td>
                  <td>
                    <div class="flex flex-col">
                      <span class="text-white font-black text-sm tracking-tight">${user.id}</span>
                      <div class="flex items-center gap-2 mt-1">
                        <span class="text-[9px] uppercase tracking-widest text-admin-text-sub font-bold px-1.5 py-0.5 bg-white/5 rounded-md border border-white/5">Primary key</span>
                      </div>
                    </div>
                  </td>
                  <td>
                    <div class="flex items-center gap-3">
                      <span class="text-sm font-bold text-white/90 group-hover:text-admin-primary transition-colors">${user.nickname}</span>
                      <div class="w-1 h-1 rounded-full bg-white/20"></div>
                      <span class="text-[10px] text-admin-text-sub uppercase font-bold tracking-widest">Active Member</span>
                    </div>
                  </td>
                  <td>
                    <div class="inline-flex items-center gap-2 px-3 py-1.5 rounded-xl bg-blue-500/5 border border-blue-500/10">
                      <i class="bi bi-shield-check text-blue-400 text-xs"></i>
                      <span class="text-blue-400 text-[10px] font-black uppercase tracking-widest">Level 1 User</span>
                    </div>
                  </td>
                  <td>
                    <div class="flex items-center justify-center gap-2">
                      <button class="w-9 h-9 flex items-center justify-center bg-white/5 border border-white/10 rounded-xl hover:bg-white/10 text-admin-text-sub hover:text-white transition-all">
                        <i class="bi bi-pencil-square"></i>
                      </button>
                      <button onclick="deleteUser('${user.id}')" class="w-9 h-9 flex items-center justify-center bg-rose-500/10 border border-rose-500/20 rounded-xl hover:bg-rose-500 text-rose-500 hover:text-white transition-all shadow-sm hover:shadow-rose-500/20">
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

    <!-- Global Footer -->
    <%@ include file="admin/layout/footer.jsp" %>
  </div>

  <script>
    window.addEventListener('DOMContentLoaded', event => {
      const dataTable = new simpleDatatables.DataTable("#datatablesSimple", {
        searchable: true,
        fixedHeight: false,
        perPage: 10,
        labels: {
          placeholder: "Search identity...",
          perPage: "표시 개수",
          noRows: "No matches found",
          info: "Showing {start} to {end} of {rows}",
        }
      });
    });
    function deleteUser(userId) {
      if (!confirm("CRITICAL: " + userId + " 유저의 모든 데이터가 영구 삭제됩니다. 계속하시겠습니까?")) return;
      
      // Axios for better UX/Error handling
      axios.get('${baseURL}/admin/deleteUser/' + userId)
        .then(() => {
          // You could replace alert with a toast here
          alert('사용자가 성공적으로 삭제되었습니다.');
          location.reload();
        })
        .catch(err => {
          console.error(err);
          alert('처리 중 오류가 발생했습니다.');
        });
    }
  </script>
</body>
</html>
