<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageName" value="inquiries" scope="request"/>
<c:set var="title" value="Ticket Detail" scope="request"/>

<!DOCTYPE html>
<html lang="ko">
<head>
  <title>WIEVER Admin - Ticket #${inquiry.id}</title>
  <%@ include file="admin/layout/head.jsp" %>
</head>

<body class="flex min-h-screen bg-admin-bg font-sans">
  <%@ include file="admin/layout/sidebar.jsp" %>

  <div class="flex-1 flex flex-col min-w-0">
    <%@ include file="admin/layout/topbar.jsp" %>

    <main class="flex-1 p-8 overflow-y-auto animate-slide-in pb-20">
      
      <div class="max-w-5xl mx-auto">
        <!-- Breadcrumb & Actions -->
        <div class="flex items-center justify-between mb-8">
          <a href="${baseURL}/admin/getAllInquirys" class="text-xs font-black uppercase tracking-widest text-admin-text-sub hover:text-white transition-colors flex items-center gap-2">
            <i class="bi bi-arrow-left"></i>
            Back to Registry
          </a>
          <div class="flex gap-3">
             <button onclick="deleteInquiry('${inquiry.id}')" class="px-5 py-2.5 bg-rose-500/10 border border-rose-500/20 text-rose-500 text-[10px] font-black uppercase tracking-widest rounded-xl hover:bg-rose-500 hover:text-white transition-all">
                Delete Ticket
             </button>
             <c:if test="${inquiry.answer == null}">
               <a href="${baseURL}/admin/getInquiryDetail/${inquiry.id}" class="px-5 py-2.5 bg-admin-primary text-white text-[10px] font-black uppercase tracking-widest rounded-xl shadow-glow hover:bg-rose-700 transition-all">
                  Process Response
               </a>
             </c:if>
          </div>
        </div>

        <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
          <!-- Left Column: Content -->
          <div class="lg:col-span-2 space-y-8">
            <div class="glass-effect rounded-[2.5rem] border border-admin-border p-10 shadow-premium relative overflow-hidden">
               <div class="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-admin-primary to-transparent opacity-30"></div>
               <div class="flex items-center gap-4 mb-8">
                  <span class="px-3 py-1 bg-white/5 border border-white/10 rounded-lg text-[10px] font-black text-admin-primary tracking-widest uppercase">Subject</span>
                  <h3 class="text-2xl font-bold text-white tracking-tight">${inquiry.title}</h3>
               </div>
               <div class="bg-admin-bg/40 border border-white/5 rounded-3xl p-8 min-h-[300px]">
                  <p class="text-sm text-admin-text-sub leading-relaxed whitespace-pre-wrap">${inquiry.content}</p>
               </div>
            </div>

            <!-- Resolution Section (if answered) -->
            <c:if test="${inquiry.answer != null}">
              <div class="glass-effect rounded-[2.5rem] border border-green-500/20 p-10 shadow-premium relative overflow-hidden bg-green-500/[0.02]">
                 <div class="flex items-center gap-4 mb-8">
                    <div class="w-10 h-10 rounded-xl bg-green-500 flex items-center justify-center shadow-[0_0_20px_rgba(34,197,94,0.3)]">
                       <i class="bi bi-check-all text-white text-xl"></i>
                    </div>
                    <div>
                       <h4 class="text-sm font-black text-white uppercase tracking-widest">Administrative Resolution</h4>
                       <p class="text-[9px] text-green-500 font-bold mt-0.5">답변이 완료된 티켓입니다.</p>
                    </div>
                 </div>
                 <div class="bg-black/20 border border-green-500/10 rounded-3xl p-8">
                    <p class="text-sm text-admin-text-sub leading-relaxed whitespace-pre-wrap">${inquiry.answer.answer}</p>
                 </div>
              </div>
            </c:if>

            <!-- Quick Answer Form (if not answered) -->
            <c:if test="${inquiry.answer == null}">
              <form action="${baseURL}/answerInquiry" method="POST" class="glass-effect rounded-[2.5rem] border border-admin-primary/20 p-10 shadow-premium">
                <input type="hidden" name="id" value="${inquiry.id}">
                <h4 class="text-xs font-black text-admin-primary uppercase tracking-[0.2em] mb-6 flex items-center gap-2">
                  <i class="bi bi-pencil-fill"></i> Quick Response Protocol
                </h4>
                <textarea name="answerContent" rows="6" 
                  class="w-full bg-admin-bg/50 border border-white/10 rounded-2xl p-6 focus:outline-none focus:border-admin-primary transition-all text-sm text-white mb-6"
                  placeholder="답변 내용을 입력하십시오..."></textarea>
                <div class="flex justify-end">
                  <button type="submit" class="px-8 py-3 bg-admin-primary text-white text-[10px] font-black uppercase tracking-widest rounded-xl shadow-glow hover:bg-rose-700 transition-all">
                    Commit & Resolve
                  </button>
                </div>
              </form>
            </c:if>
          </div>

          <!-- Right Column: Meta Info -->
          <div class="space-y-8">
             <div class="glass-effect rounded-[2.5rem] border border-admin-border p-8 shadow-premium">
                <h4 class="text-[10px] font-black text-admin-text-sub uppercase tracking-widest mb-8 opacity-50">Request Information</h4>
                <div class="space-y-6">
                   <div class="flex items-center justify-between">
                      <span class="text-[10px] font-bold text-admin-text-sub uppercase">Requester</span>
                      <span class="text-xs font-bold text-white">${inquiry.userId}</span>
                   </div>
                   <div class="flex items-center justify-between">
                      <span class="text-[10px] font-bold text-admin-text-sub uppercase">Timestamp</span>
                      <span class="text-xs font-bold text-white">${inquiry.createdTime}</span>
                   </div>
                   <div class="flex items-center justify-between">
                      <span class="text-[10px] font-bold text-admin-text-sub uppercase">Status</span>
                      <c:choose>
                        <c:when test="${inquiry.answer != null}">
                          <span class="px-2 py-0.5 rounded-md bg-green-500/10 text-green-500 text-[9px] font-black uppercase tracking-tighter border border-green-500/20">Resolved</span>
                        </c:when>
                        <c:otherwise>
                          <span class="px-2 py-0.5 rounded-md bg-amber-500/10 text-amber-500 text-[9px] font-black uppercase tracking-tighter border border-amber-500/20">Open Case</span>
                        </c:otherwise>
                      </c:choose>
                   </div>
                </div>
                
                <div class="mt-10 pt-8 border-t border-white/5">
                   <p class="text-[9px] text-admin-text-sub leading-relaxed opacity-40">
                     이 문의는 보안 정책에 따라 암호화되어 저장됩니다. 답변 작성 시 개인정보 노출에 유의하십시오.
                   </p>
                </div>
             </div>
          </div>
        </div>
      </div>

    </main>

    <%@ include file="admin/layout/footer.jsp" %>
  </div>

  <script>
    function deleteInquiry(id) {
      if(!confirm("이 티켓을 영구적으로 소멸시키겠습니까?")) return;
      axios.get('${baseURL}/admin/deleteInquiry/' + id)
        .then(() => {
          alert('데이터가 제거되었습니다.');
          window.location.href = '${baseURL}/admin/getAllInquirys';
        })
        .catch(err => alert('삭제 실패: ' + err.message));
    }
  </script>
</body>
</html>
