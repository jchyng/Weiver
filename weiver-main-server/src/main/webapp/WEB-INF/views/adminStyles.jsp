<%-- Admin Dashboard — Shared Styles (Simple DataTables v7 uses lowercase class names) --%>
<style>
  /* ═══ Layout ═══ */
  body { display: flex; min-height: 100vh; }
  #sidebar { width: 256px; min-height: 100vh; flex-shrink: 0; }
  #main-content { flex: 1; min-height: 100vh; overflow-x: auto; }

  /* ═══ Sidebar Nav ═══ */
  .nav-link-item {
    display: flex; align-items: center; gap: 10px;
    padding: 10px 16px; border-radius: 10px;
    font-size: 14px; font-weight: 600; color: #94A3B8;
    transition: all 0.2s ease; margin: 2px 8px;
    border-left: 3px solid transparent;
  }
  .nav-link-item:hover {
    background: rgba(255,255,255,0.06); color: #F8FAFC;
    border-left-color: rgba(212,175,55,0.4);
  }
  .nav-link-item.active {
    background: rgba(190,18,60,0.12); color: #fb7185;
    border-left-color: #D4AF37;
  }

  /* ═══ DataTable — Dark Theme (v7 lowercase classes) ═══ */
  .datatable-wrapper { color: #F8FAFC; font-size: 14px; }

  /* Top & Bottom Controls */
  .datatable-top, .datatable-bottom {
    display: flex; align-items: center; justify-content: space-between;
    padding: 14px 0; gap: 16px; flex-wrap: wrap;
  }
  .datatable-top { padding-bottom: 18px; border-bottom: 1px solid rgba(51,65,85,0.3); }
  .datatable-bottom { padding-top: 16px; border-top: 1px solid rgba(51,65,85,0.3); }

  /* Dropdown / Per-page Selector */
  .datatable-wrapper .datatable-dropdown label {
    display: flex; align-items: center; gap: 8px;
    color: #94A3B8; font-size: 13px; font-weight: 600; white-space: nowrap;
  }
  select.datatable-selector,
  .datatable-wrapper select.datatable-selector,
  .datatable-wrapper .datatable-selector {
    -webkit-appearance: none !important;
    -moz-appearance: none !important;
    appearance: none !important;
    background-color: #1E293B !important;
    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' fill='none' viewBox='0 0 12 12'%3E%3Cpath stroke='%2394A3B8' stroke-width='1.5' stroke-linecap='round' d='M3 4.5L6 7.5L9 4.5'/%3E%3C/svg%3E") !important;
    background-repeat: no-repeat !important;
    background-position: right 10px center !important;
    border: 1px solid #334155 !important;
    color: #F8FAFC !important;
    color-scheme: dark !important;
    border-radius: 8px;
    padding: 7px 32px 7px 12px;
    font-size: 13px; font-weight: 600;
    cursor: pointer;
    transition: border-color 0.2s, box-shadow 0.2s;
  }
  select.datatable-selector:hover,
  .datatable-wrapper .datatable-selector:hover { border-color: #475569 !important; }
  select.datatable-selector:focus,
  .datatable-wrapper .datatable-selector:focus {
    outline: none; border-color: #D4AF37 !important;
    box-shadow: 0 0 0 3px rgba(212,175,55,0.1);
  }
  select.datatable-selector option,
  .datatable-wrapper .datatable-selector option {
    background-color: #1E293B !important;
    color: #F8FAFC !important;
    padding: 8px;
  }

  /* Search Input */
  .datatable-wrapper .datatable-input {
    background: #1E293B !important;
    border: 1px solid #334155 !important;
    color: #F8FAFC !important;
    border-radius: 10px;
    padding: 8px 14px 8px 38px;
    font-size: 13px; font-weight: 500;
    width: 240px;
    transition: border-color 0.2s, box-shadow 0.2s, width 0.3s ease;
    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='%234B5563' viewBox='0 0 16 16'%3E%3Cpath d='M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z'/%3E%3C/svg%3E") !important;
    background-repeat: no-repeat !important;
    background-position: 12px center !important;
  }
  .datatable-wrapper .datatable-input::placeholder { color: #4B5563; }
  .datatable-wrapper .datatable-input:focus {
    outline: none; border-color: #D4AF37 !important;
    box-shadow: 0 0 0 3px rgba(212,175,55,0.1);
    width: 300px;
  }

  /* Table */
  .datatable-table { width: 100% !important; border-collapse: separate; border-spacing: 0; }
  .datatable-table th {
    background: rgba(30,41,59,0.7) !important;
    color: #94A3B8 !important;
    font-size: 11px; font-weight: 700;
    text-transform: uppercase; letter-spacing: 0.1em;
    padding: 14px 16px;
    border-bottom: 1px solid #334155;
    white-space: nowrap;
  }
  .datatable-table th:first-child { border-radius: 10px 0 0 0; }
  .datatable-table th:last-child { border-radius: 0 10px 0 0; }
  .datatable-table td {
    padding: 14px 16px;
    border-bottom: 1px solid rgba(51,65,85,0.25);
    font-size: 14px; vertical-align: middle;
    transition: background 0.15s ease;
  }
  .datatable-table tbody tr { transition: all 0.15s ease; }
  .datatable-table tbody tr:hover td { background: rgba(255,255,255,0.035); }
  .datatable-table tbody tr:last-child td { border-bottom: none; }

  /* Sort Indicators */
  .datatable-sorter::before { border-bottom-color: #475569 !important; }
  .datatable-sorter::after { border-top-color: #475569 !important; }
  .datatable-ascending .datatable-sorter::after { border-top-color: #D4AF37 !important; }
  .datatable-descending .datatable-sorter::before { border-bottom-color: #D4AF37 !important; }

  /* Pagination */
  .datatable-pagination { display: flex; }
  .datatable-pagination-list { display: flex; align-items: center; gap: 4px; list-style: none; margin: 0; padding: 0; }
  .datatable-pagination-list-item-link {
    color: #64748B; border-radius: 8px;
    padding: 6px 12px; font-size: 13px; font-weight: 600;
    transition: all 0.15s ease; border: 1px solid transparent;
    text-decoration: none; display: inline-block;
  }
  .datatable-pagination-list-item-link:hover {
    background: rgba(255,255,255,0.06); color: #F8FAFC;
    border-color: rgba(51,65,85,0.5);
  }
  .datatable-active .datatable-pagination-list-item-link {
    background: linear-gradient(135deg, #BE123C, #9F1239) !important;
    color: #fff !important; border-color: transparent !important;
    box-shadow: 0 2px 10px rgba(190,18,60,0.3);
  }
  .datatable-disabled .datatable-pagination-list-item-link {
    opacity: 0.3; cursor: not-allowed; pointer-events: none;
  }

  /* Info Text */
  .datatable-info { color: #64748B; font-size: 13px; font-weight: 500; }

  /* Empty State */
  .datatable-empty { color: #4B5563; text-align: center; padding: 48px 16px; font-size: 14px; font-weight: 500; }

  /* ═══ Action Buttons ═══ */
  .btn-delete {
    background: rgba(190,18,60,0.08); color: #fb7185;
    border: 1px solid rgba(190,18,60,0.2);
    padding: 5px 14px; border-radius: 8px;
    font-size: 12px; font-weight: 700;
    cursor: pointer; transition: all 0.2s ease;
    white-space: nowrap;
  }
  .btn-delete:hover { background: rgba(190,18,60,0.2); border-color: rgba(190,18,60,0.4); }

  .btn-answer {
    background: rgba(212,175,55,0.08); color: #FBBF24;
    border: 1px solid rgba(212,175,55,0.2);
    padding: 5px 14px; border-radius: 8px;
    font-size: 12px; font-weight: 700;
    cursor: pointer; transition: all 0.2s ease;
    white-space: nowrap;
  }
  .btn-answer:hover { background: rgba(212,175,55,0.18); border-color: rgba(212,175,55,0.35); }

  /* ═══ Badges ═══ */
  .badge-review {
    background: rgba(190,18,60,0.12); color: #fb7185;
    padding: 3px 10px; border-radius: 6px;
    font-size: 11px; font-weight: 700;
    border: 1px solid rgba(190,18,60,0.15);
  }
  .badge-chat {
    background: rgba(148,163,184,0.1); color: #94A3B8;
    padding: 3px 10px; border-radius: 6px;
    font-size: 11px; font-weight: 700;
    border: 1px solid rgba(148,163,184,0.12);
  }
  .badge-done {
    background: rgba(34,197,94,0.1); color: #4ade80;
    padding: 3px 10px; border-radius: 6px;
    font-size: 11px; font-weight: 700;
    border: 1px solid rgba(34,197,94,0.15);
  }
  .badge-wait {
    background: rgba(148,163,184,0.08); color: #94A3B8;
    padding: 3px 10px; border-radius: 6px;
    font-size: 11px; font-weight: 700;
    border: 1px solid rgba(148,163,184,0.1);
  }

  /* ═══ Custom Scrollbar ═══ */
  .overflow-x-auto::-webkit-scrollbar { height: 6px; }
  .overflow-x-auto::-webkit-scrollbar-track { background: transparent; }
  .overflow-x-auto::-webkit-scrollbar-thumb { background: #334155; border-radius: 3px; }
  .overflow-x-auto::-webkit-scrollbar-thumb:hover { background: #475569; }
</style>
