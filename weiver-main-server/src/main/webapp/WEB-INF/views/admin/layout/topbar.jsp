<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<header class="h-20 glass-effect border-b border-admin-border flex items-center justify-between px-10 sticky top-0 z-10">
  <div class="flex items-center gap-4">
    <div class="w-1.5 h-6 bg-admin-primary rounded-full shadow-glow"></div>
    <h2 class="text-xl font-bold tracking-tight text-white">${title} <span class="text-admin-text-sub font-medium text-sm ml-3 opacity-60">/ Management Console</span></h2>
  </div>
  
  <div class="flex items-center gap-6">
    <div class="hidden lg:flex items-center gap-3 text-[10px] font-black uppercase tracking-widest text-admin-text-sub">
      <div class="flex items-center gap-1.5 px-3 py-1.5 bg-green-500/10 text-green-400 rounded-full border border-green-500/20">
        <span class="w-1.5 h-1.5 rounded-full bg-green-500 animate-pulse"></span>
        SYSTEM SECURE
      </div>
      <div class="h-4 w-px bg-white/10 mx-2"></div>
      <span class="text-white/40"><i class="bi bi-clock-history mr-2"></i>LAST SYNC: 2M AGO</span>
    </div>
    
    <div class="flex items-center gap-3">
      <button class="w-10 h-10 rounded-xl bg-white/5 border border-white/10 flex items-center justify-center hover:bg-white/10 transition-all group">
        <i class="bi bi-bell text-admin-text-sub group-hover:text-white"></i>
      </button>
      <div class="h-8 w-px bg-white/10 mx-1"></div>
      <div class="text-right">
        <p class="text-[11px] font-bold text-white leading-none">${sessionScope.adminId}</p>
        <p class="text-[9px] text-admin-primary uppercase tracking-widest mt-1">Superuser</p>
      </div>
    </div>
  </div>
</header>
