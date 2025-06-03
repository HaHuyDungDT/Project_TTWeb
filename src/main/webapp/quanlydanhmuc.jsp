<%@ page import="model.User, utils.SessionUtil, java.util.List, model.ProductType, dao.impl.ProductTypeDAOImpl" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="dao.impl.ProductTypeDAOImpl, model.ProductType" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // Kiểm tra đăng nhập & phân quyền
    User user = (User) SessionUtil.getInstance()
            .getKey((javax.servlet.http.HttpServletRequest) request, "user");
    if (user == null || (user.getRoleId() != 1 && user.getRoleId() != 2)) {
        response.sendRedirect("dangnhap.jsp");
        return;
    }
    // Lấy danh sách danh mục
    List<ProductType> types = new ProductTypeDAOImpl().findAll();
    request.setAttribute("types", types);
%>
<%
    String action = request.getParameter("action");
    ProductType editType = null;
    if ("edit".equals(action)) {
        int id = Integer.parseInt(request.getParameter("id"));
        editType = new ProductTypeDAOImpl().findById(id);
        request.setAttribute("editType", editType);
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, user-scalable=0">
    <title>Quản lý danh mục sản phẩm</title>
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
        .btn-green {
            background-color: #28a745;
            border-color: #28a745;
            color: #fff;
        }
        /* dropdown gợi ý */
        #cat-search-results .search-result-item {
            padding: .5rem;
            cursor: pointer;
        }
        #cat-search-results .search-result-item:hover {
            background-color: #f1f1f1;
        }
        #cat-search-results .no-results {
            padding: .5rem;
            color: #888;
        }

        .combined-input-group .input-group {
            display: flex;
        }

        .combined-input-group .dropdown-toggle {
            /* cho nút Lọc flex giống input */
            flex: 1 1 0;
            width: 0; /* để flex tính toán chiều rộng */
        }

        .combined-input-group .form-control {
            /* input mặc định đã flex:1; nếu không bạn cũng có thể ép thêm */
            flex: 1 1 0;
        }

        /* giữ icon search không co giãn */
        .combined-input-group .input-group-text {
            flex: 0 0 auto;
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
            <a href="/storeCategory" class="sidebar-nav-link">
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
        <!-- Thêm mục Quản lý tồn kho -->
        <li class="sidebar-nav-item">
            <a href="/quanlytonkho" class="sidebar-nav-link">
                <div>
                    <i class="fa-solid fa-boxes-stacked"></i> <!-- icon tồn kho -->
                </div>
                <span>Quản lý tồn kho</span>
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
                    <i class="bi bi-arrow-left me-1"></i> Danh mục
                </a>
                <h3 class="mb-0">Quản lý danh mục sản phẩm</h3>
            </div>
            <!-- Nút mở modal -->
            <button type="button"
                    class="btn btn-success"
                    data-toggle="modal"
                    data-target="#createCategoryModal">
                <i class="bi bi-plus-lg me-1"></i> Tạo danh mục
            </button>
        </div>

        <!-- Tabs -->
        <ul class="nav nav-tabs mb-4">
            <li class="nav-item">
                <a class="nav-link active" href="#">Tất cả danh mục</a>
            </li>
        </ul>

        <!-- Filter + Search -->
        <div class="mb-5 position-relative"><!-- cần relative để dropdown-positioned con hoạt động -->
            <div class="input-group">
                <!-- Wrapper dropdown để Bootstrap nhận diện -->
                <div class="dropdown flex-fill">
                    <button
                            class="btn btn-success dropdown-toggle w-100"
                            type="button"
                            id="filterDropdown"
                            data-toggle="dropdown"
                            aria-haspopup="true"
                            aria-expanded="false">
                        Lọc danh mục
                    </button>
                    <div class="dropdown-menu" aria-labelledby="filterDropdown">
                        <!-- Link sang lại chính page với param status tương ứng -->
                        <a class="dropdown-item"
                           href="${pageContext.request.contextPath}/quanlydanhmuc.jsp?status=all">
                            Tất cả
                        </a>
                        <a class="dropdown-item"
                           href="${pageContext.request.contextPath}/quanlydanhmuc.jsp?status=active">
                            Đang hoạt động
                        </a>
                    </div>
                </div>

                <span class="input-group-text"><i class="bi bi-search"></i></span>
                <input
                        id="catSearchInput"
                        type="text"
                        class="form-control flex-fill"
                        placeholder="Tìm kiếm danh mục…">
            </div>

            <!-- dropdown kết quả autocomplete -->
            <div id="cat-search-results"
                 class="position-absolute w-100 bg-white border rounded shadow-sm"
                 style="top:100%; left:0; max-height:200px; overflow-y:auto; z-index:1000; display:none">
            </div>
        </div>


        <!-- Modal Sửa danh mục -->
        <div class="modal fade" id="editCategoryModal" tabindex="-1" role="dialog"
             aria-labelledby="editCategoryLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
                <div class="modal-content">
                    <form action="${pageContext.request.contextPath}/updateCategory" method="post">
                        <div class="modal-header">
                            <h5 class="modal-title" id="editCategoryLabel">Sửa danh mục</h5>
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                        </div>
                        <div class="modal-body">
                            <input type="hidden" name="id" id="editCatId"/>
                            <div class="form-group">
                                <label for="editCatName">Tên danh mục</label>
                                <input type="text" class="form-control" name="name" id="editCatName" required/>
                            </div>
                            <div class="form-group">
                                <label for="editCatCode">Mã danh mục</label>
                                <input type="text" class="form-control" name="code" id="editCatCode"/>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
                            <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>


        <!-- Bảng danh mục -->
        <div class="table-container table-responsive mb-4">
            <table class="table align-middle table-hover mb-0 table-fixed">
                <!-- Định nghĩa 3 cột bằng colgroup -->
                <colgroup>
                    <col style="width: 33.33%;" />
                    <col style="width: 33.33%;" />
                    <col style="width: 33.33%;" />
                </colgroup>
                <thead class="table-light">
                <tr>
                    <th>Danh mục</th>
                    <th>Mã danh mục</th>
                    <th>Hành động</th>
                </tr>
                </thead>
                <tbody id="cat-table-body">
                <!-- Ajax sẽ render vào đây -->
                </tbody>
<%--                <tbody>--%>
<%--                <c:forEach var="type" items="${types}">--%>
<%--                    <tr>--%>
<%--                        <!-- Cột Danh mục -->--%>
<%--                        <td>${type.name}</td>--%>
<%--                        <!-- Cột Mã danh mục -->--%>
<%--                        <td>${type.code}</td>--%>
<%--                        <!-- Cột Hành động -->--%>
<%--                        <td>--%>
<%--                            <button type="button"--%>
<%--                                    class="btn btn-sm btn-outline-primary btn-edit"--%>
<%--                                    data-toggle="modal"--%>
<%--                                    data-target="#editCategoryModal"--%>
<%--                                    data-id="${type.id}"--%>
<%--                                    data-name="${type.name}"--%>
<%--                                    data-code="${type.code}">--%>
<%--                                <i class="fas fa-edit"></i> Sửa--%>
<%--                            </button>--%>
<%--                            <form action="deleteCategory" method="post"--%>
<%--                                  style="display:inline-block;"--%>
<%--                                  onsubmit="return confirm('Bạn có chắc muốn xóa danh mục này?');">--%>
<%--                                <input type="hidden" name="id" value="${type.id}"/>--%>
<%--                                <button type="submit"--%>
<%--                                        class="btn btn-sm btn-outline-danger"--%>
<%--                                        title="Xóa">--%>
<%--                                    <i class="fas fa-trash-alt"></i>--%>
<%--                                    <span class="d-none d-md-inline">Xóa</span>--%>
<%--                                </button>--%>
<%--                            </form>--%>
<%--                        </td>--%>
<%--                    </tr>--%>
<%--                </c:forEach>--%>
<%--                </tbody>--%>
            </table>

        </div>
        <nav>
            <ul class="pagination justify-content-center" id="cat-pagination"></ul>
        </nav>
    </div>
</div>
    <!-- end MAIN CONTENT -->


    <!-- Modal Form Tạo danh mục -->
    <div class="modal fade" id="createCategoryModal" tabindex="-1" role="dialog"
         aria-labelledby="createCategoryLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
            <div class="modal-content">
                <form action="storeCategory" method="post">
                    <div class="modal-header">
                        <h5 class="modal-title" id="createCategoryLabel">Tạo mới danh mục</h5>
                        <button type="button" class="close" data-dismiss="modal"
                                aria-label="Đóng">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group mb-3">
                            <label for="catName">Tên danh mục</label>
                            <input type="text" class="form-control" id="catName"
                                   name="name" required>
                        </div>
                        <div class="form-group mb-3">
                            <label for="catDesc">Mô tả</label>
                            <textarea class="form-control" id="catDesc"
                                      name="description" rows="4"></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary"
                                data-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-primary">Lưu</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
    <script src="js/admin.js"></script>
<script>
    $(function(){
        $('#catSearchInput').on('input', function(){
            let kw = $(this).val();
            if (kw.length>2) {
                $.getJSON('${pageContext.request.contextPath}/autocompleteCategory',
                    { query: kw }, function(data){
                        let html = '';
                        if (data.length) {
                            data.forEach(function(item){
                                html +=
                                    '<div class="search-result-item">'+
                                    '<a href="quanlydanhmuc.jsp?action=edit&id='+ item.id +'">'+
                                    item.name + ' ('+ item.code +')'+
                                    '</a>'+
                                    '</div>';
                            });
                        } else {
                            html = '<div class="no-results">Không tìm thấy danh mục</div>';
                        }
                        $('#cat-search-results').html(html).show();
                    });
            } else {
                $('#cat-search-results').hide();
            }
        });
        $(document).click(function(e){
            if (!$(e.target).closest('#catSearchInput').length)
                $('#cat-search-results').hide();
        });
    });

    const PAGE_SIZE = 10;
    function loadCategories(page = 1) {
        $.getJSON('${pageContext.request.contextPath}/getCategories', { page, size: PAGE_SIZE }, function(res) {
            let rows = '';
            res.data.forEach(function(t) {
                rows += '<tr>' +
                    '<td>' + t.name + '</td>' +
                    '<td>' + t.code + '</td>' +
                    '<td>' +
                    '<button class="btn btn-sm btn-outline-primary btn-edit" ' +
                    'data-toggle="modal" data-target="#editCategoryModal" ' +
                    'data-id="' + t.id + '" data-name="' + t.name + '" data-code="' + t.code + '">' +
                    '<i class="fas fa-edit"></i> Sửa' +
                    '</button> ' +
                    '<form action="deleteCategory" method="post" style="display:inline-block;" ' +
                    'onsubmit="return confirm(\'Bạn có chắc muốn xóa danh mục này?\');">' +
                    '<input type="hidden" name="id" value="' + t.id + '"/>' +
                    '<button type="submit" class="btn btn-sm btn-outline-danger">' +
                    '<i class="fas fa-trash-alt"></i> Xóa' +
                    '</button>' +
                    '</form>' +
                    '</td>' +
                    '</tr>';
            });
            $('#cat-table-body').html(rows);
            renderPagination(res.currentPage, res.totalPages);
        });
    }
    function renderPagination(cur, total) {
        let html = '';
        for (let i = 1; i <= total; i++) {
            html += '<li class="page-item ' + (i === cur ? 'active' : '') + '">' +
                '<a class="page-link" href="#">' + i + '</a>' +
                '</li>';
        }
        $('#cat-pagination').html(html);
        $('#cat-pagination .page-link').off('click').on('click', function(e) {
            e.preventDefault();
            loadCategories(parseInt($(this).text()));
        });
    }

    // 1) Delegate sự kiện cho nút Sửa
    $(document).on('click', '.btn-edit', function(e) {
        e.preventDefault();
        // đọc data-attrs
        const id   = $(this).data('id');
        const name = $(this).data('name');
        const code = $(this).data('code');
        // fill vào form trong modal
        $('#editCatId').val(id);
        $('#editCatName').val(name);
        $('#editCatCode').val(code);
        // mở modal
        $('#editCategoryModal').modal('show');
    });
    $(document).ready(function() {
        loadCategories(1);
        // …giữ lại autocomplete / edit modal code…
    });
</script>
</body>
</html>

