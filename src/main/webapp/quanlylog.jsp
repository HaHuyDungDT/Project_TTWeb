<%@ page import="model.User, utils.SessionUtil, java.util.List, model.Log, dao.impl.LogDAOImpl" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="dao.impl.LogDAOImpl, model.Log" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // Kiểm tra đăng nhập & phân quyền
    User user = (User) SessionUtil.getInstance()
            .getKey((javax.servlet.http.HttpServletRequest) request, "user");
    if (user == null || (user.getRoleId() != 1 && user.getRoleId() != 2)) {
        response.sendRedirect("dangnhap.jsp");
        return;
    }
    // Lấy danh sách log
    List<Log> logs = new LogDAOImpl().findAll();
    request.setAttribute("logs", logs);
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, user-scalable=0">
    <title>Quản lý log hệ thống</title>
    <link rel="icon" href="./img/logo.png" type="image/png"/>
    <!-- Bootstrap 4 CSS -->
    <link rel="stylesheet"
          href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
    <!-- Icons & custom CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"
          rel="stylesheet">
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link rel="stylesheet" href="css/style.css"/>
    <link rel="stylesheet" href="css/styleAdmin.css"/>

    <style>
        .table-container { background-color: #fff; }
        .table-container .table tbody a {
            color: #007bff;
        }
        .table-container .table tbody a:hover {
            color: #0056b3;
            text-decoration: underline;
        }
        /* Bắt buộc bảng chia đều cột */
        .table-fixed {
            table-layout: fixed;
            width: 100%;
        }
        /* Căn giữa nội dung */
        .table-fixed th,
        .table-fixed td {
            text-align: center;
            vertical-align: middle;
            padding: 0.75rem;
            overflow: hidden;      /* nếu text dài sẽ ẩn bớt */
            text-overflow: ellipsis;
            white-space: nowrap;
        }
        .table-fixed th,
        .table-fixed td {
            border-right: 1px solid #dee2e6; /* màu giống Bootstrap */
        }

        /* Bỏ đường kẻ ở cột cuối cùng */
        .table-fixed th:last-child,
        .table-fixed td:last-child {
            border-right: none;
        }

        /* dropdown gợi ý */
        #log-search-results .search-result-item {
            padding: .5rem;
            cursor: pointer;
        }
        #log-search-results .search-result-item:hover {
            background-color: #f1f1f1;
        }
        #log-search-results .no-results {
            padding: .5rem;
            color: #888;
        }

        .combined-input-group .input-group {
            display: flex;
        }

        .combined-input-group .dropdown-toggle {
            flex: 1 1 0;
            width: 0;
        }

        .combined-input-group .form-control {
            flex: 1 1 0;
        }

        .combined-input-group .input-group-text {
            flex: 0 0 auto;
        }

        /* Badge styles for log levels */
        .badge-info {
            background-color: #17a2b8;
            color: #fff;
        }
        .badge-warning {
            background-color: #ffc107;
            color: #000;
        }
        .badge-danger {
            background-color: #dc3545;
            color: #fff;
        }
    </style>
</head>
<body class="overlay-scrollbar">

<!-- NAVBAR -->
<nav class="navbar navbar-expand navbar-light bg-white shadow-sm">
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link" href="#"><i class="fa-solid fa-bars"
                                            onclick="collapseSidebar()"></i></a>
        </li>
        <li class="nav-item">
            <img src="./img/logo.png" alt="logo" class="logo logo-light">
        </li>
    </ul>
    <ul class="navbar-nav ml-auto nav-right">
        <li class="nav-item dropdown">
            <a class="nav-link" href="#">
                <i class="fas fa-bell dropdown-toggle" data-toggle="notification-menu"></i>
                <span class="navbar-badge">1</span>
            </a>
        </li>
        <li class="nav-item avt-wrapper">
            <div class="avt dropdown">
                <img src="./img/admin1.jpg" alt="User image"
                     class="dropdown-toggle" data-toggle="user-menu">
            </div>
        </li>
    </ul>
</nav>
<!-- end NAVBAR -->

