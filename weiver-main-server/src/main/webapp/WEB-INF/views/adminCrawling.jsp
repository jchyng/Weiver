<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageName" value="crawling" scope="request"/>
<c:set var="title" value="System Engine" scope="request"/>

<!DOCTYPE html>
<html lang="ko">
<head>
  <title>WIEVER Admin - Data Crawler</title>
  <%@ include file="admin/layout/head.jsp" %>
  <style>
    .status-pulse {
      animation: pulse-ring 1.25s cubic-bezier(0.215, 0.61, 0.355, 1) infinite;
    }
    @keyframes pulse-ring {
      0% { transform: scale(.33); }
      80%, 100% { opacity: 0; }
    }
    .progress-bar-glow {
      box-shadow: 0 0 15px rgba(225, 29, 72, 0.5);
    }
  </style>
</head>

<body class="flex min-h-screen bg-admin-bg font-sans">
  <%@ include file="admin/layout/sidebar.jsp" %>

  <div class="flex-1 flex flex-col min-w-0">
    <%@ include file="admin/layout/topbar.jsp" %>

    <main class="flex-1 p-8 overflow-y-auto animate-slide-in text-admin-text">
      
      <!-- Engine Status Header -->
      <div class="flex flex-col md:flex-row md:items-center justify-between gap-6 mb-10">
        <div class="flex items-center gap-6">
          <div id="engine-status-icon" class="w-16 h-16 rounded-[2rem] glass-effect flex items-center justify-center border border-admin-border relative shadow-premium">
            <i class="bi bi-cpu-fill text-3xl text-admin-text-sub transition-colors duration-500"></i>
            <div id="status-ping" class="absolute -top-1 -right-1 w-4 h-4 rounded-full bg-slate-500 border-4 border-admin-bg transition-colors duration-500"></div>
          </div>
          <div>
            <h3 class="text-3xl font-bold text-white tracking-tight">시스템 크롤링</h3>
            <p id="status-text" class="text-admin-text-sub mt-1 font-medium tracking-wide">상태 확인 중...</p>
          </div>
        </div>
        <div class="flex gap-4">
           <button id="btn-trigger" onclick="triggerCrawling()" 
                   class="px-8 py-3.5 bg-admin-primary hover:bg-rose-700 disabled:bg-white/5 disabled:text-admin-text-sub text-white font-black uppercase tracking-widest rounded-2xl transition-all shadow-glow flex items-center gap-3 group">
            <i class="bi bi-lightning-charge-fill transition-transform group-hover:scale-125"></i>
            <span>Execute Task</span>
          </button>
        </div>
      </div>

      <div class="grid grid-cols-1 lg:grid-cols-3 gap-8 mb-10">
        <!-- Dashboard Card 1: Active Progress -->
        <div class="lg:col-span-2 glass-effect rounded-[2.5rem] border border-admin-border p-10 shadow-premium relative overflow-hidden">
          <div class="absolute top-0 right-0 p-8 opacity-5">
            <i class="bi bi-activity text-8xl"></i>
          </div>
          
          <div class="relative z-10">
            <div class="flex items-center justify-between mb-8">
              <h4 class="text-xs font-black uppercase tracking-[0.2em] text-admin-primary">Live Operations</h4>
              <span id="current-genre" class="px-3 py-1 bg-white/5 rounded-lg border border-white/5 text-[10px] font-bold text-admin-text-sub">Waiting for instruction</span>
            </div>

            <div class="mb-4 flex items-end justify-between">
              <p class="text-4xl font-black text-white" id="progress-percent">0%</p>
              <p class="text-[10px] font-bold text-admin-text-sub uppercase tracking-widest" id="progress-fraction">0 / 0 GENRES</p>
            </div>

            <!-- Custom Progress Bar -->
            <div class="h-4 w-full bg-white/5 rounded-full overflow-hidden border border-white/5 p-1">
              <div id="progress-bar" class="h-full bg-gradient-to-r from-admin-primary to-admin-secondary rounded-full transition-all duration-1000 w-0 progress-bar-glow"></div>
            </div>
          </div>
        </div>

        <!-- Dashboard Card 2: Configuration -->
        <div class="glass-effect rounded-[2.5rem] border border-admin-border p-10 shadow-premium">
          <h4 class="text-xs font-black uppercase tracking-[0.2em] text-admin-primary mb-8">Configurations</h4>
          
          <div class="space-y-6">
            <div class="flex items-center justify-between py-2 border-b border-white/5">
              <span class="text-xs font-bold text-admin-text-sub">Startup Hook</span>
              <span id="cfg-startup" class="text-[10px] font-black px-2 py-1 rounded-md bg-white/5">OFF</span>
            </div>
            <div class="flex items-center justify-between py-2 border-b border-white/5">
              <span class="text-xs font-bold text-admin-text-sub">Scheduler</span>
              <span id="cfg-schedule" class="text-[10px] font-black px-2 py-1 rounded-md bg-white/5">OFF</span>
            </div>
            <div class="flex items-center justify-between py-2">
              <span class="text-xs font-bold text-admin-text-sub">Data Target</span>
              <span class="text-[10px] font-black text-white">INTERPARK_API</span>
            </div>
          </div>
        </div>
      </div>

      <!-- Logs / Metrics Section -->
      <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
        <div class="glass-effect rounded-[2rem] border border-admin-border shadow-premium overflow-hidden">
          <div class="px-8 py-6 border-b border-admin-border bg-white/[0.02]">
            <h4 class="text-[10px] font-black uppercase tracking-widest text-admin-text-sub">Runtime Analytics</h4>
          </div>
          <div class="p-8 space-y-8">
            <div class="grid grid-cols-2 gap-8">
              <div>
                <p class="text-[9px] font-black uppercase tracking-widest text-admin-text-sub mb-2 opacity-50">Last Start Time</p>
                <p id="started-at" class="text-sm font-bold text-white tracking-tight">-</p>
              </div>
              <div>
                <p class="text-[9px] font-black uppercase tracking-widest text-admin-text-sub mb-2 opacity-50">Duration Metrics</p>
                <p id="duration" class="text-sm font-bold text-white tracking-tight">-</p>
              </div>
            </div>
            <div>
              <p class="text-[9px] font-black uppercase tracking-widest text-admin-text-sub mb-2 opacity-50">Last Successful Sync</p>
              <p id="finished-at" class="text-sm font-bold text-white tracking-tight">-</p>
            </div>
          </div>
        </div>

        <div class="glass-effect rounded-[2rem] border border-admin-border shadow-premium overflow-hidden flex flex-col">
          <div class="px-8 py-6 border-b border-admin-border bg-white/[0.02] flex items-center justify-between">
            <h4 class="text-[10px] font-black uppercase tracking-widest text-admin-text-sub">System Event Log</h4>
            <div class="w-2 h-2 rounded-full bg-admin-primary animate-pulse"></div>
          </div>
          <div id="log-console" class="p-6 flex-1 bg-black/40 font-mono text-[10px] text-admin-text-sub min-h-[160px] overflow-y-auto leading-relaxed">
            [SYS] Kernel initialized.<br>
            [SYS] Waiting for crawler signal...<br>
          </div>
        </div>
      </div>

    </main>

    <%@ include file="admin/layout/footer.jsp" %>
  </div>

  <script>
    let pollInterval;
    const logConsole = document.getElementById('log-console');

    function addLog(msg, type = 'SYS') {
      const now = new Date().toLocaleTimeString();
      const line = `<div><span class="text-white/20">[${now}]</span> <span class="text-admin-primary">[${type}]</span> ${msg}</div>`;
      logConsole.innerHTML += line;
      logConsole.scrollTop = logConsole.scrollHeight;
    }

    function updateStatus() {
      axios.get('${baseURL}/admin/crawling/status')
        .then(res => {
          const s = res.data;
          const isRunning = s.running;
          
          // UI Elements
          const icon = document.querySelector('#engine-status-icon i');
          const ping = document.getElementById('status-ping');
          const btn = document.getElementById('btn-trigger');
          
          if (isRunning) {
            icon.classList.replace('text-admin-text-sub', 'text-admin-primary');
            icon.classList.add('animate-spin');
            ping.classList.replace('bg-slate-500', 'bg-admin-primary');
            ping.classList.add('status-pulse');
            btn.disabled = true;
            btn.querySelector('span').innerText = 'System Running...';
            document.getElementById('status-text').innerText = '엔진 가동 중: 데이터를 동기화하고 있습니다.';
          } else {
            icon.classList.replace('text-admin-primary', 'text-admin-text-sub');
            icon.classList.remove('animate-spin');
            ping.classList.replace('bg-admin-primary', 'bg-slate-500');
            ping.classList.remove('status-pulse');
            btn.disabled = false;
            btn.querySelector('span').innerText = 'Execute Task';
            document.getElementById('status-text').innerText = '시스템 대기 중: 명령을 기다리고 있습니다.';
          }

          // Progress
          if (s.genreTotal > 0) {
            const p = Math.round((s.genreIndex / s.genreTotal) * 100);
            document.getElementById('progress-bar').style.width = p + '%';
            document.getElementById('progress-percent').innerText = p + '%';
            document.getElementById('progress-fraction').innerText = `${s.genreIndex} / ${s.genreTotal} GENRES`;
            document.getElementById('current-genre').innerText = s.currentGenre || 'Processing...';
          }

          // Metrics
          document.getElementById('started-at').innerText = s.startedAt;
          document.getElementById('finished-at').innerText = s.finishedAt;
          document.getElementById('duration').innerText = s.lastDuration;
          document.getElementById('cfg-startup').innerText = s.startupEnabled ? 'ON' : 'OFF';
          document.getElementById('cfg-schedule').innerText = s.scheduleEnabled ? 'ON' : 'OFF';

          if (isRunning && !pollInterval) {
            addLog('Execution process detected. Initializing monitor...');
            pollInterval = setInterval(updateStatus, 2000);
          } else if (!isRunning && pollInterval) {
            addLog('Task completed. Monitoring paused.');
            clearInterval(pollInterval);
            pollInterval = null;
          }
        });
    }

    function triggerCrawling() {
      if(!confirm("시스템 자원을 대량으로 소모할 수 있습니다. 크롤링을 실행하시겠습니까?")) return;
      
      addLog('Triggering manual crawl sequence...');
      axios.post('${baseURL}/admin/crawling/trigger')
        .then(res => {
          if (res.data.success) {
            addLog('Signal accepted. Engine starting.');
            updateStatus();
          } else {
            alert(res.data.message);
          }
        });
    }

    // Initial load
    document.addEventListener('DOMContentLoaded', () => {
      updateStatus();
      setInterval(updateStatus, 5000); // Background slow poll
    });
  </script>
</body>
</html>
