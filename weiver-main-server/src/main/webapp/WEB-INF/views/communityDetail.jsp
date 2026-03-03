<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="config.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>WIEVER - ${posts.title}</title>

    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
      tailwind.config = {
        theme: {
          extend: {
            colors: {
              'stage-primary': '#BE123C',
              'stage-secondary': '#FBBF24',
              'stage-bg': '#0F172A',
              'stage-surface': '#1E293B',
              'stage-text': '#F8FAFC',
              'stage-text-sub': '#94A3B8',
            },
            fontFamily: {
              sans: ['Pretendard', 'sans-serif'],
              serif: ['Playfair Display', 'serif'],
            },
          }
        }
      }
    </script>

    <!-- Fonts & Icons -->
    <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.gh/orioncactus/pretendard@v1.3.8/dist/web/static/pretendard.css" />
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

    <!-- JS -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <style>
      .glass-nav {
        background: rgba(15, 23, 42, 0.7);
        backdrop-filter: blur(12px);
        -webkit-backdrop-filter: blur(12px);
        border-bottom: 1px solid rgba(255, 255, 255, 0.1);
      }
      .post-content-area {
        line-height: 1.8;
        letter-spacing: -0.01em;
      }
      .comment-card {
        background: rgba(30, 41, 59, 0.4);
        border: 1px solid rgba(255, 255, 255, 0.05);
      }
      .rereply-card {
        background: rgba(30, 41, 59, 0.2);
        border-left: 2px solid var(--stage-primary);
      }
    </style>
</head>

