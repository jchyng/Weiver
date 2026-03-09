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

    <!-- Fonts & Icons -->
    <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.8/dist/web/static/pretendard.css" />
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&family=Cinzel:wght@600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

    <!-- JS -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <style>
      .glass-nav {
        background: rgba(0, 0, 0, 0.4);
        backdrop-filter: blur(12px);
        -webkit-backdrop-filter: blur(12px);
        border-bottom: 1px solid rgba(212, 175, 55, 0.2);
      }
      .post-content-area {
        line-height: 1.8;
        letter-spacing: -0.01em;
      }
      .comment-card {
        background: rgba(26, 26, 26, 0.4);
        border: 1px solid rgba(255, 255, 255, 0.05);
      }
      .rereply-card {
        background: rgba(26, 26, 26, 0.2);
        border-left: 2px solid var(--stage-primary);
      }
    </style>
</head>

<body class="bg-stage-bg text-stage-text font-sans pb-32" style="background: linear-gradient(180deg, #0f0f0f 0%, #000000 100%); min-height: 100vh;">

  <!-- Top Navigation -->
  <header class="fixed top-0 left-0 w-full z-[100] glass-nav">
    <div class="max-w-7xl mx-auto px-6 h-16 flex items-center justify-between">
      <div class="flex items-center gap-4 md:gap-8">
        <a href="javascript:history.back();" class="text-xl text-stage-secondary hover:text-stage-gold-glow transition-colors">
          <i class="bi bi-chevron-left"></i>
        </a>
        <a href="${baseURL}/" class="text-2xl font-serif font-bold text-stage-secondary tracking-tighter">WIEVER</a>
        <nav class="hidden md:flex items-center gap-6">
          <a href="${baseURL}/musical-search" class="font-serif text-sm text-stage-secondary hover:text-stage-gold-glow transition-colors">Musical DB</a>
          <a href="${baseURL}/community" class="font-serif text-sm text-stage-secondary hover:text-stage-gold-glow transition-colors">Community</a>
        </nav>
      </div>
      <div class="flex items-center gap-5 text-stage-secondary">
        <a href="${baseURL}/musical-search" class="hover:text-stage-gold-glow transition-colors">
          <i class="bi bi-search text-xl"></i>
        </a>
        <a href="${baseURL}/mypage/myinfo" class="hover:text-stage-gold-glow transition-colors">
          <i class="bi bi-person-circle text-xl"></i>
        </a>
      </div>
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
        <div class="flex items-center justify-between py-4 border-y border-white/10 text-sm">
          <div class="flex items-center gap-3">
            <div class="w-8 h-8 rounded-full bg-stage-surface flex items-center justify-center border border-white/20">
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
        <div class="bg-stage-surface/50 border border-white/20 p-4 rounded-2xl flex items-center gap-4">
          <img src="${reviews.musical.posterImage}" class="w-16 aspect-[3/4] object-cover rounded-lg shadow-lg" alt="poster">
          <div class="flex-1">
            <p class="text-[10px] text-stage-secondary font-bold uppercase tracking-widest mb-1">Related Musical</p>
            <h4 class="font-bold text-lg leading-tight mb-1">${reviews.musical.title}</h4>
            <p class="text-xs text-stage-text-sub">${reviews.musical.theater}</p>
          </div>
          <a href="${baseURL}/musical-detail/${reviews.musical.id}" class="text-xs font-bold hover:text-stage-secondary underline underline-offset-4 decoration-stage-secondary/50 transition-colors">상세보기</a>
        </div>
      </c:if>

      <!-- Article Body -->
      <div class="post-content-area text-lg whitespace-pre-wrap py-6">
        ${posts.content}
      </div>

      <c:if test="${not empty posts.image}">
        <div class="rounded-3xl overflow-hidden border border-white/10 shadow-2xl">
          <img src="${posts.image}" class="w-full h-auto" alt="post content">
        </div>
      </c:if>

      <!-- Interaction Bar -->
      <div class="flex items-center justify-center gap-6 py-10">
        <button onclick="handleButtonClick(${posts.id})" class="flex flex-col items-center gap-2 group transition-all active:scale-90">
          <div class="w-16 h-16 rounded-full border-2 border-white/10 flex items-center justify-center group-hover:border-stage-primary transition-all shadow-xl">
            <i class="bi ${not empty postLikeCheck ? 'bi-heart-fill text-stage-primary' : 'bi-heart'} text-2xl icon"></i>
          </div>
          <span class="text-[10px] font-bold text-stage-text-sub uppercase tracking-widest">LIKE</span>
        </button>
      </div>

      <!-- Post Controls (Owner Only) -->
      <c:if test="${user != null && user == posts.user.id}">
        <div class="flex justify-end gap-3 pb-10 border-b border-white/10">
          <a href="${baseURL}/community/update/${posts.id}" class="text-xs font-bold px-4 py-2 rounded-lg bg-stage-surface hover:bg-white/10 transition-colors">수정하기</a>
          <button onclick="deletePost(${posts.id})" class="text-xs font-bold px-4 py-2 rounded-lg bg-rose-900/20 text-rose-500 hover:bg-rose-900/40 transition-colors">삭제하기</button>
        </div>
      </c:if>

      <!-- Prev/Next Navigation -->
      <div class="grid grid-cols-1 md:grid-cols-2 gap-4 py-10 border-b border-white/10">
        <c:choose>
          <c:when test="${not empty prevPost}">
            <a href="${baseURL}/community/${prevPost.id}" class="group flex items-center gap-4 bg-stage-surface/30 hover:bg-stage-surface/50 p-4 rounded-2xl border border-white/5 transition-all">
              <i class="bi bi-chevron-left text-stage-secondary text-xl"></i>
              <div class="min-w-0">
                <p class="text-[10px] text-stage-text-sub font-bold uppercase tracking-widest mb-1">Previous Post</p>
                <h4 class="text-sm font-bold text-white truncate group-hover:text-stage-secondary transition-colors">${prevPost.title}</h4>
              </div>
            </a>
          </c:when>
          <c:otherwise>
            <div class="flex items-center gap-4 bg-stage-surface/10 p-4 rounded-2xl border border-white/5 opacity-50">
              <i class="bi bi-chevron-left text-xl"></i>
              <div>
                <p class="text-[10px] text-stage-text-sub font-bold uppercase tracking-widest mb-1">Previous Post</p>
                <h4 class="text-sm font-bold text-stage-text-sub">이전 게시글이 없습니다.</h4>
              </div>
            </div>
          </c:otherwise>
        </c:choose>

        <c:choose>
          <c:when test="${not empty nextPost}">
            <a href="${baseURL}/community/${nextPost.id}" class="group flex items-center justify-between gap-4 bg-stage-surface/30 hover:bg-stage-surface/50 p-4 rounded-2xl border border-white/5 transition-all text-right">
              <div class="min-w-0 flex-1">
                <p class="text-[10px] text-stage-text-sub font-bold uppercase tracking-widest mb-1">Next Post</p>
                <h4 class="text-sm font-bold text-white truncate group-hover:text-stage-secondary transition-colors">${nextPost.title}</h4>
              </div>
              <i class="bi bi-chevron-right text-stage-secondary text-xl"></i>
            </a>
          </c:when>
          <c:otherwise>
            <div class="flex items-center justify-between gap-4 bg-stage-surface/10 p-4 rounded-2xl border border-white/5 opacity-50 text-right">
              <div class="flex-1">
                <p class="text-[10px] text-stage-text-sub font-bold uppercase tracking-widest mb-1">Next Post</p>
                <h4 class="text-sm font-bold text-stage-text-sub">다음 게시글이 없습니다.</h4>
              </div>
              <i class="bi bi-chevron-right text-xl"></i>
            </div>
          </c:otherwise>
        </c:choose>
      </div>
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
                <a href="${baseURL}/community/${posts.id}/reply/${replyItem.id}" class="text-[10px] font-bold text-stage-text-sub hover:text-stage-secondary underline decoration-stage-secondary/50 underline-offset-4">REPLY</a>
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
  <div class="fixed bottom-0 left-0 w-full glass-nav px-4 py-4 z-40 border-t border-white/10">
    <div class="max-w-4xl mx-auto">
      <form action="/community/insert/reply/${posts.id}" method="post" onsubmit="return checkLogin()" class="flex gap-3">
        <input name="content" type="text" placeholder="작품에 대한 생각을 나눠보세요..." required
          class="flex-1 bg-black/60 border border-white/20 rounded-xl py-3 px-4 focus:outline-none focus:border-stage-secondary transition-all text-sm text-white">
        <button type="submit" class="bg-stage-primary hover:bg-rose-700 text-white px-6 rounded-xl font-bold text-sm transition-all shadow-lg shadow-rose-900/20 shrink-0">
          등록
        </button>
      </form>
    </div>
  </div>

  <footer class="mt-20 mb-24 text-center">
    <p class="text-[10px] font-serif font-bold tracking-[0.4em] uppercase text-stage-secondary">&copy; Weiver 2023. THE STAGE IS YOURS.</p>
  </footer>

  <!-- JS Scripts (Keep original logic but adapt to new classes if needed) -->
  <script>
    $(function() {
      $('.commentEditBtn').click(function() {
        var commentId = $(this).closest('.comment-card').data('comment-id');
        var txt = $('#commentContent_' + commentId).text();
        $('#commentContent_' + commentId).html(
          "<textarea rows='3' id='textarea1_"+commentId+"' class='w-full bg-stage-surface p-3 rounded-lg mt-2 text-sm focus:outline-none focus:border-stage-secondary border border-white/20'>"+txt+"</textarea>"
        );
      });

      $('.recommentEditBtn').click(function() {
        var recommentId = $(this).closest('.rereply-card').data('recomment-id');
        var txt = $('#recommentContent_' + recommentId).text();
        $('#recommentContent_' + recommentId).html(
          "<textarea rows='3' id='textarea2_"+recommentId+"' class='w-full bg-stage-surface p-3 rounded-lg mt-2 text-xs focus:outline-none focus:border-stage-secondary border border-white/20'>"+txt+"</textarea>"
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
