<%@ page import="service.impl.UserServiceImpl" %>
<%@ page import="utils.SessionUtil" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
<html>
<head lang="en">
    <title>Admin Coupon Management</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport"
          content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="icon" type="image/png" href="./img/logo.png"/>

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
        /* Cho navbar cao ~56px, body padding-top bằng đúng chiều cao navbar */
        body.overlay-scrollbar {
            padding-top: 56px !important;
        }

        /* Nếu vẫn dùng spacer, chỉ cần cao 56px */
        .spacer {
            height: 56px !important;
        }

        /* Xóa margin-top lớn trên page-header */
        .page-header {
            margin-top: 0 !important;
            padding-top: 4px;    /* nếu cần chút khoảng cách */
            padding-bottom: 4px; /* cho cân đối */
        }

        /* Đảm bảo coupon-card không bị đẩy quá xa */
        .coupon-card {
            margin-top: 16px !important;
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
        <li class="nav-item">
            <div class="avt dropdown">
                <c:if test="${sessionScope.user != null}">
                    <a><i class="fa fa-user-o"></i> <%= ((User)SessionUtil.getInstance().getKey((HttpServletRequest) request, "user")).getName() %></a>
                </c:if>
                <ul id="user-menu" class="dropdown-menu">
                    <li class="dropdown-menu-item">
                        <a href="logout" class="dropdown-menu-link">
                            <div>
                                <i class="fas fa-sign-out-alt"></i>
                            </div>
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

    <!-- end nav right -->
</div>
<!-- end navbar -->
<!-- sidebar -->
<div class="sidebar">
    <ul class="sidebar-nav">
        <li class="sidebar-nav-item">
            <a href="thongso.jsp" class="sidebar-nav-link" style="margin-top: 20px;">
                <div>
                    <i class="fa-solid fa-signal"></i>
                </div>
                <span>Thông số bán hàng</span>
            </a>
        </li>
        <li class="sidebar-nav-item">
            <a href="admin.jsp" class="sidebar-nav-link">
                <div>
                    <i class="fa fa-user"></i>
                </div>
                <span>Quản lý nhân viên</span>
            </a>
        </li>
        <li class="sidebar-nav-item">
            <a href="${pageContext.request.contextPath}/coupon" class="sidebar-nav-link">
                <div>
                    <i class="fa-solid fa-ticket"></i>
                </div>
                <span>Quản lý mã giảm giá</span>
            </a>
        </li>

        <li class="sidebar-nav-item">
            <a href="quanlysanpham.jsp" class="sidebar-nav-link">
                <div>
                    <i class="fa fa-mobile"></i>
                </div>
                <span>Quản lý sản phẩm</span>
            </a>
        </li>
        <li class="sidebar-nav-item">
            <a href="quanlyhoadon.jsp" class="sidebar-nav-link">
                <div>
                    <i class="fa-solid fa-layer-group"></i>
                </div>
                <span>Quản lý hóa đơn</span>
            </a>
        </li>
        <li class="sidebar-nav-item">
            <a href="quanlytaikhoan" class="sidebar-nav-link">
                <div>
                    <i class="fa-solid fa-circle-user"></i>
                </div>
                <span>Quản lý tài khoản</span>
            </a>
        </li>
    </ul>
</div>
<!-- end sidebar -->

<!-- main content -->
<div class="wrapper">
    <!-- Page Header -->
    <!-- Page Header -->
    <div class="page-header d-flex justify-content-between align-items-center">
        <h2 class="mb-0">Coupon Management</h2>
        <div class="btn-group" role="group" aria-label="Header actions">
            <button type="button" class="btn btn-success mr-2">
                <i class="fas fa-ticket-alt"></i> Coupon Page
            </button>
            <button type="button" class="btn btn-primary mr-2">
                <i class="fas fa-edit"></i> Manage Coupon
            </button>
            <button type="button" class="btn btn-info">
                <i class="fas fa-save"></i> Save
            </button>
        </div>
    </div>


    <!-- Coupon Card Form -->
    <div class="coupon-card">
        <h4>Coupon Settings</h4>
        <form action="updateCoupon.jsp" method="post">
            <div class="mb-3">
                <label for="couponName" class="form-label">Coupon Name</label>
                <input type="text" class="form-control" id="couponName" name="couponName" placeholder="Nhập tên coupon...">
            </div>
            <div class="mb-3">
                <label for="couponCode" class="form-label">Code</label>
                <input type="text" class="form-control" id="couponCode" name="couponCode" placeholder="Ví dụ: ABCD1234">
            </div>
            <div class="mb-3">
                <label for="couponType" class="form-label">Type</label>
                <select class="form-select" id="couponType" name="couponType">
                    <option value="percentage">Percentage</option>
                    <option value="fixed">Fixed Amount</option>
                </select>
            </div>
            <div class="mb-3">
                <label for="couponDiscount" class="form-label">Discount</label>
                <input type="number" class="form-control" id="couponDiscount" name="couponDiscount" placeholder="Nhập mức giảm giá (VD: 10)">
            </div>
            <div class="mb-3">
                <label for="totalAmount" class="form-label">Total Amount</label>
                <input type="number" class="form-control" id="totalAmount" name="totalAmount" placeholder="Tổng tiền tối thiểu để áp dụng coupon">
            </div>
            <div class="mb-3">
                <label class="form-label">Free Shipping</label><br>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" name="freeShipping" id="freeShippingYes" value="yes">
                    <label class="form-check-label" for="freeShippingYes">Yes</label>
                </div>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" name="freeShipping" id="freeShippingNo" value="no" checked>
                    <label class="form-check-label" for="freeShippingNo">No</label>
                </div>
            </div>
            <div class="mb-3">
                <label class="form-label">Customer Login</label><br>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" name="customerLogin" id="customerLoginYes" value="yes">
                    <label class="form-check-label" for="customerLoginYes">Yes</label>
                </div>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" name="customerLogin" id="customerLoginNo" value="no" checked>
                    <label class="form-check-label" for="customerLoginNo">No</label>
                </div>
            </div>
            <div class="mb-3">
                <label for="products" class="form-label">Products</label>
                <input type="text" class="form-control" id="products" name="products" placeholder="Chọn sản phẩm áp dụng...">
            </div>
            <div class="mb-3">
                <label for="category" class="form-label">Category</label>
                <input type="text" class="form-control" id="category" name="category" placeholder="Chọn danh mục áp dụng...">
            </div>
            <div class="row">
                <div class="col-md-6 mb-3">
                    <label for="dateStart" class="form-label">Date Start</label>
                    <input type="date" class="form-control" id="dateStart" name="dateStart">
                </div>
                <div class="col-md-6 mb-3">
                    <label for="dateEnd" class="form-label">Date End</label>
                    <input type="date" class="form-control" id="dateEnd" name="dateEnd">
                </div>
            </div>
            <div class="mb-3">
                <label for="usePerCoupon" class="form-label">Use Per Coupon</label>
                <input type="number" class="form-control" id="usePerCoupon" name="usePerCoupon" placeholder="Số lần sử dụng cho mỗi coupon">
            </div>
            <div class="mb-3">
                <label for="usePerCustomer" class="form-label">Use Per Customer</label>
                <input type="number" class="form-control" id="usePerCustomer" name="usePerCustomer" placeholder="Số lần tối đa mỗi khách hàng được sử dụng">
            </div>
            <div class="mb-3">
                <label for="status" class="form-label">Status</label>
                <select class="form-select" id="status" name="status">
                    <option value="enabled" selected>Enabled</option>
                    <option value="disabled">Disabled</option>
                </select>
            </div>
            <button type="submit" class="btn btn-primary">Save Coupon</button>
        </form>
    </div>
</div>
<!-- end main content -->


<!-- import script -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js"></script>
<script src="js/admin.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
<!-- end import script -->
</body>
</html>