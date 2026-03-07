<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="config.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
  <title>WIEVER - 글 작성</title>

  <script src="https://cdn.tailwindcss.com"></script>
  <script>
    tailwind.config = {
      theme: {
        extend: {
          colors: {
              'stage-gold-glow': '#FFD700',
            'stage-primary': '#BE123C',
            'stage-secondary': '#D4AF37',
            'stage-bg': '#0a0a0a',
            'stage-surface': '#1a1a1a',
            'stage-text': '#F8FAFC',
            'stage-text-sub': '#a1a1aa',
          },
          fontFamily: {
            sans: ['Pretendard', 'sans-serif'],
            serif: ['Cinzel', 'Playfair Display', 'serif'],
          },
        }
      }
    }
  </script>

  <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.8/dist/web/static/pretendard.css" />
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&family=Cinzel:wght@600;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

  <style>
    .glass-nav {
      background: rgba(0, 0, 0, 0.4);
      backdrop-filter: blur(12px);
      -webkit-backdrop-filter: blur(12px);
      border-bottom: 1px solid rgba(212, 175, 55, 0.2);
    }
    .input-base {
      width: 100%;
      background: rgba(10, 10, 10, 0.5);
      border: 1px solid rgb(51, 65, 85);
      border-radius: 0.75rem;
      padding: 1rem;
      color: #F8FAFC;
      outline: none;
      transition: border-color 0.2s;
    }
    .input-base:focus {
      border-color: #FBBF24;
    }
    .musical-item:hover {
      background: rgba(26, 26, 26, 0.8);
    }
  </style>
</head>

