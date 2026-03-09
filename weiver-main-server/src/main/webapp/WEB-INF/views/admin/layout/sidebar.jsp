<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<aside id="sidebar" class="w-[280px] shrink-0 glass-effect border-r border-admin-border flex flex-col min-h-screen">
  <!-- Brand Branding -->
  <div class="p-8">
    <div class="flex items-center gap-3 group">
      <div class="w-10 h-10 bg-admin-primary rounded-2xl flex items-center justify-center shadow-glow transition-transform group-hover:scale-110">
        <i class="bi bi-rocket-takeoff-fill text-white text-xl"></i>
      </div>
      <div>
        <h1 class="text-2xl font-serif text-white tracking-tighter leading-none">WIEVER</h1>
        <p class="text-[9px] text-admin-primary font-bold tracking-[0.3em] uppercase mt-1">Admin Central</p>
      </div>
    </div>
  </div>

  <!-- Navigation -->
  <nav class="flex-1 px-4 py-6 space-y-8 overflow-y-auto">
    <!-- Category: Management -->
    <div>
      <h3 class="px-4 text-[10px] text-admin-text-sub font-bold uppercase tracking-widest mb-4 opacity-50">Data Infrastructure</h3>
      <div class="space-y-1">
        <a href="${baseURL}/admin/getAllActors" 
           class="flex items-center gap-3 px-4 py-3 rounded-xl text-sm font-semibold transition-all duration-200 hover:bg-white/5 hover:text-white ${pageName == 'actors' ? 'nav-item-active' : 'text-admin-text-sub'}">
          <i class="bi bi-people-fill"></i>
          <span>Talent Pool</span>
        </a>
        <a href="${baseURL}/admin/getAllMusicals" 
           class="flex items-center gap-3 px-4 py-3 rounded-xl text-sm font-semibold transition-all duration-200 hover:bg-white/5 hover:text-white ${pageName == 'musicals' ? 'nav-item-active' : 'text-admin-text-sub'}">
          <i class="bi bi-music-note-list"></i>
          <span>Musicals</span>
        </a>
        <a href="${baseURL}/admin/getAllUsers" 
           class="flex items-center gap-3 px-4 py-3 rounded-xl text-sm font-semibold transition-all duration-200 hover:bg-white/5 hover:text-white ${pageName == 'users' ? 'nav-item-active' : 'text-admin-text-sub'}">
          <i class="bi bi-person-vcard-fill"></i>
          <span>User Base</span>
        </a>
        <a href="${baseURL}/admin/getAllAdmins" 
           class="flex items-center gap-3 px-4 py-3 rounded-xl text-sm font-semibold transition-all duration-200 hover:bg-white/5 hover:text-white ${pageName == 'admins' ? 'nav-item-active' : 'text-admin-text-sub'}">
          <i class="bi bi-shield-lock-fill"></i>
          <span>Access Control</span>
        </a>
      </div>
    </div>

    <!-- Category: Community -->
    <div>
      <h3 class="px-4 text-[10px] text-admin-text-sub font-bold uppercase tracking-widest mb-4 opacity-50">Operations</h3>
      <div class="space-y-1">
        <a href="${baseURL}/admin/getAllPosts" 
           class="flex items-center gap-3 px-4 py-3 rounded-xl text-sm font-semibold transition-all duration-200 hover:bg-white/5 hover:text-white ${pageName == 'posts' ? 'nav-item-active' : 'text-admin-text-sub'}">
          <i class="bi bi-chat-left-dots-fill"></i>
          <span>Content Log</span>
        </a>
        <a href="${baseURL}/admin/getAllInquirys" 
           class="flex items-center gap-3 px-4 py-3 rounded-xl text-sm font-semibold transition-all duration-200 hover:bg-white/5 hover:text-white ${pageName == 'inquiries' ? 'nav-item-active' : 'text-admin-text-sub'}">
          <i class="bi bi-headset"></i>
          <span>Support Desk</span>
        </a>
        <a href="${baseURL}/admin/crawling" 
           class="flex items-center gap-3 px-4 py-3 rounded-xl text-sm font-semibold transition-all duration-200 hover:bg-white/5 hover:text-white ${pageName == 'crawling' ? 'nav-item-active' : 'text-admin-text-sub'}">
          <i class="bi bi-cpu-fill"></i>
          <span>System Engine</span>
        </a>
      </div>
    </div>
  </nav>

  <!-- User Profile & Settings -->
  <div class="p-6">
    <div class="bg-admin-surface/50 border border-admin-border rounded-2xl p-4 shadow-premium">
      <div class="flex items-center gap-3 mb-4">
        <div class="w-10 h-10 rounded-xl bg-gradient-to-br from-admin-primary to-admin-secondary flex items-center justify-center border border-white/10">
          <span class="font-bold text-white uppercase">${fn:substring(sessionScope.adminId, 0, 1)}</span>
        </div>
        <div class="overflow-hidden">
          <p class="text-xs font-bold text-white truncate">${sessionScope.adminId}</p>
          <div class="flex items-center gap-1.5 mt-0.5">
            <span class="w-1.5 h-1.5 rounded-full bg-green-500 animate-pulse"></span>
            <p class="text-[9px] text-admin-text-sub uppercase tracking-wider font-bold">Authorized</p>
          </div>
        </div>
      </div>
      <a href="${baseURL}/admin/logout" 
         class="flex items-center justify-center gap-2 w-full py-2.5 bg-white/5 hover:bg-admin-primary/20 hover:text-admin-primary rounded-xl text-[11px] font-bold transition-all border border-transparent hover:border-admin-primary/30">
        <i class="bi bi-power"></i>
        <span>LOGOUT SESSION</span>
      </a>
    </div>
  </div>
</aside>