<!-- sidebar -->
<div class="sidebar">
    <ul class="sidebar-nav">
        <li class="sidebar-nav-item">
            <a href="/admin" class="sidebar-nav-link">
                <div>
                    <i class="fa fa-user"></i>
                </div>
                <span>Dashboard</span>
            </a>
        </li>
        <li class="sidebar-nav-item">
            <a href="/thongke" class="sidebar-nav-link" >
                <div><i class="fa-solid fa-signal"></i></div>
                <span>Thông số bán hàng</span>
            </a>
        </li>
        <li class="sidebar-nav-item">
            <a href="/quanlysanpham" class="sidebar-nav-link">
                <div><i class="fa fa-mobile"></i></div>
                <span>Quản lý sản phẩm</span>
            </a>
        </li>
        <li class="sidebar-nav-item">
            <a href="/quanlydanhmuc.jsp" class="sidebar-nav-link">
                <div><i class="fas fa-list-alt"></i></div>
                <span>Quản lý danh mục sản phẩm</span>
            </a>
        </li>
        <li class="sidebar-nav-item">
            <a href="/quanlydonhang" class="sidebar-nav-link">
                <div>
                    <i class="fa-solid fa-layer-group"></i>
                </div>
                <span>Quản lý đơn hàng</span>
            </a>
        </li>
        <li class="sidebar-nav-item">
            <a href="/quanlytaikhoan" class="sidebar-nav-link">
                <div>
                    <i class="fa-solid fa-circle-user"></i>
                </div>
                <span>Quản lý tài khoản</span>
            </a>
        </li>
        <li class="sidebar-nav-item">
            <a href="/quanlytonkho" class="sidebar-nav-link">
                <div>
                    <i class="fa-solid fa-boxes-stacked"></i>
                </div>
                <span>Quản lý tồn kho</span>
            </a>
        </li>
        <li class="sidebar-nav-item">
            <a href="/quanlylog.jsp" class="sidebar-nav-link active">
                <div>
                    <i class="fa-solid fa-clipboard-list"></i>
                </div>
                <span>Quản lý log</span>
            </a>
        </li>
    </ul>
</div>

<!-- end sidebar -->

<!-- MAIN CONTENT -->
<div class="wrapper">
    <div class="container-fluid py-4">
        <!-- Header -->
        <div class="d-flex justify-content-between align-items-start mb-4">
            <div class="d-flex flex-column">
                <a href="#" class="text-muted text-decoration-none mb-1">
                    <i class="bi bi-arrow-left me-1"></i> Log
                </a>
                <h3 class="mb-0">Quản lý log hệ thống</h3>
            </div>
        </div>

        <!-- Tabs -->
        <ul class="nav nav-tabs mb-4">
            <li class="nav-item">
                <a class="nav-link active" href="#">Tất cả log</a>
            </li>
        </ul>

        <!-- Filter + Search -->
        <div class="mb-5 position-relative">
            <div class="input-group">
                <div class="dropdown flex-fill">
                    <button
                            class="btn btn-success dropdown-toggle w-100"
                            type="button"
                            id="filterDropdown"
                            data-toggle="dropdown"
                            aria-haspopup="true"
                            aria-expanded="false">
                        Lọc theo cấp độ
                    </button>
                    <div class="dropdown-menu" aria-labelledby="filterDropdown">
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/quanlylog.jsp?level=all">
                            Tất cả
                        </a>
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/quanlylog.jsp?level=INFO">
                            Info
                        </a>
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/quanlylog.jsp?level=WARNING">
                            Warning
                        </a>
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/quanlylog.jsp?level=DANGER">
                            Danger
                        </a>
                    </div>
                </div>

                <span class="input-group-text"><i class="bi bi-search"></i></span>
                <input
                        id="logSearchInput"
                        type="text"
                        class="form-control flex-fill"
                        placeholder="Tìm kiếm log...">
            </div>

            <!-- dropdown kết quả autocomplete -->
            <div id="log-search-results"
                 class="position-absolute w-100 bg-white border rounded shadow-sm"
                 style="top:100%; left:0; max-height:200px; overflow-y:auto; z-index:1000; display:none">
            </div>
        </div>

        <!-- Bảng log -->
        <div class="table-container table-responsive mb-4">
            <table class="table align-middle table-hover mb-0 table-fixed">
                <colgroup>
                    <col style="width: 10%;" />
                    <col style="width: 15%;" />
                    <col style="width: 25%;" />
                    <col style="width: 15%;" />
                    <col style="width: 15%;" />
                    <col style="width: 20%;" />
                </colgroup>
                <thead class="table-light">
                <tr>
                    <th>ID</th>
                    <th>Cấp độ</th>
                    <th>Hành động</th>
                    <th>IP</th>
                    <th>User ID</th>
                    <th>Thời gian</th>
                </tr>
                </thead>
                <tbody id="log-table-body">
                <!-- Ajax sẽ render vào đây -->
                </tbody>
            </table>
        </div>
        <nav>
            <ul class="pagination justify-content-center" id="log-pagination"></ul>
        </nav>
    </div>
