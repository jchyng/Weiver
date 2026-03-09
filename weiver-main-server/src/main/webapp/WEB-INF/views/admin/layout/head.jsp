<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../../config.jsp" %>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<script src="https://cdn.tailwindcss.com"></script>
<script>
  tailwind.config = {
    theme: {
      extend: {
        colors: {
          'admin-bg': '#020617',
          'admin-surface': '#0F172A',
          'admin-card': '#1E293B',
          'admin-primary': '#E11D48',
          'admin-secondary': '#FB7185',
          'admin-gold': '#FDE68A',
          'admin-text': '#F8FAFC',
          'admin-text-sub': '#94A3B8',
          'admin-border': 'rgba(226, 232, 240, 0.05)',
        },
        fontFamily: {
          sans: ['Pretendard', 'Inter', 'sans-serif'],
          serif: ['Cinzel', 'Playfair Display', 'serif'],
        },
        boxShadow: {
          'premium': '0 10px 30px -10px rgba(0, 0, 0, 0.7)',
          'glow': '0 0 20px rgba(225, 29, 72, 0.15)',
        }
      }
    }
  }
</script>
<link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.8/dist/web/static/pretendard.css" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
<link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

<style>
  body { 
    background-color: #020617; 
    color: #F8FAFC;
    scrollbar-width: thin;
    scrollbar-color: #1E293B #020617;
  }
  ::-webkit-scrollbar { width: 6px; }
  ::-webkit-scrollbar-track { background: #020617; }
  ::-webkit-scrollbar-thumb { background: #1E293B; border-radius: 10px; }
  ::-webkit-scrollbar-thumb:hover { background: #334155; }

  .glass-effect {
    background: rgba(15, 23, 42, 0.8);
    backdrop-filter: blur(12px);
    border: 1px solid rgba(226, 232, 240, 0.05);
  }
  
  .nav-item-active {
    background: linear-gradient(90deg, rgba(225, 29, 72, 0.1) 0%, transparent 100%);
    color: #E11D48;
    border-left: 4px solid #E11D48;
  }

  /* DataTable 프리미엄 리뉴얼 - 다크 테마 가독성 완벽 보장 */
  .dataTable-wrapper {
    background: transparent !important;
  }
  
  .dataTable-top {
    padding: 1.5rem 2rem !important;
    display: flex !important;
    align-items: center !important;
    justify-content: space-between !important;
    gap: 20px;
    border-bottom: 1px solid rgba(255, 255, 255, 0.05) !important;
    background: rgba(15, 23, 42, 0.2) !important;
  }

  /* 왼쪽: 행 수 선택 영역 */
  .dataTable-dropdown {
    display: flex !important;
    align-items: center !important;
  }

  .dataTable-dropdown label {
    display: flex !important;
    align-items: center !important;
    gap: 12px !important;
    color: #94A3B8 !important;
    font-size: 11px !important;
    font-weight: 700 !important;
    text-transform: uppercase !important;
    letter-spacing: 0.1em !important;
  }

  /* 셀렉트 박스 강제 다크화 및 디자인 개선 */
  .dataTable-wrapper select.dataTable-selector,
  .dataTable-wrapper .dataTable-dropdown select {
    background-color: #1E293B !important;
    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 24 24' stroke='%23E11D48'%3E%3Cpath stroke-linecap='round' stroke-linejoin='round' stroke-width='3' d='M19 9l-7 7-7-7'/%3E%3C/svg%3E") !important;
    background-repeat: no-repeat !important;
    background-position: right 8px center !important;
    background-size: 12px !important;
    border: 1px solid rgba(255, 255, 255, 0.2) !important;
    border-radius: 8px !important;
    color: #FFFFFF !important;
    padding: 6px 32px 6px 12px !important;
    font-size: 12px !important;
    font-weight: 600 !important;
    cursor: pointer !important;
    appearance: none !important;
    -webkit-appearance: none !important;
    -moz-appearance: none !important;
    transition: all 0.2s ease !important;
    min-width: 64px !important;
    display: inline-block !important;
    visibility: visible !important;
    opacity: 1 !important;
  }

  .dataTable-wrapper select.dataTable-selector:hover {
    border-color: #E11D48 !important;
    background-color: #2D3748 !important;
  }

  /* 검색창 영역 */
  .dataTable-search {
    position: relative !important;
    width: 280px !important;
  }

  .dataTable-search::before {
    content: '\F52A';
    font-family: 'bootstrap-icons' !important;
    position: absolute;
    left: 14px;
    top: 50%;
    transform: translateY(-50%);
    color: #E11D48;
    font-size: 14px;
    z-index: 10;
    pointer-events: none;
  }

  /* 입력창 강제 다크화 */
  .dataTable-wrapper input.dataTable-input {
    width: 100% !important;
    background-color: #1E293B !important;
    border: 1px solid rgba(255, 255, 255, 0.2) !important;
    border-radius: 10px !important;
    color: #FFFFFF !important;
    padding: 10px 16px 10px 40px !important;
    font-size: 13px !important;
    font-weight: 500 !important;
    transition: all 0.2s ease !important;
    outline: none !important;
  }

  input.dataTable-input:focus {
    background-color: #2D3748 !important;
    border-color: #E11D48 !important;
    box-shadow: 0 0 15px rgba(225, 29, 72, 0.15) !important;
  }

  /* 하단 영역 (정보 및 페이지네이션) */
  .dataTable-bottom {
    padding: 1.5rem 2rem !important;
    display: flex !important;
    align-items: center !important;
    justify-content: space-between !important;
    border-top: 1px solid rgba(255, 255, 255, 0.05) !important;
    background: rgba(15, 23, 42, 0.1) !important;
  }

  .dataTable-info {
    color: #64748B !important;
    font-size: 11px !important;
    font-weight: 600 !important;
    text-transform: uppercase !important;
    letter-spacing: 0.05em !important;
  }

  /* 페이지네이션 버튼 */
  .dataTable-pagination ul {
    display: flex !important;
    gap: 4px !important;
  }

  .dataTable-pagination li {
    list-style: none !important;
  }

  .dataTable-pagination a {
    display: flex !important;
    align-items: center !important;
    justify-content: center !important;
    min-width: 32px !important;
    height: 32px !important;
    background: rgba(255, 255, 255, 0.03) !important;
    border: 1px solid rgba(255, 255, 255, 0.05) !important;
    color: #94A3B8 !important;
    border-radius: 8px !important;
    padding: 0 10px !important;
    font-size: 12px !important;
    font-weight: 600 !important;
    transition: all 0.2s ease !important;
    cursor: pointer !important;
    text-decoration: none !important;
  }

  .dataTable-pagination li.active a {
    background: #E11D48 !important;
    border-color: #E11D48 !important;
    color: #FFFFFF !important;
    box-shadow: 0 4px 12px rgba(225, 29, 72, 0.3) !important;
  }

  /* 테이블 스타일 */
  .premium-table thead th {
    background: rgba(15, 23, 42, 0.4) !important;
    color: #64748B !important;
    font-size: 11px !important;
    font-weight: 700 !important;
    text-transform: uppercase !important;
    letter-spacing: 0.1em !important;
    padding: 16px 24px !important;
    border-bottom: 1px solid rgba(255, 255, 255, 0.05) !important;
  }

  .premium-table tbody td {
    padding: 16px 24px !important;
    border-bottom: 1px solid rgba(255, 255, 255, 0.02) !important;
    color: #94A3B8;
  }


  @keyframes slideIn {
    from { opacity: 0; transform: translateY(10px); }
    to { opacity: 1; transform: translateY(0); }
  }
  .animate-slide-in { animation: slideIn 0.4s ease-out forwards; }
</style>
