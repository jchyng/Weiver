<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageName" value="inquiries" scope="request"/>
<c:set var="title" value="Resolve Ticket" scope="request"/>

<!DOCTYPE html>
<html lang="ko">
<head>
  <title>WIEVER Admin - Answer Inquiry</title>
  <%@ include file="admin/layout/head.jsp" %>
</head>

<body class="flex min-h-screen bg-admin-bg font-sans">
  <%@ include file="admin/layout/sidebar.jsp" %>

  <div class="flex-1 flex flex-col min-w-0">
    <%@ include file="admin/layout/topbar.jsp" %>

    <main class="flex-1 p-8 overflow-y-auto animate-slide-in">
      
      <div class="max-w-4xl mx-auto space-y-8 pb-20">
        
        <!-- Header Actions -->
        <div class="flex items-center justify-between">
          <a href="${baseURL}/admin/getAllInquirys" class="inline-flex items-center gap-2 text-xs font-black uppercase tracking-widest text-admin-text-sub hover:text-white transition-colors group">
            <i class="bi bi-arrow-left transition-transform group-hover:-translate-x-1"></i>
            Back to Ticket List
          </a>
          <span class="px-3 py-1 rounded-full bg-admin-primary/10 border border-admin-primary/20 text-[10px] font-black text-admin-primary uppercase tracking-widest">Priority Support</span>
        </div>

        <!-- Inquiry Content View -->
        <div class="glass-effect rounded-[2.5rem] border border-admin-border overflow-hidden shadow-premium">
          <div class="px-10 py-8 border-b border-admin-border bg-white/[0.02] flex items-center justify-between">
            <div class="flex items-center gap-4">
              <div class="w-12 h-12 rounded-2xl bg-admin-surface border border-white/5 flex items-center justify-center shadow-inner">
                <i class="bi bi-chat-left-dots-fill text-admin-primary text-xl"></i>
              </div>
              <div>
                <h3 class="text-xl font-bold text-white tracking-tight">${inquiry.title}</h3>
                <p class="text-[10px] text-admin-text-sub font-black uppercase tracking-[0.2em] mt-1 opacity-50">Original Inquiry Payload</p>
              </div>
            </div>
            <div class="text-right">
              <p class="text-[10px] font-black text-admin-text-sub uppercase tracking-widest mb-1 opacity-40">Reference ID</p>
              <p class="text-xs font-bold text-white uppercase tracking-tighter">TK-${inquiry.id}</p>
            </div>
          </div>

          <div class="p-10 space-y-10">
            <!-- Metadata Grid -->
            <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
              <div class="space-y-1.5">
                <p class="text-[9px] font-black text-admin-text-sub uppercase tracking-[0.2em] opacity-40">Requesting User</p>
                <div class="flex items-center gap-2">
                  <div class="w-1.5 h-1.5 rounded-full bg-admin-primary"></div>
                  <p class="text-sm font-bold text-white">${inquiry.userId}</p>
                </div>
              </div>
              <div class="space-y-1.5">
                <p class="text-[9px] font-black text-admin-text-sub uppercase tracking-[0.2em] opacity-40">Submission Time</p>
                <p class="text-sm font-bold text-white">${inquiry.createdTime}</p>
              </div>
              <div class="space-y-1.5">
                <p class="text-[9px] font-black text-admin-text-sub uppercase tracking-[0.2em] opacity-40">Ticket Status</p>
                <span class="inline-block px-2 py-0.5 rounded-md bg-amber-500/10 border border-amber-500/20 text-amber-500 text-[9px] font-black uppercase tracking-widest">Pending Review</span>
              </div>
            </div>

            <!-- Content Area -->
            <div class="bg-admin-bg/50 border border-white/5 rounded-[2rem] p-8 relative">
              <i class="bi bi-quote absolute top-6 left-6 text-4xl text-white/5"></i>
              <p class="text-sm text-admin-text-sub leading-relaxed whitespace-pre-wrap relative z-10 pl-4 border-l border-admin-primary/20">
                ${inquiry.content}
              </p>
            </div>
          </div>
        </div>

        <!-- Resolution Form -->
        <form action="${baseURL}/answerInquiry" method="POST" class="glass-effect rounded-[2.5rem] border border-admin-primary/20 overflow-hidden shadow-premium">
          <input type="hidden" name="id" value="${inquiry.id}">
          
          <div class="px-10 py-8 border-b border-admin-border bg-admin-primary/5 flex items-center gap-4">
             <div class="w-10 h-10 rounded-xl bg-admin-primary flex items-center justify-center shadow-glow">
                <i class="bi bi-shield-check text-white text-lg"></i>
             </div>
             <div>
                <h4 class="text-sm font-black text-white uppercase tracking-[0.2em]">Administrative Response</h4>
                <p class="text-[10px] text-admin-primary font-bold mt-1">이 답변은 사용자에게 즉시 전송됩니다.</p>
             </div>
          </div>

          <div class="p-10 space-y-8">
            <div class="space-y-4">
               <label class="text-[10px] font-black text-admin-text-sub uppercase tracking-[0.2em] opacity-50 ml-1">Resolution Protocol</label>
               <textarea name="answerContent" rows="10" 
                 class="w-full bg-admin-bg/50 border border-white/10 rounded-3xl p-8 focus:outline-none focus:border-admin-primary transition-all text-sm text-white leading-relaxed placeholder-white/10" 
                 placeholder="여기에 답변 내용을 상세히 입력하십시오. 전문적이고 정중한 어조를 유지하십시오..." required></textarea>
            </div>

            <div class="flex items-center justify-end gap-4">
               <button type="reset" class="px-8 py-4 text-[10px] font-black text-admin-text-sub uppercase tracking-widest hover:text-white transition-colors">
                  Reset Form
               </button>
               <button type="submit" class="px-10 py-4 bg-admin-primary hover:bg-rose-700 text-white text-[11px] font-black uppercase tracking-[0.2em] rounded-2xl transition-all shadow-glow flex items-center gap-3 group">
                  <span>Commit Response</span>
                  <i class="bi bi-send-fill transition-transform group-hover:translate-x-1 group-hover:-translate-y-1"></i>
               </button>
            </div>
          </div>
        </form>

      </div>

    </main>

    <%@ include file="admin/layout/footer.jsp" %>
  </div>
</body>
</html>