<body class="bg-stage-bg text-stage-text font-sans pb-32">

  <!-- Header -->
  <header class="fixed top-0 left-0 w-full z-50 glass-nav">
    <div class="max-w-7xl mx-auto px-4 h-16 flex items-center justify-between">
      <a href="${baseURL}/community" class="text-2xl hover:text-stage-secondary transition-colors">
        <i class="bi bi-chevron-left"></i>
      </a>
      <span class="text-xl font-serif text-stage-primary tracking-tighter">WIEVER</span>
      <div class="w-8"></div>
    </div>
  </header>

  <main class="max-w-4xl mx-auto px-4 pt-24 space-y-8">
    
    <!-- Post Article -->
    <article class="space-y-6">
      <!-- Article Header -->
      <div class="space-y-4">
        <div class="flex items-center gap-2">
          <span class="px-2 py-0.5 rounded bg-stage-primary/20 text-[10px] font-bold text-stage-primary uppercase tracking-wider">${posts.type == 'Review' ? 'REVIEW' : 'CHAT'}</span>
        </div>
        <h1 class="text-3xl md:text-4xl font-bold leading-tight">${posts.title}</h1>
        <div class="flex items-center justify-between py-4 border-y border-slate-800 text-sm">
          <div class="flex items-center gap-3">
            <div class="w-8 h-8 rounded-full bg-slate-800 flex items-center justify-center border border-slate-700">
              <i class="bi bi-person text-lg text-stage-text-sub"></i>
            </div>
            <span class="font-bold">@${posts.user.nickname}</span>
          </div>
          <div class="flex items-center gap-4 text-stage-text-sub text-xs">
            <span><i class="bi bi-eye mr-1"></i> ${posts.viewed}</span>
            <span><i class="bi bi-chat-dots mr-1"></i> ${reply.size()}</span>
          </div>
        </div>
      </div>

      <!-- Linked Musical (Optional) -->
      <c:if test="${posts.type eq 'Review'}">
        <div class="bg-stage-surface/50 border border-slate-700 p-4 rounded-2xl flex items-center gap-4">
          <img src="${reviews.musical.posterImage}" class="w-16 aspect-[3/4] object-cover rounded-lg shadow-lg" alt="poster">
          <div class="flex-1">
            <p class="text-[10px] text-stage-secondary font-bold uppercase tracking-widest mb-1">Related Musical</p>
            <h4 class="font-bold text-lg leading-tight mb-1">${reviews.musical.title}</h4>
            <p class="text-xs text-stage-text-sub">${reviews.musical.theater}</p>
          </div>
          <a href="${baseURL}/musicalDetail/${reviews.musical.id}" class="text-xs font-bold hover:text-stage-secondary underline underline-offset-4 decoration-slate-700 transition-colors">상세보기</a>
        </div>
      </c:if>

      <!-- Article Body -->
      <div class="post-content-area text-lg whitespace-pre-wrap py-6">
        ${posts.content}
      </div>

      <c:if test="${not empty posts.image}">
        <div class="rounded-3xl overflow-hidden border border-slate-800 shadow-2xl">
          <img src="${posts.image}" class="w-full h-auto" alt="post content">
        </div>
      </c:if>

      <!-- Interaction Bar -->
      <div class="flex items-center justify-center gap-6 py-10">
        <button onclick="handleButtonClick(${posts.id})" class="flex flex-col items-center gap-2 group transition-all active:scale-90">
          <div class="w-16 h-16 rounded-full border-2 border-slate-800 flex items-center justify-center group-hover:border-stage-primary transition-all shadow-xl">
            <i class="bi ${not empty postLikeCheck ? 'bi-heart-fill text-stage-primary' : 'bi-heart'} text-2xl icon"></i>
          </div>
          <span class="text-[10px] font-bold text-stage-text-sub uppercase tracking-widest">LIKE</span>
        </button>
      </div>

      <!-- Post Controls (Owner Only) -->
      <c:if test="${user != null && user == posts.user.id}">
        <div class="flex justify-end gap-3 pb-10 border-b border-slate-800">
          <a href="${baseURL}/community/update/${posts.id}" class="text-xs font-bold px-4 py-2 rounded-lg bg-slate-800 hover:bg-slate-700 transition-colors">수정하기</a>
          <button onclick="deletePost(${posts.id})" class="text-xs font-bold px-4 py-2 rounded-lg bg-rose-900/20 text-rose-500 hover:bg-rose-900/40 transition-colors">삭제하기</button>
        </div>
      </c:if>
    </article>

    <!-- Comments Section -->
    <section class="space-y-8 pt-10">
      <h3 class="text-xl font-bold flex items-center gap-2">
        댓글 <span class="text-stage-primary">${reply.size()}</span>
      </h3>

      <div class="space-y-6">
        <c:forEach var="replyItem" items="${reply}">
          <div class="space-y-4">
            <!-- Reply Card -->
            <div class="comment-card p-5 rounded-2xl space-y-3" data-comment-id="${replyItem.id}">
              <div class="flex justify-between items-center">
                <span class="font-bold text-sm text-stage-secondary">@${replyItem.user.nickname}</span>
                <c:if test="${user != null && user == replyItem.user.id}">
                  <div class="flex gap-2 text-[10px] font-bold text-stage-text-sub uppercase tracking-wider">
                    <button class="commentEditBtn hover:text-stage-text">EDIT</button>
                    <button onclick="deleteReply(${replyItem.id})" class="text-rose-500 hover:text-rose-400">DELETE</button>
                  </div>
                </c:if>
              </div>
              <p class="text-sm leading-relaxed" id="commentContent_${replyItem.id}">${replyItem.content}</p>
              <div class="flex justify-end">
                <a href="${baseURL}/community/${posts.id}/reply/${replyItem.id}" class="text-[10px] font-bold text-stage-text-sub hover:text-stage-secondary underline decoration-slate-700 underline-offset-4">REPLY</a>
              </div>
            </div>

            <!-- Rereply Loop -->
            <div class="pl-6 space-y-4">
              <c:forEach var="rereplyItem" items="${rereply}">
                <c:if test="${rereplyItem.reply.id == replyItem.id}">
                  <div class="rereply-card p-4 rounded-xl space-y-2" data-recomment-id="${rereplyItem.id}">
                    <div class="flex justify-between items-center">
                      <span class="font-bold text-xs text-stage-primary/80">@${rereplyItem.user.nickname}</span>
                      <c:if test="${user != null && user == rereplyItem.user.id}">
                        <div class="flex gap-2 text-[10px] font-bold text-stage-text-sub uppercase">
                          <button class="recommentEditBtn hover:text-stage-text">EDIT</button>
                          <button onclick="deleteRereply(${rereplyItem.id})" class="text-rose-500">DELETE</button>
                        </div>
                      </c:if>
                    </div>
                    <p class="text-xs leading-relaxed" id="recommentContent_${rereplyItem.id}">${rereplyItem.content}</p>
                  </div>
                </c:if>
              </c:forEach>
            </div>
          </div>
        </c:forEach>
      </div>
    </section>

  </main>

  <!-- Comment Input (Fixed Bottom) -->
  <div class="fixed bottom-16 left-0 w-full glass-nav px-4 py-4 z-40 border-t border-slate-800">
    <div class="max-w-4xl mx-auto">
      <form action="/community/insert/reply/${posts.id}" method="post" onsubmit="return checkLogin()" class="flex gap-3">
        <input name="content" type="text" placeholder="작품에 대한 생각을 나눠보세요..." required
          class="flex-1 bg-slate-900/50 border border-slate-700 rounded-xl py-3 px-4 focus:outline-none focus:border-stage-secondary transition-all text-sm">
        <button type="submit" class="bg-stage-primary hover:bg-rose-700 text-white px-6 rounded-xl font-bold text-sm transition-all shadow-lg shadow-rose-900/20 shrink-0">
          등록
        </button>
      </form>
    </div>
  </div>

  <!-- Bottom Nav -->
  <nav class="fixed bottom-0 left-0 w-full glass-nav z-50">
    <div class="max-w-md mx-auto px-6 h-16 flex items-center justify-between text-stage-text-sub text-[10px] font-bold">
      <a href="${baseURL}/main" class="flex flex-col items-center gap-1 hover:text-stage-text transition-colors">
        <i class="bi bi-house-door text-xl"></i>
        <span>HOME</span>
      </a>
      <a href="${baseURL}/community" class="flex flex-col items-center gap-1 text-stage-primary">
        <i class="bi bi-chat-dots-fill text-xl"></i>
        <span>COMMUNITY</span>
      </a>
      <a href="${baseURL}/mypage/myinfo" class="flex flex-col items-center gap-1 hover:text-stage-text transition-colors">
        <i class="bi bi-person text-xl"></i>
        <span>MY PAGE</span>
      </a>
    </div>
  </nav>

  <!-- JS Scripts (Keep original logic but adapt to new classes if needed) -->
  <script>
    $(function() {
      $('.commentEditBtn').click(function() {
        var commentId = $(this).closest('.comment-card').data('comment-id');
        var txt = $('#commentContent_' + commentId).text();
        $('#commentContent_' + commentId).html(
          "<textarea rows='3' id='textarea1_"+commentId+"' class='w-full bg-slate-800 p-3 rounded-lg mt-2 text-sm focus:outline-none focus:border-stage-secondary border border-slate-700'>"+txt+"</textarea>"
        );
      });

      $('.recommentEditBtn').click(function() {
        var recommentId = $(this).closest('.rereply-card').data('recomment-id');
        var txt = $('#recommentContent_' + recommentId).text();
        $('#recommentContent_' + recommentId).html(
          "<textarea rows='3' id='textarea2_"+recommentId+"' class='w-full bg-slate-800 p-3 rounded-lg mt-2 text-xs focus:outline-none focus:border-stage-secondary border border-slate-700'>"+txt+"</textarea>"
        );
      });

      $(document).on('blur', 'textarea[id^="textarea1_"]', function() {
        var commentId = $(this).attr('id').split('_')[1];
        var editedContent = $(this).val();
        $.ajax({
          url: '${baseURL}/community/update/reply/' + commentId,
          type: 'POST',
          data: { id: commentId, content: editedContent },
          success: function() { $('#commentContent_' + commentId).html(editedContent); }
        });
      });

      $(document).on('blur', 'textarea[id^="textarea2_"]', function() {
        var recommentId = $(this).attr('id').split('_')[1];
        var editedContent = $(this).val();
        $.ajax({
          url: '${baseURL}/community/update/rereply/' + recommentId,
          type: 'POST',
          data: { id: recommentId, content: editedContent },
          success: function() { $('#recommentContent_' + recommentId).html(editedContent); }
        });
      });
    });

    function deletePost(postsId) {
      if (confirm("글을 삭제하시겠습니까?")) {
        $.ajax({
          url: '${baseURL}/community/delete/post/' + postsId,
          type: 'DELETE',
          success: function() { window.location.href = '${baseURL}/community'; }
        });
      }
    }

    function deleteReply(commentId) {
      if (confirm("댓글을 삭제하시겠습니까?")) {
        $.ajax({
          url: '${baseURL}/community/delete/reply/' + commentId,
          type: 'DELETE',
          success: function() { location.reload(); }
        });
      }
    }

    function deleteRereply(recommentId) {
      if (confirm("대댓글을 삭제하시겠습니까?")) {
        $.ajax({
          url: '${baseURL}/community/delete/rereply/' + recommentId,
          type: 'DELETE',
          success: function() { location.reload(); }
        });
      }
    }

    function handleButtonClick(postsId) {
      $.ajax({
        type: 'GET',
        url: '${baseURL}/community/postlike/' + postsId,
        success: function () {
          const icon = $('.icon');
          icon.toggleClass('bi-heart bi-heart-fill text-stage-primary');
        }
      });
    }

    function checkLogin() {
      var userId = "${sessionScope.userId}";
      if (!userId) { alert("로그인해주세요."); return false; }
      return true;
    }
  </script>

</body>
</html>