</div>
<!-- end MAIN CONTENT -->

<!-- Scripts -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
<script src="js/admin.js"></script>
<script>
    const PAGE_SIZE = 10;
    let currentLevel = 'all';
    let currentSearch = '';

    function loadLogs(page = 1) {
        const params = {
            page: page,
            size: PAGE_SIZE,
            level: currentLevel
        };
        
        if (currentSearch) {
            params.search = currentSearch;
        }

        $.getJSON('${pageContext.request.contextPath}/getLogs', params, function(res) {
            let rows = '';
            res.data.forEach(function(log) {
                let levelClass = '';
                switch(log.level) {
                    case 'INFO':
                        levelClass = 'badge-info';
                        break;
                    case 'WARNING':
                        levelClass = 'badge-warning';
                        break;
                    case 'DANGER':
                        levelClass = 'badge-danger';
                        break;
                }
                
                rows += '<tr>' +
                    '<td>' + log.id + '</td>' +
                    '<td><span class="badge ' + levelClass + '">' + log.level + '</span></td>' +
                    '<td>' + log.action + '</td>' +
                    '<td>' + log.addressIP + '</td>' +
                    '<td>' + log.userId + '</td>' +
                    '<td>' + new Date(log.createdAt).toLocaleString() + '</td>' +
                    '</tr>';
            });
            $('#log-table-body').html(rows);
            renderPagination(res.currentPage, res.totalPages);
        }).fail(function(jqXHR, textStatus, errorThrown) {
            console.error('Error loading logs:', errorThrown);
            alert('Có lỗi xảy ra khi tải dữ liệu log');
        });
    }

    // Xử lý lọc theo level
    $('.dropdown-item').on('click', function(e) {
        e.preventDefault();
        const level = $(this).attr('href').split('level=')[1];
        currentLevel = level;
        $('#filterDropdown').text($(this).text());
        loadLogs(1);
    });

    // Xử lý tìm kiếm
    let searchTimeout;
    $('#logSearchInput').on('input', function() {
        clearTimeout(searchTimeout);
        const searchValue = $(this).val().trim();
        
        searchTimeout = setTimeout(function() {
            currentSearch = searchValue;
            loadLogs(1);
        }, 500); // Delay 500ms sau khi người dùng ngừng gõ
    });

    function renderPagination(cur, total) {
        let html = '';
        for (let i = 1; i <= total; i++) {
            html += '<li class="page-item ' + (i === cur ? 'active' : '') + '">' +
                '<a class="page-link" href="#">' + i + '</a>' +
                '</li>';
        }
        $('#log-pagination').html(html);
        $('#log-pagination .page-link').off('click').on('click', function(e) {
            e.preventDefault();
            loadLogs(parseInt($(this).text()));
        });
    }

    $(document).ready(function() {
        loadLogs(1);
    });

    // Search functionality
    $('#logSearchInput').on('input', function(){
        let kw = $(this).val();
        if (kw.length > 2) {
            $.getJSON('${pageContext.request.contextPath}/searchLogs',
                { query: kw }, function(data){
                    let html = '';
                    if (data.length) {
                        data.forEach(function(log){
                            html += '<div class="search-result-item">' +
                                '<div>' + log.action + ' - ' + log.level + '</div>' +
                                '<small class="text-muted">' + new Date(log.createdAt).toLocaleString() + '</small>' +
                                '</div>';
                        });
                    } else {
                        html = '<div class="no-results">Không tìm thấy log</div>';
                    }
                    $('#log-search-results').html(html).show();
                });
        } else {
            $('#log-search-results').hide();
        }
    });

    $(document).click(function(e){
        if (!$(e.target).closest('#logSearchInput').length)
            $('#log-search-results').hide();
    });
</script>
</body>
</html> 