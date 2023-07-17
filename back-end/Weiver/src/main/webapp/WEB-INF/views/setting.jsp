<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>setting</title>

    <!--css 연결-->
    <link rel="stylesheet" href="/css/user.css">
    <link rel="stylesheet" href="/css/public.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>

<body>
    <!-- header -->
    <header>
        <img src="/img/logo.png" alt="logo" height="70" width="300">
    
        <!-- 타이틀 -->
        <div class="title">
            <div class="back">
                <a href="javascript:history.back()"><i class="bi bi-chevron-left"></i></a>
            </div>
            <div class="name">설정</div>
        </div>
    </header>
    
    <div class="page">

        
        <!-- 카테고리(선택창) -->
        <div class="category">
            <div class="card">
                <a href="/">로그아웃</a>
            </div>
            <div class="card">
                <a href="/password">비밀번호 변경</a>
            </div>
            <div class="card">
                <a href="/">문의하기</a>
            </div>
            <div class="card">
                <a href="/">회원 탈퇴</a>
            </div>
        </div>
    </div>

    <!-- footer -->
    <footer>Copyright Weiver 2023 All Rights Reserved</footer>

    <!-- navibar -->
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
</body>
</html>