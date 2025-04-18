<%@ page import="service.impl.UserServiceImpl" %>
<%@ page import="utils.SessionUtil" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="model.User" %>
<%@ page import="utils.SessionUtil" %>
<%
    // Lấy đối tượng User từ session
    User currentUser = (User) SessionUtil.getInstance().getKey((HttpServletRequest) request, "user");
    if(currentUser == null || !currentUser.getRoleId().equals(1)) {
        response.sendRedirect("dangnhap.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Mã Giảm Giá</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, user-scalable=0">
    <link rel="icon" type="image/png" href="./img/logo.png"/>

    <!-- Import thư viện -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css"/>
    <link rel="stylesheet" href="css/styleAdmin.css"/>
    <!-- /Import thư viện -->

    <style>
        .action-buttons {
            white-space: nowrap;
            position: relative;
            z-index: 102;
            align-self: flex-end;
            margin-top: 10px;
        }
        /* Căn giữa nội dung các ô bảng */
        .table-responsive th,
        .table-responsive td {
            vertical-align: middle !important;
        }
        /* Căn giữa checkbox trong ô, đồng thời đặt margin tự động */
        .table-responsive .form-check-input {
            display: block;
            margin: auto;
        }
    </style>
</head>
<body class="overlay-scrollbar">
<!-- NAVBAR -->
<div class="navbar">
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link"><i class="fa-solid fa-bars" onclick="collapseSidebar()"></i></a>
        </li>
        <li class="nav-item">
            <img src="./img/logo.png" alt="logo" class="logo logo-light">
        </li>
    </ul>
    <ul class="navbar-nav nav-right">
        <li class="nav-item">
            <div class="avt dropdown">
                <c:if test="${sessionScope.user != null}">
                    <a><i class="fa fa-user-o"></i>
                        <%= ((User)SessionUtil.getInstance().getKey((HttpServletRequest)request,"user")).getName() %>
                    </a>
                </c:if>
                <ul id="user-menu" class="dropdown-menu">
                    <li class="dropdown-menu-item">
                        <a href="logout" class="dropdown-menu-link">
                            <div><i class="fas fa-sign-out-alt"></i></div>
                            <span>Đăng xuất</span>
                        </a>
                    </li>
                </ul>
            </div>
        </li>
        <li class="nav-item">
            <div class="avt dropdown">
                <img src="./img/admin1.jpg" alt="User image" class="dropdown-toggle" data-toggle="user-menu">
            </div>
        </li>
    </ul>
</div>
<!-- /NAVBAR -->

<!-- SIDEBAR -->
<div class="sidebar">
    <ul class="sidebar-nav">
        <li class="sidebar-nav-item">
            <a href="thongso.jsp" class="sidebar-nav-link" style="margin-top: 20px;">
                <div><i class="fa-solid fa-signal"></i></div>
                <span>Thông số bán hàng</span>
            </a>
        </li>
        <li class="sidebar-nav-item">
            <a href="admin.jsp" class="sidebar-nav-link">
                <div><i class="fa fa-user"></i></div>
                <span>Quản lý nhân viên</span>
            </a>
        </li>
        <li class="sidebar-nav-item">
            <a href="${pageContext.request.contextPath}/coupon" class="sidebar-nav-link">
                <div><i class="fa-solid fa-ticket"></i></div>
                <span>Quản lý mã giảm giá</span>
            </a>
        </li>
        <li class="sidebar-nav-item">
            <a href="quanlysanpham.jsp" class="sidebar-nav-link">
                <div><i class="fa fa-mobile"></i></div>
                <span>Quản lý sản phẩm</span>
            </a>
        </li>
        <li class="sidebar-nav-item">
            <a href="quanlyhoadon.jsp" class="sidebar-nav-link">
                <div><i class="fa-solid fa-layer-group"></i></div>
                <span>Quản lý hóa đơn</span>
            </a>
        </li>
        <li class="sidebar-nav-item">
            <a href="quanlytaikhoan" class="sidebar-nav-link">
                <div><i class="fa-solid fa-circle-user"></i></div>
                <span>Quản lý tài khoản</span>
            </a>
        </li>
    </ul>
</div>
<!-- /SIDEBAR -->

<!-- MAIN CONTENT -->
<div class="wrapper">
    <div class="content">

        <!-- Debug: số coupon load được -->
        <div class="mb-2">
            <c:out value="${fn:length(coupons)}" /> coupon(s) loaded.
            <c:if test="${empty coupons}">
                <span class="text-danger">Chưa có dữ liệu coupon!</span>
            </c:if>
        </div>

        <div class="d-flex justify-content-between align-items-center mb-3">
            <div class="d-flex align-items-center">
                <h2 class="mb-0" style="font-size:1.5rem; margin-right:20px;">Coupons</h2>
                <nav aria-label="breadcrumb" class="ms-3">
                    <ol class="breadcrumb mb-0">
                        <li class="breadcrumb-item"><a href="#">Home</a></li>
                        <li class="breadcrumb-item"><a href="#">Management</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Coupons</li>
                    </ol>
                </nav>
            </div>
            <div class="action-buttons">
                <button class="btn btn-primary me-2" title="New Coupon"><i class="fas fa-plus"></i></button>
                <button class="btn btn-danger me-2" title="Delete"><i class="fas fa-trash"></i></button>
                <button class="btn btn-secondary" title="Settings"><i class="fas fa-cog"></i></button>
            </div>
        </div>

        <div class="card shadow-sm">
            <div class="card-header">
                <h5 class="card-title mb-0">Coupon List</h5>
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover table-bordered mb-0">
                        <thead class="table-light">
                        <tr>
                            <th><input class="form-check-input" type="checkbox" disabled/></th>
                            <th>Coupon Code</th>
                            <th>Discount</th>
                            <th>Date Start</th>
                            <th>Date End</th>
                            <th>Usage</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="coupon" items="${coupons}">
                            <tr>
                                <td><input class="form-check-input" type="checkbox"/></td>
                                <td>
                                    <span class="me-2"><c:out value="${coupon.code}" default="N/A"/></span>
                                    <button class="btn btn-success btn-sm" title="Copy Code">
                                        <i class="fas fa-copy"></i>
                                    </button>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${coupon.discount_type eq 'percent'}">
                                            <c:out value="${coupon.discount_value}" default="0"/>% OFF
                                        </c:when>
                                        <c:otherwise>
                                            <fmt:formatNumber value="${coupon.discount_value}" type="currency" currencySymbol="₫"/> OFF
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty coupon.date_start}">
                                            <fmt:formatDate value="${coupon.date_start}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                        </c:when>
                                        <c:otherwise>-</c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty coupon.date_end}">
                                            <fmt:formatDate value="${coupon.date_end}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                        </c:when>
                                        <c:otherwise>-</c:otherwise>
                                    </c:choose>
                                </td>
                                <!-- Usage: 3/10 + progress bar -->
                                <td>
                                    <div class="d-flex align-items-center">
                                        <small class="me-2">3/10</small>
                                        <div class="progress flex-grow-1" style="height:6px;">
                                            <div class="progress-bar" role="progressbar" style="width:30%"></div>
                                        </div>
                                    </div>
                                </td>
                                <!-- Status: switch tắt/mở -->
                                <td>
                                    <div class="custom-control custom-switch">
                                        <input type="checkbox" class="custom-control-input" id="switch${coupon.code}" checked>
                                        <label class="custom-control-label" for="switch${coupon.code}"></label>
                                    </div>
                                </td>
                                <!-- Action: Copy / Edit / Delete -->
                                <td>
                                    <!-- Copy -->
                                    <button class="btn btn-success btn-sm me-1" title="Copy">
                                        <i class="fas fa-copy"></i>
                                    </button>

                                    <!-- Edit: chuyển thành thẻ <a> -->
                                    <a
                                            href="editCoupon.jsp?couponId=${coupon.id}"
                                            class="btn btn-primary btn-sm me-1"
                                            title="Edit"
                                    >
                                        <i class="fas fa-edit"></i>
                                    </a>

                                    <!-- Delete -->
                                    <button class="btn btn-danger btn-sm" title="Delete">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="d-flex justify-content-between align-items-center p-3">
                    <small>Showing 1 to ${fn:length(coupons)} of ${fn:length(coupons)} (1 Page)</small>
                    <nav>
                        <ul class="pagination mb-0">
                            <li class="page-item disabled"><a class="page-link" href="#">Previous</a></li>
                            <li class="page-item active"><a class="page-link" href="#">1</a></li>
                            <li class="page-item disabled"><a class="page-link" href="#">Next</a></li>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>

    </div>
</div>
<!-- /MAIN CONTENT -->

<!-- Scripts -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
<script src="js/admin.js"></script>
</body>
</html>
