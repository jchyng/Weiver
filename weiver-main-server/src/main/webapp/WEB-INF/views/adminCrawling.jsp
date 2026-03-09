<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="config.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>WIEVER Admin - 크롤링 상태</title>

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
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

  <style>
    body { display: flex; min-height: 100vh; }
    #sidebar { width: 240px; min-height: 100vh; flex-shrink: 0; }
    #main-content { flex: 1; min-height: 100vh; }
    .nav-link-item { display: flex; align-items: center; gap: 10px; padding: 10px 16px; border-radius: 10px; font-size: 14px; font-weight: 600; color: #94A3B8; transition: all 0.15s; margin: 2px 8px; }
    .nav-link-item:hover { background: rgba(255,255,255,0.06); color: #F8FAFC; border-left: 3px solid rgba(212,175,55,0.3); }
    .nav-link-item.active { background: rgba(190,18,60,0.15); color: #BE123C; border-left: 3px solid #D4AF37; }
    @keyframes spin { from { transform: rotate(0deg); } to { transform: rotate(360deg); } }
    @keyframes pulse-ring {
      0% { transform: scale(0.85); box-shadow: 0 0 0 0 rgba(34,197,94,0.5); }
      70% { transform: scale(1); box-shadow: 0 0 0 8px rgba(34,197,94,0); }
      100% { transform: scale(0.85); box-shadow: 0 0 0 0 rgba(34,197,94,0); }
    }
    .step-active { animation: pulse-ring 1.5s ease-out infinite; }
    @keyframes count-up { from { opacity: 0; transform: translateY(4px); } to { opacity: 1; transform: translateY(0); } }
  </style>
</head>

<body class="bg-stage-bg text-stage-text font-sans" style="background: linear-gradient(180deg, #0f0f0f 0%, #000000 100%); min-height: 100vh;">

  <!-- Sidebar -->
  <aside id="sidebar" class="bg-stage-surface border-r border-white/10 flex flex-col">
    <div class="px-6 py-6 border-b border-stage-secondary/30">
      <h1 class="text-2xl font-serif text-stage-primary tracking-tighter">WIEVER</h1>
      <p class="text-[10px] text-stage-text-sub font-bold tracking-widest uppercase mt-0.5">Admin Dashboard</p>
    </div>
    <nav class="flex-1 py-4 overflow-y-auto">
      <p class="text-[10px] text-stage-text-sub font-bold uppercase tracking-widest px-6 mb-3 mt-2">데이터 관리</p>
      <a href="${baseURL}/admin/getAllActors" class="nav-link-item"><i class="bi bi-person-video3"></i> 배우</a>
      <a href="${baseURL}/admin/getAllMusicals" class="nav-link-item"><i class="bi bi-music-note-beamed"></i> 뮤지컬</a>
      <a href="${baseURL}/admin/getAllUsers" class="nav-link-item"><i class="bi bi-people"></i> 유저</a>
      <a href="${baseURL}/admin/getAllAdmins" class="nav-link-item"><i class="bi bi-shield-check"></i> 관리자</a>
      <a href="${baseURL}/admin/getAllPosts" class="nav-link-item"><i class="bi bi-journals"></i> 게시글</a>
      <a href="${baseURL}/admin/getAllInquirys" class="nav-link-item"><i class="bi bi-question-circle"></i> 문의</a>
      <a href="${baseURL}/admin/crawling" class="nav-link-item active"><i class="bi bi-arrow-repeat"></i> 크롤링 상태</a>
    </nav>
    <div class="px-4 py-4 border-t border-stage-secondary/20">
      <div class="flex items-center gap-3 p-3 rounded-xl bg-black/60">
        <div class="w-8 h-8 rounded-full bg-stage-primary/20 flex items-center justify-center border border-stage-primary/30 flex-shrink-0">
          <i class="bi bi-person-fill text-stage-primary text-sm"></i>
        </div>
        <div class="overflow-hidden">
          <p class="text-[10px] text-stage-text-sub font-bold uppercase leading-none mb-0.5">Logged in</p>
          <p class="text-sm font-bold truncate">${sessionScope.adminId}</p>
        </div>
      </div>
      <a href="${baseURL}/admin/logout" class="flex items-center gap-2 mt-3 px-3 py-2 rounded-xl text-stage-text-sub hover:text-rose-400 hover:bg-rose-900/10 transition-all text-sm font-bold">
        <i class="bi bi-box-arrow-right"></i> 로그아웃
      </a>
    </div>
  </aside>

  <!-- Main Content -->
  <div id="main-content" class="flex flex-col">

    <!-- Top Header -->
    <header class="h-16 bg-stage-surface/50 border-b border-stage-secondary/20 flex items-center justify-between px-6 flex-shrink-0">
      <div class="flex items-center gap-3">
        <i class="bi bi-arrow-repeat text-stage-secondary text-xl" id="spin-icon"></i>
        <div>
          <h2 class="text-lg font-bold leading-none">크롤링 모니터</h2>
          <p class="text-[11px] text-stage-text-sub mt-0.5" id="refresh-hint">5초마다 자동 갱신</p>
        </div>
      </div>
      <span class="text-sm text-stage-text-sub font-bold">안녕하세요, <span class="text-stage-text">${sessionScope.adminName}</span>님</span>
    </header>

    <main class="flex-1 p-6 space-y-5 max-w-4xl">

      <!-- ① Hero Status Row: 대형 배지 + 수동 실행 -->
      <div class="bg-stage-surface/40 border border-white/10 rounded-2xl p-6 flex items-center justify-between gap-4">
        <div class="flex items-center gap-5">
          <!-- Big status dot -->
          <div id="hero-dot" class="w-14 h-14 rounded-full flex items-center justify-center flex-shrink-0 transition-all duration-500"
               style="background:rgba(148,163,184,0.1); border:2px solid rgba(148,163,184,0.2);">
            <i id="hero-icon" class="bi bi-pause-circle text-2xl text-stage-text-sub"></i>
          </div>
          <div>
            <div class="flex items-center gap-3">
              <span id="hero-status-text" class="text-2xl font-bold">대기 중</span>
              <span id="hero-badge" class="px-3 py-1 rounded-full text-xs font-bold border"
                    style="background:rgba(148,163,184,0.1);color:#94A3B8;border-color:rgba(148,163,184,0.2);">IDLE</span>
            </div>
            <p class="text-sm text-stage-text-sub mt-1" id="hero-sub">마지막 완료: <span id="hero-finished">-</span></p>
          </div>
        </div>

        <!-- Manual trigger button -->
        <button id="trigger-btn" onclick="triggerCrawling()"
                class="flex items-center gap-2 px-5 py-3 rounded-xl font-bold text-sm transition-all duration-200 flex-shrink-0
                       bg-stage-primary/20 text-stage-primary border border-stage-primary/30
                       hover:bg-stage-primary hover:text-white disabled:opacity-40 disabled:cursor-not-allowed">
          <i class="bi bi-play-circle-fill text-base"></i>
          수동 실행
        </button>
      </div>

      <!-- ② Genre Stepper -->
      <div class="bg-stage-surface/40 border border-white/10 rounded-2xl p-6">
        <p class="text-[10px] font-bold text-stage-text-sub uppercase tracking-widest mb-5">장르 진행 단계</p>
        <div class="flex items-center gap-0" id="stepper">
          <!-- Steps generated by JS -->
        </div>
      </div>

      <!-- ③ 2-col cards -->
      <div class="grid grid-cols-1 md:grid-cols-2 gap-5">

        <!-- Current Run -->
        <div class="bg-stage-surface/40 border border-white/10 rounded-2xl overflow-hidden" id="current-run-card">
          <div class="px-5 py-4 border-b border-white/10 flex items-center gap-2">
            <div class="w-2 h-2 rounded-full bg-stage-text-sub" id="current-run-dot"></div>
            <span class="text-xs font-bold text-stage-text-sub uppercase tracking-widest">현재 실행</span>
          </div>
          <div class="divide-y divide-slate-800/60">
            <div class="flex items-center justify-between px-5 py-3.5">
              <span class="text-sm text-stage-text-sub font-medium">크롤링 유형</span>
              <span id="crawlingType" class="text-sm font-bold">-</span>
            </div>
            <div class="flex items-center justify-between px-5 py-3.5">
              <span class="text-sm text-stage-text-sub font-medium">시작 시각</span>
              <span id="startedAt" class="text-sm font-mono text-stage-text-sub">-</span>
            </div>
            <div class="flex items-center justify-between px-5 py-3.5">
              <span class="text-sm text-stage-text-sub font-medium">경과 시간</span>
              <span id="elapsedTime" class="text-sm font-bold font-mono text-stage-secondary">-</span>
            </div>
            <div class="flex items-center justify-between px-5 py-3.5">
              <span class="text-sm text-stage-text-sub font-medium">예상 잔여 (ETA)</span>
              <span id="etaTime" class="text-sm font-bold font-mono">-</span>
            </div>
          </div>
        </div>

        <!-- Last Run -->
        <div class="bg-stage-surface/40 border border-white/10 rounded-2xl overflow-hidden">
          <div class="px-5 py-4 border-b border-white/10 flex items-center gap-2">
            <div class="w-2 h-2 rounded-full bg-slate-600"></div>
            <span class="text-xs font-bold text-stage-text-sub uppercase tracking-widest">마지막 실행 기록</span>
          </div>
          <div class="divide-y divide-slate-800/60">
            <div class="flex items-center justify-between px-5 py-3.5">
              <span class="text-sm text-stage-text-sub font-medium">완료 시각</span>
              <span id="finishedAt" class="text-sm font-mono text-stage-text-sub">-</span>
            </div>
            <div class="flex items-center justify-between px-5 py-3.5">
              <span class="text-sm text-stage-text-sub font-medium">소요 시간</span>
              <span id="lastDuration" class="text-sm font-bold text-stage-secondary">-</span>
            </div>
            <div class="flex items-center justify-between px-5 py-3.5">
              <span class="text-sm text-stage-text-sub font-medium">장르당 평균</span>
              <span id="perGenreAvg" class="text-sm font-bold text-stage-text-sub">-</span>
            </div>
          </div>
        </div>

      </div>

      <!-- ④ Config row -->
      <div class="bg-stage-surface/40 border border-white/10 rounded-2xl p-5">
        <p class="text-[10px] font-bold text-stage-text-sub uppercase tracking-widest mb-4">설정 상태</p>
        <div class="flex items-center gap-4 flex-wrap">
          <div class="flex items-center gap-3 px-4 py-3 rounded-xl bg-stage-bg/60 border border-white/10">
            <i class="bi bi-rocket-takeoff text-base text-stage-text-sub"></i>
            <div>
              <p class="text-[10px] font-bold text-stage-text-sub uppercase tracking-wider leading-none mb-1">Startup 실행</p>
              <span id="startup-badge" class="text-xs font-bold px-2 py-0.5 rounded-full">-</span>
            </div>
          </div>
          <div class="flex items-center gap-3 px-4 py-3 rounded-xl bg-stage-bg/60 border border-white/10">
            <i class="bi bi-clock-history text-base text-stage-text-sub"></i>
            <div>
              <p class="text-[10px] font-bold text-stage-text-sub uppercase tracking-wider leading-none mb-1">스케줄 실행</p>
              <span id="schedule-badge" class="text-xs font-bold px-2 py-0.5 rounded-full">-</span>
            </div>
          </div>
          <p class="text-xs text-stage-text-sub ml-auto">application.properties 기준</p>
        </div>
      </div>

    </main>

    <footer class="py-4 px-6 text-center text-[10px] text-stage-text-sub font-bold uppercase tracking-[0.15em] border-t border-stage-secondary/20">
      &copy; Weiver 2023. Admin Panel.
    </footer>
  </div>

  <script>
    var BASE_URL = '${baseURL}';
    var GENRE_NAMES = ['라이센스', '오리지널', '창작', '뮤지컬'];
    var timerInterval = null;
    var lastData = null;

    // ── Stepper ──────────────────────────────────────────────
    function renderStepper(running, genreIndex, genreTotal) {
      var total = genreTotal > 0 ? genreTotal : 4;
      var html = '';
      for (var i = 0; i < total; i++) {
        var isDone    = i < genreIndex;
        var isActive  = running && i === genreIndex;
        var isPending = !isDone && !isActive;

        // Circle
        var circleStyle, circleContent;
        if (isDone) {
          circleStyle = 'width:36px;height:36px;border-radius:50%;background:#22c55e;display:flex;align-items:center;justify-content:center;flex-shrink:0;border:2px solid #22c55e;';
          circleContent = '<i class="bi bi-check2 text-white text-sm"></i>';
        } else if (isActive) {
          circleStyle = 'width:36px;height:36px;border-radius:50%;background:rgba(212, 175, 55,0.15);display:flex;align-items:center;justify-content:center;flex-shrink:0;border:2px solid #FBBF24;';
          circleContent = '<div class="step-active" style="width:12px;height:12px;border-radius:50%;background:#FBBF24;"></div>';
        } else {
          circleStyle = 'width:36px;height:36px;border-radius:50%;background:rgba(148,163,184,0.08);display:flex;align-items:center;justify-content:center;flex-shrink:0;border:2px solid rgba(148,163,184,0.2);';
          circleContent = '<span style="font-size:12px;font-weight:700;color:#475569;">' + (i + 1) + '</span>';
        }

        // Label color
        var labelColor = isDone ? '#22c55e' : isActive ? '#FBBF24' : '#475569';

        html += '<div style="display:flex;flex-direction:column;align-items:center;gap:8px;flex:1;">';
        html +=   '<div style="' + circleStyle + '">' + circleContent + '</div>';
        html +=   '<span style="font-size:11px;font-weight:700;color:' + labelColor + ';text-align:center;">' + (GENRE_NAMES[i] || ('장르 ' + (i+1))) + '</span>';
        html += '</div>';

        // Connector line (not after last)
        if (i < total - 1) {
          var lineColor = (i < genreIndex) ? '#22c55e' : 'rgba(148,163,184,0.15)';
          html += '<div style="height:2px;flex:1;background:' + lineColor + ';margin-bottom:20px;max-width:60px;"></div>';
        }
      }
      document.getElementById('stepper').innerHTML = html;
    }

    // ── Live timer ────────────────────────────────────────────
    function formatSeconds(secs) {
      if (secs < 0) return '-';
      var h = Math.floor(secs / 3600);
      var m = Math.floor((secs % 3600) / 60);
      var s = secs % 60;
      if (h > 0) return h + 'h ' + m + 'm ' + s + 's';
      if (m > 0) return m + 'm ' + s + 's';
      return s + 's';
    }

    function startLiveTimer(startedAtEpoch, lastDurationSeconds, genreIndex, genreTotal) {
      if (timerInterval) clearInterval(timerInterval);
      if (startedAtEpoch < 0) {
        document.getElementById('elapsedTime').textContent = '-';
        document.getElementById('etaTime').textContent = '-';
        return;
      }
      var total = genreTotal > 0 ? genreTotal : 4;
      timerInterval = setInterval(function() {
        var elapsedSec = Math.floor((Date.now() - startedAtEpoch) / 1000);
        document.getElementById('elapsedTime').textContent = formatSeconds(elapsedSec);

        // ETA: based on last run duration per genre
        var etaEl = document.getElementById('etaTime');
        if (lastDurationSeconds > 0 && genreIndex >= 0) {
          var perGenre = lastDurationSeconds / total;
          var remaining = Math.max(0, Math.round(perGenre * (total - genreIndex) - elapsedSec));
          etaEl.textContent = remaining > 0 ? ('~' + formatSeconds(remaining)) : '곧 완료';
          etaEl.style.color = '#FBBF24';
        } else {
          etaEl.textContent = '-';
          etaEl.style.color = '#94A3B8';
        }
      }, 1000);
    }

    function stopLiveTimer() {
      if (timerInterval) { clearInterval(timerInterval); timerInterval = null; }
      document.getElementById('elapsedTime').textContent = '-';
      document.getElementById('etaTime').textContent = '-';
    }

    // ── Config badges ─────────────────────────────────────────
    function renderConfigBadge(id, enabled) {
      var el = document.getElementById(id);
      if (enabled) {
        el.textContent = 'ON';
        el.style.cssText = 'background:rgba(34,197,94,0.15);color:#22c55e;padding:2px 8px;border-radius:9999px;';
      } else {
        el.textContent = 'OFF';
        el.style.cssText = 'background:rgba(148,163,184,0.1);color:#94A3B8;padding:2px 8px;border-radius:9999px;';
      }
    }

    // ── Main fetch ────────────────────────────────────────────
    function fetchStatus() {
      $.getJSON(BASE_URL + '/admin/crawling/status', function(data) {
        lastData = data;
        var running = data.running;

        // Hero
        var heroDot  = document.getElementById('hero-dot');
        var heroIcon = document.getElementById('hero-icon');
        var heroText = document.getElementById('hero-status-text');
        var heroBadge = document.getElementById('hero-badge');
        var spinIcon = document.getElementById('spin-icon');

        if (running) {
          heroDot.style.cssText  = 'width:56px;height:56px;border-radius:50%;display:flex;align-items:center;justify-content:center;flex-shrink:0;background:rgba(34,197,94,0.12);border:2px solid rgba(34,197,94,0.4);transition:all 0.5s;';
          heroIcon.className     = 'bi bi-activity text-2xl';
          heroIcon.style.color   = '#22c55e';
          heroText.textContent   = '실행 중';
          heroText.style.color   = '#22c55e';
          heroBadge.textContent  = 'RUNNING';
          heroBadge.style.cssText = 'background:rgba(34,197,94,0.15);color:#22c55e;border:1px solid rgba(34,197,94,0.3);padding:4px 12px;border-radius:9999px;font-size:11px;font-weight:700;';
          spinIcon.style.animation = 'spin 1s linear infinite';
          document.getElementById('trigger-btn').disabled = true;
          // Current run dot
          document.getElementById('current-run-dot').style.background = '#22c55e';
        } else {
          heroDot.style.cssText  = 'width:56px;height:56px;border-radius:50%;display:flex;align-items:center;justify-content:center;flex-shrink:0;background:rgba(148,163,184,0.08);border:2px solid rgba(148,163,184,0.15);transition:all 0.5s;';
          heroIcon.className     = 'bi bi-pause-circle text-2xl';
          heroIcon.style.color   = '#94A3B8';
          heroText.textContent   = '대기 중';
          heroText.style.color   = '#F8FAFC';
          heroBadge.textContent  = 'IDLE';
          heroBadge.style.cssText = 'background:rgba(148,163,184,0.1);color:#94A3B8;border:1px solid rgba(148,163,184,0.2);padding:4px 12px;border-radius:9999px;font-size:11px;font-weight:700;';
          spinIcon.style.animation = '';
          document.getElementById('trigger-btn').disabled = false;
          document.getElementById('current-run-dot').style.background = '#475569';
          stopLiveTimer();
        }

        document.getElementById('hero-finished').textContent = data.finishedAt || '-';

        // Stepper
        renderStepper(running, data.genreIndex || 0, data.genreTotal || 4);

        // Current run card
        document.getElementById('crawlingType').textContent = data.crawlingType || '-';
        document.getElementById('startedAt').textContent    = data.startedAt   || '-';

        if (running && data.startedAtEpoch > 0) {
          startLiveTimer(data.startedAtEpoch, data.lastDurationSeconds || 0, data.genreIndex || 0, data.genreTotal || 4);
        }

        // Last run card
        document.getElementById('finishedAt').textContent  = data.finishedAt  || '-';
        document.getElementById('lastDuration').textContent = data.lastDuration || '-';
        var lastSec  = data.lastDurationSeconds || 0;
        var total    = data.genreTotal > 0 ? data.genreTotal : 4;
        var avgEl    = document.getElementById('perGenreAvg');
        if (lastSec > 0) {
          avgEl.textContent = formatSeconds(Math.round(lastSec / total)) + '/장르';
        } else {
          avgEl.textContent = '-';
        }

        // Config badges
        renderConfigBadge('startup-badge',  data.startupEnabled);
        renderConfigBadge('schedule-badge', data.scheduleEnabled);
      });
    }

    // ── Manual trigger ────────────────────────────────────────
    function triggerCrawling() {
      var btn = document.getElementById('trigger-btn');
      btn.disabled = true;
      btn.innerHTML = '<i class="bi bi-hourglass-split text-base"></i> 시작 중...';
      fetch(BASE_URL + '/admin/crawling/trigger', { method: 'POST' })
        .then(function(r) { return r.json(); })
        .then(function(res) {
          if (res.success) {
            fetchStatus();
          } else {
            alert(res.message);
            btn.disabled = false;
            btn.innerHTML = '<i class="bi bi-play-circle-fill text-base"></i> 수동 실행';
          }
        })
        .catch(function() {
          btn.disabled = false;
          btn.innerHTML = '<i class="bi bi-play-circle-fill text-base"></i> 수동 실행';
        });
    }

    // ── Init ──────────────────────────────────────────────────
    renderStepper(false, 0, 4); // initial empty stepper
    fetchStatus();
    setInterval(fetchStatus, 5000);
  </script>
</body>
</html>
