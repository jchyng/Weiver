<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageName" value="actors" scope="request"/>
<c:set var="title" value="Actor Profile" scope="request"/>

<!DOCTYPE html>
<html lang="ko">
<head>
  <title>WIEVER Admin - Edit Actor</title>
  <%@ include file="admin/layout/head.jsp" %>
</head>

<body class="flex min-h-screen bg-admin-bg font-sans">
  <%@ include file="admin/layout/sidebar.jsp" %>

  <div class="flex-1 flex flex-col min-w-0">
    <%@ include file="admin/layout/topbar.jsp" %>

    <main class="flex-1 p-8 overflow-y-auto animate-slide-in pb-20">
      
      <div class="max-w-4xl mx-auto">
        <div class="flex items-center justify-between mb-8">
          <a href="${baseURL}/admin/getAllActors" class="text-xs font-black uppercase tracking-widest text-admin-text-sub hover:text-white transition-colors flex items-center gap-2">
            <i class="bi bi-arrow-left"></i>
            Back to Talent Pool
          </a>
        </div>

        <form action="${baseURL}/admin/updateActor" method="GET" class="space-y-8">
          <div class="glass-effect rounded-[2.5rem] border border-admin-border p-10 shadow-premium">
             <div class="flex flex-col md:flex-row gap-10">
                <!-- Avatar Upload Area -->
                <div class="flex flex-col items-center gap-4">
                   <div class="relative w-40 h-52 rounded-[2rem] overflow-hidden border-2 border-admin-border group shadow-premium">
                      <img src="${actor.profileImage}" id="preview-img" class="w-full h-full object-cover transition-transform group-hover:scale-110" onerror="this.src='/img/Default_Profile.png'">
                      <div class="absolute inset-0 bg-black/40 opacity-0 group-hover:opacity-100 transition-opacity flex items-center justify-center">
                         <i class="bi bi-camera-fill text-white text-3xl"></i>
                      </div>
                   </div>
                   <p class="text-[9px] text-admin-text-sub font-black uppercase tracking-widest">Profile Portrait</p>
                </div>

                <!-- Fields Area -->
                <div class="flex-1 space-y-8">
                   <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
                      <div class="space-y-2">
                         <label class="text-[10px] font-black text-admin-text-sub uppercase tracking-[0.2em] ml-1">Identity ID</label>
                         <input type="text" name="id" value="${actor.id}" readonly
                           class="w-full bg-white/5 border border-white/10 rounded-2xl px-6 py-4 text-sm font-bold text-white/40 cursor-not-allowed">
                      </div>
                      <div class="space-y-2">
                         <label class="text-[10px] font-black text-admin-text-sub uppercase tracking-[0.2em] ml-1">Artist Name</label>
                         <input type="text" name="name" value="${actor.name}" required
                           class="w-full bg-admin-bg/50 border border-white/10 rounded-2xl px-6 py-4 text-sm font-bold text-white focus:border-admin-primary transition-all shadow-inner">
                      </div>
                   </div>

                   <div class="space-y-2">
                      <label class="text-[10px] font-black text-admin-text-sub uppercase tracking-[0.2em] ml-1">Profile Image URL</label>
                      <input type="text" name="profileImage" value="${actor.profileImage}" oninput="document.getElementById('preview-img').src=this.value"
                        class="w-full bg-admin-bg/50 border border-white/10 rounded-2xl px-6 py-4 text-sm font-bold text-white focus:border-admin-primary transition-all">
                   </div>
                </div>
             </div>
             
             <div class="mt-12 pt-8 border-t border-white/5 flex justify-end gap-4">
                <button type="submit" class="px-10 py-4 bg-admin-primary text-white text-[11px] font-black uppercase tracking-[0.2em] rounded-2xl shadow-glow hover:bg-rose-700 transition-all flex items-center gap-3 group">
                   <span>Synchronize Data</span>
                   <i class="bi bi-cloud-check-fill transition-transform group-hover:scale-125"></i>
                </button>
             </div>
          </div>
        </form>

        <!-- Danger Zone -->
        <div class="mt-12 glass-effect rounded-[2.5rem] border border-rose-500/10 p-10 bg-rose-500/[0.01]">
           <h4 class="text-xs font-black text-rose-500 uppercase tracking-[0.2em] mb-4 flex items-center gap-2">
              <i class="bi bi-exclamation-triangle-fill"></i> Danger Zone
           </h4>
           <div class="flex items-center justify-between">
              <div>
                 <p class="text-sm font-bold text-white/90">이 배우를 데이터베이스에서 영구 삭제</p>
                 <p class="text-[11px] text-admin-text-sub mt-1">삭제 시 복구가 불가능하며 모든 관련 캐스팅 정보가 소멸됩니다.</p>
              </div>
              <button onclick="deleteActor('${actor.id}')" class="px-6 py-3 bg-rose-500/10 border border-rose-500/20 text-rose-500 text-[10px] font-black uppercase tracking-widest rounded-xl hover:bg-rose-500 hover:text-white transition-all">
                 Terminate Entity
              </button>
           </div>
        </div>
      </div>

    </main>

    <%@ include file="admin/layout/footer.jsp" %>
  </div>

  <script>
    function deleteActor(id) {
      if(!confirm("DANGER: 이 배우의 모든 데이터를 즉시 소멸시키겠습니까?")) return;
      axios.get('${baseURL}/admin/deleteActor/' + id)
        .then(() => {
          alert('데이터가 성공적으로 제거되었습니다.');
          window.location.href = '${baseURL}/admin/getAllActors';
        })
        .catch(err => alert('삭제 엔진 오류: ' + err.message));
    }
  </script>
</body>
</html>