<body class="bg-stage-bg text-stage-text font-sans pb-24 min-h-screen" style="background: linear-gradient(180deg, #0f0f0f 0%, #000000 100%); min-height: 100vh;">

  <script type="text/javascript">
    var musicalsData = [
      <c:forEach var="musical" items="${musicals}">
        {
          id: '${musical.id}',
          title: `${musical.title.replace('\\',"")}`,
          theater: '${musical.theater}',
          posterImage: '${musical.posterImage}',
          stDate: '${musical.stDate}',
          edDate: '${musical.edDate}'
        },
      </c:forEach>
    ];

    function loadFile(input) {
      var file = input.files[0];
      var name = document.getElementById('fileName');
      name.textContent = file.name;
      var preview = document.getElementById('image-preview');
      preview.src = URL.createObjectURL(file);
      preview.classList.remove('hidden');
    }

    function handleMusicalItemClick(musicalId) {
      document.getElementById("searchBox").value = "";
      document.getElementById("searchBox").style.display = "none";
      document.getElementById("musicalInfoContainer").style.display = "none";

      var selectedMusical = musicalsData.find(function(m) { return m.id === musicalId; });
      if (selectedMusical) {
        document.getElementById("musicalDetailContainer").style.display = "flex";
        document.getElementById("selected-poster").src = selectedMusical.posterImage;
        document.getElementById("selected-title").textContent = selectedMusical.title;
        document.getElementById("selected-theater").textContent = selectedMusical.theater;
        document.getElementById("musicalIdInput").value = musicalId;

        // Re-show search box for changing selection
        document.getElementById("searchBox").style.display = "block";
      }
    }

    function handleSearchBoxChange() {
      var searchTerm = document.getElementById("searchBox").value;
      var filteredMusicals = musicalsData.filter(function(m) {
        return m.title.toLowerCase().includes(searchTerm.toLowerCase());
      });

      var container = document.getElementById("musicalInfoContainer");
      container.innerHTML = "";

      if (searchTerm.length === 0) {
        container.style.display = "none";
        return;
      }

      filteredMusicals.forEach(function(musical) {
        var item = document.createElement("div");
        item.className = "musical-item flex items-center gap-3 p-3 rounded-xl cursor-pointer transition-all";
        item.innerHTML = '<img src="' + musical.posterImage + '" class="w-12 h-16 object-cover rounded-lg flex-shrink-0" alt="poster">' +
          '<div><p class="font-bold text-sm">' + musical.title + '</p><p class="text-xs text-stage-text-sub">' + musical.theater + '</p></div>';
        item.addEventListener("click", function() { handleMusicalItemClick(musical.id); });
        container.appendChild(item);
      });

      container.style.display = "block";
    }

    function postTypeChange() {
      var formType = document.getElementById("selectFormType").value;
      var reviewForm = document.getElementById("reviewForm");
      var reviewPerformance = document.getElementById("reviewPerformance");
      if (formType === 'Review') {
        reviewForm.style.display = "block";
        reviewPerformance.required = true;
      } else {
        reviewForm.style.display = "none";
        reviewPerformance.required = false;
      }
    }
  </script>

  <!-- Header -->
  <header class="fixed top-0 left-0 w-full z-50 glass-nav">
    <div class="max-w-7xl mx-auto px-4 h-16 flex items-center justify-between">
      <a href="${baseURL}/community" class="text-2xl hover:text-stage-secondary transition-colors">
        <i class="bi bi-chevron-left"></i>
      </a>
      <span class="text-xl font-serif text-stage-secondary tracking-tighter">WIEVER</span>
      <div class="w-8"></div>
    </div>
  </header>

  <main class="max-w-2xl mx-auto px-4 pt-24 pb-10">

    <!-- Page Title -->
    <div class="mb-8">
      <span class="text-stage-secondary font-bold tracking-[0.2em] uppercase text-xs">Community</span>
      <h1 class="text-3xl font-bold mt-1">글 작성하기</h1>
    </div>

    <form action="${baseURL}/community/board" method="post" enctype="multipart/form-data" class="space-y-6">

      <!-- Post Type Select -->
      <div class="space-y-2">
        <label class="text-xs font-bold text-stage-text-sub uppercase tracking-widest ml-1">글 종류</label>
        <div class="relative">
          <select id="selectFormType" name="type" onchange="postTypeChange()"
            class="w-full bg-black/60 border border-white/20 rounded-xl py-4 px-4 focus:outline-none focus:border-stage-secondary transition-all appearance-none text-stage-text">
            <option value="select" disabled selected>글 종류를 선택하세요</option>
            <option value="Chat">잡담</option>
            <option value="Review">리뷰</option>
          </select>
          <i class="bi bi-chevron-down absolute right-4 top-1/2 -translate-y-1/2 text-stage-text-sub pointer-events-none"></i>
        </div>
      </div>

      <!-- Musical Search (Review only) -->
      <div id="reviewForm" style="display: none" class="space-y-3">
        <label class="text-xs font-bold text-stage-text-sub uppercase tracking-widest ml-1">작품명</label>
        <div class="relative">
          <input type="text" id="searchBox" placeholder="뮤지컬 제목을 검색하세요..." autocomplete="off" oninput="handleSearchBoxChange()"
            class="w-full bg-black/60 border border-white/20 rounded-xl py-4 px-4 pl-10 focus:outline-none focus:border-stage-secondary transition-all placeholder-stage-text-sub">
          <i class="bi bi-search absolute left-4 top-1/2 -translate-y-1/2 text-stage-text-sub"></i>
        </div>
        <input type="hidden" name="musicalId" id="reviewPerformance">

        <!-- Search Results Dropdown -->
        <div id="musicalInfoContainer" class="bg-stage-surface border border-white/20 rounded-2xl p-2 space-y-1 max-h-64 overflow-y-auto" style="display: none"></div>

        <!-- Selected Musical Preview -->
        <div id="musicalDetailContainer" class="hidden bg-stage-surface/50 border border-white/20 p-4 rounded-2xl items-center gap-4">
          <img id="selected-poster" src="" class="w-16 aspect-[3/4] object-cover rounded-lg shadow-lg" alt="poster">
          <div>
            <p class="text-[10px] text-stage-secondary font-bold uppercase tracking-widest mb-1">Selected</p>
            <h4 id="selected-title" class="font-bold text-lg leading-tight"></h4>
            <p id="selected-theater" class="text-xs text-stage-text-sub"></p>
          </div>
        </div>
        <input type="hidden" name="musicalId" id="musicalIdInput" value="">
      </div>

      <!-- Title -->
      <div class="space-y-2">
        <label class="text-xs font-bold text-stage-text-sub uppercase tracking-widest ml-1">제목</label>
        <input type="text" name="title" required placeholder="글 제목을 입력하세요"
          class="w-full bg-black/60 border border-white/20 rounded-xl py-4 px-4 focus:outline-none focus:border-stage-secondary transition-all placeholder-stage-text-sub">
      </div>

      <!-- Content -->
      <div class="space-y-2">
        <label class="text-xs font-bold text-stage-text-sub uppercase tracking-widest ml-1">내용</label>
        <textarea name="content" id="editor" rows="10" placeholder="내용을 입력하세요..."
          class="w-full bg-black/60 border border-white/20 rounded-xl py-4 px-4 focus:outline-none focus:border-stage-secondary transition-all placeholder-stage-text-sub resize-none leading-relaxed"></textarea>
      </div>

      <!-- Image Upload -->
      <div class="space-y-2">
        <label class="text-xs font-bold text-stage-text-sub uppercase tracking-widest ml-1">이미지 첨부</label>
        <label for="imageUpload" class="flex items-center gap-4 bg-black/60 border border-white/20 border-dashed rounded-xl py-5 px-4 cursor-pointer hover:border-stage-secondary transition-all">
          <i class="bi bi-image text-2xl text-stage-text-sub"></i>
          <div>
            <p id="fileName" class="text-sm font-medium text-stage-text-sub">클릭하여 이미지를 선택하세요</p>
            <p class="text-[10px] text-stage-text-sub/60">PNG, JPG, GIF 지원</p>
          </div>
        </label>
        <input type="file" id="imageUpload" name="file" accept="image/*" required class="hidden" onchange="loadFile(this)">
        <img id="image-preview" src="" class="hidden w-full rounded-2xl mt-3 border border-white/20" alt="preview">
      </div>

      <!-- Submit -->
      <button type="submit" class="w-full bg-stage-primary hover:bg-rose-700 text-white font-bold py-4 rounded-xl shadow-lg shadow-rose-900/20 transition-all transform active:scale-[0.98]">
        <i class="bi bi-pencil-square mr-2"></i>작성하기
      </button>

    </form>
  </main>

  <!-- Bottom Nav -->
  <nav class="fixed bottom-0 left-0 w-full glass-nav z-50">
    <div class="max-w-md mx-auto px-6 h-16 flex items-center justify-between text-stage-text-sub text-[10px] font-bold">
      <a href="${baseURL}/main" class="flex flex-col items-center gap-1 hover:text-stage-text transition-colors">
        <i class="bi bi-house-door text-xl"></i>
        <span>HOME</span>
      </a>
      <a href="${baseURL}/community" class="flex flex-col items-center gap-1 text-stage-secondary">
        <i class="bi bi-chat-dots-fill text-xl"></i>
        <span>COMMUNITY</span>
      </a>
      <a href="${baseURL}/mypage/myinfo" class="flex flex-col items-center gap-1 hover:text-stage-text transition-colors">
        <i class="bi bi-person text-xl"></i>
        <span>MY PAGE</span>
      </a>
    </div>
  </nav>

  <footer class="mt-10 mb-10 text-center text-[10px] text-center">
    <p class="text-[10px] font-serif font-bold tracking-[0.4em] uppercase text-stage-secondary">&copy; Weiver 2023. THE STAGE IS YOURS.</p>
  </footer>

</body>
</html>
