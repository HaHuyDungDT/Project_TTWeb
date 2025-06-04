<%@ page import="utils.SessionUtil" %>
<%@ page import="model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    // Kiểm tra đăng nhập và phân quyền (chỉ admin và mod mới được vào trang này)
    User userId = (User) SessionUtil.getInstance().getKey((HttpServletRequest) request, "user");
    if(userId == null ||
            (userId.getRoleId() != 1 && userId.getRoleId() != 2)) {
        response.sendRedirect("dangnhap.jsp");
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý tồn kho</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- Import lib -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.css">
    <link rel="stylesheet" type="text/css" href="./css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet">
    <link type="text/css" rel="stylesheet" href="css/style.css"/>
    <!-- End import lib -->
    <link rel="stylesheet" type="text/css" href="css/styleAdmin.css">
    <style>
        .product-img {
            width: 60px;
            height: auto;
            object-fit: contain;
        }
        .pagination {
            justify-content: center;
        }
    </style>
</head>
<body class="overlay-scrollbar">
<!-- navbar -->
<div class="navbar">
    <!-- nav left -->
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link">
                <i class="fa-solid fa-bars" onclick="collapseSidebar()"></i>
            </a>
        </li>
        <li class="nav-item">
            <img src="./img/logo.png" alt="logo" class="logo logo-light">
        </li>
    </ul>
    <!-- end nav left -->

    <!-- nav right -->
    <ul class="navbar-nav nav-right">
        <li class="nav-item dropdown">
            <a class="nav-link">
                <i class="fas fa-bell dropdown-toggle" data-toggle="notification-menu"></i>
                <span class="navbar-badge">1</span>
            </a>
            <ul id="notification-menu" class="dropdown-menu notification-menu">
                <div class="dropdown-menu-header">
						<span>
							Thông báo
						</span>
                </div>
                <div class="dropdown-menu-content overlay-scrollbar scrollbar-hover">
                    <li class="dropdown-menu-item">
                        <a href="#" class="dropdown-menu-link">
                            <div>
                                <i class="fas fa-gift"></i>
                            </div>
                            <span>
                Thông báo kết thúc khuyến mãi
                <br>
                <span>
                  15/07/2020
                </span>
              </span>
                        </a>
                    </li>
                </div>
                <div class="dropdown-menu-footer">
						<span>
						</span>
                </div>
            </ul>
        </li>

        <li class="nav-item avt-wrapper">
            <div class="avt dropdown">
                <img src="./img/admin1.jpg" alt="User image" class="dropdown-toggle" data-toggle="user-menu">
                <ul id="user-menu" class="dropdown-menu">
                    <li class="dropdown-menu-item">
                        <a class="dropdown-menu-link">
                            <div>
                                <i class="fas fa-user-tie"></i>
                            </div>
                            <span>Thông tin cá nhân</span>
                        </a>
                    </li>
                    <li class="dropdown-menu-item">
                        <a href="#" class="dropdown-menu-link">
                            <div>
                                <i class="fas fa-sign-out-alt"></i>
                            </div>
                            <span>Đăng xuất</span>
                        </a>
                    </li>
                </ul>
            </div>
        </li>
    </ul>
    <!-- end nav right -->
</div>

<!-- end navbar -->
<br>

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
            <a href="/quanlylog.jsp" class="sidebar-nav-link ">
                <div>
                    <i class="fa-solid fa-clipboard-list"></i>
                </div>
                <span>Quản lý log</span>
            </a>
        </li>
    </ul>
</div>

<!-- end sidebar -->
<br>
<br>
<br>

<div class="container mt-5">
    <h2 class="mb-4 text-center">Quản lý tồn kho sản phẩm</h2>

    <!-- Modal thông báo -->
    <c:if test="${not empty successMsg || not empty errorMsg}">
        <div class="modal fade" id="statusModal" tabindex="-1" role="dialog" aria-labelledby="statusModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header bg-white border-bottom-0">
                        <h5 class="modal-title text-dark" id="statusModalLabel">Thông báo</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body text-dark">
                        <c:if test="${not empty successMsg}">
                            <p>${successMsg}</p>
                        </c:if>
                        <c:if test="${not empty errorMsg}">
                            <p>${errorMsg}</p>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </c:if>

    <!-- Form thêm mới tồn kho -->
    <div class="card mb-4">
        <div class="card-body">
            <form method="post" action="quanlytonkho" class="form-inline">
                <input type="hidden" name="action" value="insert">
                <div class="form-group mr-2">
                    <label for="productIdAdd" class="mr-2">ID sản phẩm:</label>
                    <input type="number" class="form-control" name="productId" id="productIdAdd" required>
                </div>
                <div class="form-group mr-2">
                    <label for="quantityAdd" class="mr-2">Số lượng:</label>
                    <input type="number" class="form-control" name="quantity" id="quantityAdd" min="0" required>
                </div>
                <button type="submit" class="btn btn-success">Thêm mới</button>
            </form>
        </div>
    </div>

    <!-- Bảng tồn kho -->
    <table class="table table-bordered table-hover">
        <thead class="thead-dark text-center">
        <tr>
            <th>ID tồn kho</th>
            <th>Hình ảnh</th>
            <th>ID sản phẩm</th>
            <th>Tên sản phẩm</th>
            <th>Số lượng tồn</th>
            <th>Cập nhật / Xóa</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="inv" items="${inventories}">
            <tr class="text-center align-middle">
                <td>${inv.id}</td>
                <td><img src="${inv.productImage}" class="product-img"></td>
                <td>${inv.productId}</td>
                <td>${inv.productName}</td>
                <td>${inv.quantity}</td>
                <td>
                    <!-- Form cập nhật và xóa gộp chung hàng -->
                    <div class="d-flex justify-content-center">
                        <form method="post" action="quanlytonkho" class="form-inline">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="productId" value="${inv.productId}">
                            <input type="number" class="form-control mr-2" name="quantity" value="${inv.quantity}" min="0" required>
                            <button type="submit" class="btn btn-primary mr-2">Cập nhật</button>
                        </form>
                        <form method="post" action="quanlytonkho" onsubmit="return confirm('Bạn có chắc muốn xóa?');">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="productId" value="${inv.productId}">
                            <button type="submit" class="btn btn-danger">Xóa</button>
                        </form>
                    </div>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <!-- Phân trang -->
    <nav>
        <ul class="pagination">
            <c:forEach begin="1" end="${totalPages}" var="i">
                <li class="page-item ${i == currentPage ? 'active' : ''}">
                    <a class="page-link" href="?page=${i}">${i}</a>
                </li>
            </c:forEach>
        </ul>
    </nav>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    $(document).ready(function () {
        if ($('#statusModal').length) {
            $('#statusModal').modal('show');
        }
    });
</script>
</body>
</html>
