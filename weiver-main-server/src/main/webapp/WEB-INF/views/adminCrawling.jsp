<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="config.jsp" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <title>Admin - 크롤링 상태</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="../css/styles.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <script src="http://code.jquery.com/jquery-latest.js"></script>
    </head>
    <body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <a class="navbar-brand ps-3" href="${baseURL}/admin/main"><img src="../img/image-removebg-preview.png" width="200px" height="70px"></a>
            <ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">안녕하세요 ${sessionScope.adminName}님  <i class="fas fa-user fa-fw"></i></a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                        <li><hr class="dropdown-divider" /></li>
                        <li><a class="dropdown-item" href="${baseURL}/admin/logout">Logout</a></li>
                    </ul>
                </li>
            </ul>
        </nav>
        <div id="layoutSidenav">
            <div id="layoutSidenav_nav">
                <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                    <div class="sb-sidenav-menu">
                        <div class="nav">
                            <div class="sb-sidenav-menu-heading">데이터 관리</div>
                            <a class="nav-link" href="${baseURL}/admin/getAllActors">
                                <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>배우
                            </a>
                            <a class="nav-link" href="${baseURL}/admin/getAllMusicals">
                                <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>뮤지컬
                            </a>
                            <a class="nav-link" href="${baseURL}/admin/getAllUsers">
                                <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>유저
                            </a>
                            <a class="nav-link" href="${baseURL}/admin/getAllAdmins">
                                <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>관리자
                            </a>
                            <a class="nav-link" href="${baseURL}/admin/getAllPosts">
                                <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>게시글
                            </a>
                            <a class="nav-link" href="${baseURL}/admin/getAllInquirys">
                                <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>문의
                            </a>
                            <a class="nav-link active" href="${baseURL}/admin/crawling">
                                <div class="sb-nav-link-icon"><i class="fas fa-sync-alt"></i></div>크롤링 상태
                            </a>
                        </div>
                    </div>
                    <div class="sb-sidenav-footer">
                        <div class="small">Logged in as:</div>
                        ${sessionScope.adminId}
                    </div>
                </nav>
            </div>
            <div id="layoutSidenav_content">
                <main>
                    <div style="height:10px"></div>
                    <div class="container-fluid px-4">
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-sync-alt me-1"></i>
                                크롤링 상태
                                <span id="autoRefreshBadge" style="margin-left:10px; font-size:0.8em; color:#aaa;">5초마다 자동 갱신</span>
                            </div>
                            <div class="card-body">
                                <table style="width:100%; border-collapse:collapse;">
                                    <tbody>
                                        <tr style="border-bottom:1px solid #dee2e6;">
                                            <td style="padding:10px 16px; font-weight:bold; width:180px;">상태</td>
                                            <td style="padding:10px 16px;">
                                                <span id="statusBadge" style="padding:4px 12px; border-radius:12px; font-weight:bold;"></span>
                                            </td>
                                        </tr>
                                        <tr style="border-bottom:1px solid #dee2e6;">
                                            <td style="padding:10px 16px; font-weight:bold;">크롤링 유형</td>
                                            <td style="padding:10px 16px;" id="crawlingType">-</td>
                                        </tr>
                                        <tr style="border-bottom:1px solid #dee2e6;">
                                            <td style="padding:10px 16px; font-weight:bold;">현재 장르</td>
                                            <td style="padding:10px 16px;" id="currentGenre">-</td>
                                        </tr>
                                        <tr style="border-bottom:1px solid #dee2e6;">
                                            <td style="padding:10px 16px; font-weight:bold;">장르 진행</td>
                                            <td style="padding:10px 16px;" id="genreProgress">-</td>
                                        </tr>
                                        <tr style="border-bottom:1px solid #dee2e6;">
                                            <td style="padding:10px 16px; font-weight:bold;">시작 시각</td>
                                            <td style="padding:10px 16px;" id="startedAt">-</td>
                                        </tr>
                                        <tr style="border-bottom:1px solid #dee2e6;">
                                            <td style="padding:10px 16px; font-weight:bold;">마지막 완료</td>
                                            <td style="padding:10px 16px;" id="finishedAt">-</td>
                                        </tr>
                                        <tr>
                                            <td style="padding:10px 16px; font-weight:bold;">마지막 소요 시간</td>
                                            <td style="padding:10px 16px;" id="lastDuration">-</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </main>
                <footer class="py-4 bg-light mt-auto">
                    <div class="container-fluid px-4">
                        <div class="d-flex align-items-center justify-content-between small">
                            <div class="text-muted">Copyright &copy; Weiver Admin</div>
                        </div>
                    </div>
                </footer>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"></script>
        <script src="../js/scripts.js"></script>
        <script>
            var BASE_URL = '${baseURL}';

            function fetchStatus() {
                $.getJSON(BASE_URL + '/admin/crawling/status', function(data) {
                    var badge = document.getElementById('statusBadge');
                    if (data.running) {
                        badge.textContent = '실행 중';
                        badge.style.background = '#198754';
                        badge.style.color = '#fff';
                    } else {
                        badge.textContent = '대기';
                        badge.style.background = '#6c757d';
                        badge.style.color = '#fff';
                    }
                    document.getElementById('crawlingType').textContent = data.crawlingType || '-';
                    document.getElementById('currentGenre').textContent = data.currentGenre || '-';
                    var idx = data.genreIndex || 0;
                    var total = data.genreTotal || 0;
                    document.getElementById('genreProgress').textContent = (idx > 0 && total > 0) ? (idx + ' / ' + total) : '-';
                    document.getElementById('startedAt').textContent = data.startedAt || '-';
                    document.getElementById('finishedAt').textContent = data.finishedAt || '-';
                    document.getElementById('lastDuration').textContent = data.lastDuration || '-';
                });
            }

            fetchStatus();
            setInterval(fetchStatus, 5000);
        </script>
    </body>
</html>
