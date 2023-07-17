<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WEIVER - 커뮤니티 메인 페이지</title>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"
        integrity="sha384-fbbOQedDUMZZ5KreZpsbe1LCZPVmfTnH7ois6mU1QK+m14rQ1l2bGBq41eYeM/fS"
        crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

    <!-- SWIPER 외부 라이브러리 연결-->
    <link rel="stylesheet" href="https://unpkg.com/swiper@8/swiper-bundle.min.css" />
    <script src="https://unpkg.com/swiper@8/swiper-bundle.min.js"></script>
    <script src="../js/swiper.js"></script>

    <!--css 연결-->
    <link rel="stylesheet" href="/css/community.css">
    <link rel="stylesheet" href="/css/searchAll.css">
    <link rel="stylesheet" href="/css/swiper.css">
    <link rel="stylesheet" href="../css/public.css">

    <style>
        /* 여기에 추가적인 CSS 스타일 작성 가능 */
    </style>
</head>

<body>
    <div class="backgroudBox">
        <header>
            <img src="/img/logo.png" alt="logo" height="70" width="300" />
        </header>
        <div class="pageName" style="margin-bottom: 15px;">커뮤니티</div>
        <div>
            <form class="communittySearch" action="/community/search" method="get">
			    <input type="text" name="keyword">
			    <button type="submit">검색</button>
			</form>

        </div>
        <p style="font-weight:bold; font-size: 17px;">인기글🔥</p>
        <div class="popular_community">
            <div class="swiper-container">
                <div class="swiper-wrapper">
                    <div class="swiper-slide">
                        <div class="card-container">
                            <c:forEach var="card" items="${bestPost}">
                            <a href="/community/${card.id}">
                                <div class="card">
                                    <div class="card-header">
                                        <h3 class="card-title">${card.title}</h3>
                                    </div>
                                    <div class="card-footer">
                                        <span class="author">${card.user.nickname}</span>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        </a>
                    </div>
                    <div class="swiper-slide">
                        <div class="card-container">
                            <c:forEach var="card" items="${bestPost}">
                           		<a href="/community/${card.id}">
                                <div class="card">
                                    <div class="card-header">
                                        <h3 class="card-title">${card.title}</h3>
                                    </div>
                                    <div class="card-footer">
                                        <span class="author">${card.user.nickname}</span>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        </a>
                    </div>
                    <div class="swiper-slide">
                        <div class="card-container">
                            <c:forEach var="card" items="${bestPost}">
                                <a href="/community/${card.id}">
                                <div class="card">
                                    <div class="card-header">
                                        <h3 class="card-title">${card.title}</h3>
                                    </div>
                                    <div class="card-footer">
                                        <span class="author">${card.user.nickname}</span>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        </a>
                    </div>
                </div>
                <!-- Add Pagination -->
                <div class="swiper-pagination"></div>
                <!-- Add Navigation -->
                <div class="swiper-button-next"></div>
                <div class="swiper-button-prev"></div>
            </div>
        </div>

        <hr style="margin-top: 22px; margin-bottom: 22px; color: #D4D9E1;">

        <p style="font-weight:bold; font-size: 17px; margin-bottom: 12px;">카테고리</p>
        <div>
            <div class="btnGroup">
                <div class="categoryGroup">
                    <button style="background-color: #4263EB;" onclick="showPostList('전체', this)">전체</button>
                    <button style="background-color: #466093;" onclick="showPostList('리뷰', this)">리뷰</button>
                    <button style="background-color: #466093;" onclick="showPostList('잡담', this)">잡담</button>
                </div>
                <button class="writeBtn" onclick="checkLogin()">글 작성하기</button>
            </div>
            <div class="postAndUserInfo">
                <div id="postListAll" class="postList">
                    <c:forEach var="post" items="${post}">
                    <a href="/community/${post.id}">
                        <div class="postWrap-main">
							    <p class="post-nickname">${post.user.nickname}</p>
							    <h2 class="post-title">${post.title}</h2>
							    <p class="post-content">${post.content}</p>
							    <img src="${post.images}" alt="게시글 이미지" class="post-image">
                            <div class="iconGroup">
                                <div>
                                    <i class="bi-eye"></i>
                                    <span>${post.viewed}</span>
                                </div>
                                <div>
                                    <i class="bi-suit-heart" onclick="changeHeartIcon(this)"></i>
                                    <span>${post.postlikes.size()}</span>
                                </div>
                                <div>
                                    <i class="bi-chat"></i>
                                </div>
                            </div>
                        </div>
                        </a>
                    </c:forEach>
                </div>
                <div id="postListReview" class="postList" style="display: none;">
                    <c:forEach var="post" items="${post}">
                        <c:if test="${post.type == 'Review'}">
                        <a href="/community/${post.id}">
                            <div class="postWrap-main">
							    <p class="post-nickname">${post.user.nickname}</p>
							    <h2 class="post-title">${post.title}</h2>
							    <p class="post-content">${post.content}</p>
							    <img src="${post.images}" alt="게시글 이미지" class="post-image">
                                <div class="iconGroup">
                                    <div>
                                        <i class="bi-eye"></i>
                                        <span>${post.viewed}</span>
                                    </div>
                                    <div>
                                        <i class="bi-suit-heart" onclick="changeHeartIcon(this)"></i>
                                        <span>${post.postlikes.size()}</span>
                                    </div>
                                </div>
                            </div>
                             </a>
                        </c:if>
                    </c:forEach>
                </div>
                <div id="postListChat" class="postList" style="display: none;">
                    <c:forEach var="post" items="${post}">
                        <c:if test="${post.type == 'Chat'}">
                        <a href="/community/${post.id}">
                            <div class="postWrap-main">
							    <p class="post-nickname">${post.user.nickname}</p>
							    <h2 class="post-title">${post.title}</h2>
							    <p class="post-content">${post.content}</p>
							    <img src="${post.images}" alt="게시글 이미지" class="post-image">
                                <div class="iconGroup">
                                    <div>
                                        <i class="bi-eye"></i>
                                        <span>${post.viewed}</span>
                                    </div>
                                    <div>
                                        <i class="bi-suit-heart" onclick="changeHeartIcon(this)"></i>
                                        <span>${post.postlikes.size()}</span>
                                    </div>
                                </div>
                            </div>
                            </a>
                        </c:if>
                    </c:forEach>
                </div>
                <div class="sideGroup">
                    <div class="userInfoAndLoginBtn">
                        <c:choose>
                            <c:when test="${empty user}">
                                <button class="loginBtn" onClick = '#'>로그인</button>
                            </c:when>
                            <c:otherwise>
                                <div class="userInfo">
                                    <p class="userInfoID">${user.nickname}</p>
                                    <div class="myWrited">
                                        <div class="myPost">
                                            <p>내가 쓴 글</p>
                                            <p><a href="#" style="text-decoration: none;">링크1</a></p>
                                        </div>
                                        <div class="myComment">
                                            <p>내가 쓴 댓글</p>
                                            <p><a href="#" style="text-decoration: none;">링크2</a></p>
                                        </div>
                                    </div>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <i class="bi bi-arrow-up-circle"></i>
                </div>
            </div>
        </div>
    </div>

    <footer>&copy; Weiver 2023 All Rights Reserved</footer>
    <nav>
        <a href="#"><i class="bi bi-house-door-fill"></i>
            <div>HOME</div>
        </a>
        <a href="#"><i class="bi bi-chat-dots-fill"></i>
            <div>COMMUNITY</div>
        </a>
        <a href="#"><i class="bi bi-person-fill"></i>
            <div>MY PAGE</div>
        </a>
    </nav>

    <script>
        function showPostList(category, button) {
            var postListAll = document.getElementById("postListAll");
            var postListReview = document.getElementById("postListReview");
            var postListChat = document.getElementById("postListChat");

            if (category === '전체') {
                postListAll.style.display = "block";
                postListReview.style.display = "none";
                postListChat.style.display = "none";
            } else if (category === '리뷰') {
                postListAll.style.display = "none";
                postListReview.style.display = "block";
                postListChat.style.display = "none";
            } else if (category === '잡담') {
                postListAll.style.display = "none";
                postListReview.style.display = "none";
                postListChat.style.display = "block";
            }

            // 버튼 스타일 변경
            var buttons = document.querySelectorAll(".categoryGroup button");
            buttons.forEach(function (btn) {
                btn.style.backgroundColor = "#466093";
            });
            button.style.backgroundColor = "#4263EB";
        }

        function changeHeartIcon(icon) {
            icon.className = "bi bi-heart-fill";
        }
    </script>

</body>

</html>
