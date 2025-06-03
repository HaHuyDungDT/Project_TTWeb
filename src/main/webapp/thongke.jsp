<%@ page import="utils.SessionUtil" %>
<%@ page import="model.User" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <meta charset="utf-8">
    <title>Thống kê</title>
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
    <link rel="stylesheet" type="text/css" href="css/styleAdmin.css">

    <!-- End import lib -->
</head>

    <style>
        .card { border-radius: 12px; box-shadow: 0 0 10px #ccc; margin-bottom: 20px; }
        .card h4 { margin: 10px 0; }
        h4 {
            margin-top: 30px;
            margin-bottom: 15px;
            font-weight: bold;
            border-left: 4px solid #007bff;
            padding-left: 10px;
        }
        .stat-card {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 15px;
            background-color: #f9f9f9;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        /*.product-columns {*/
        /*    display: flex;*/
        /*    flex-wrap: wrap;*/
        /*}*/
        /*.product-columns ul {*/
        /*    flex: 1 1 50%;*/
        /*    padding-left: 20px;*/
        /*}*/
        /*ul li {*/
        /*    line-height: 1.8;*/
        /*}*/
    </style>

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
<br>
<br>
<br>





    <div class="container my-5">
    <div class="container mt-4 stat-card">
        <h2 class="text-center mb-4">THỐNG KÊ BÁN HÀNG</h2>

        <!-- Tabs -->
        <ul class="nav nav-tabs" id="statisticTabs" role="tablist">
            <li class="nav-item">
                <a class="nav-link active" id="tab1-tab" data-toggle="tab" href="#tab1" role="tab">Tháng này</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="tab2-tab" data-toggle="tab" href="#tab2" role="tab">3 tháng gần nhất</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="tab3-tab" data-toggle="tab" href="#tab3" role="tab">Tất cả</a>
            </li>
        </ul>

        <!-- Tab content -->
        <div class="tab-content mt-3" id="statisticTabsContent">
            <!-- Tab 1: Tháng này -->
            <div class="tab-pane fade show active" id="tab1" role="tabpanel">
                <jsp:include page="statistic-table.jsp">
                    <jsp:param name="title" value="Tháng này"/>
                    <jsp:param name="order" value="${orderThisMonth}"/>
                    <jsp:param name="customer" value="${customerThisMonth}"/>
                    <jsp:param name="product" value="${productThisMonth}"/>
                    <jsp:param name="revenue" value="${revenueThisMonth}"/>
                </jsp:include>
            </div>

            <!-- Tab 2: 3 tháng gần nhất -->
            <div class="tab-pane fade" id="tab2" role="tabpanel">
                <jsp:include page="statistic-table.jsp">
                    <jsp:param name="title" value="3 tháng gần nhất"/>
                    <jsp:param name="order" value="${order3Months}"/>
                    <jsp:param name="customer" value="${customer3Months}"/>
                    <jsp:param name="product" value="${product3Months}"/>
                    <jsp:param name="revenue" value="${revenue3Months}"/>
                </jsp:include>
            </div>

            <!-- Tab 3: Tất cả -->
            <div class="tab-pane fade" id="tab3" role="tabpanel">
                <jsp:include page="statistic-table.jsp">
                    <jsp:param name="title" value="Tất cả"/>
                    <jsp:param name="order" value="${orderAll}"/>
                    <jsp:param name="customer" value="${customerAll}"/>
                    <jsp:param name="product" value="${productAll}"/>
                    <jsp:param name="revenue" value="${revenueAll}"/>
                </jsp:include>
            </div>
        </div>
    </div>

    <div class="stat-card">

    <h4>Biến động so với tháng trước</h4>
    <div class="mt-4">
        <my:compare label="Đơn hàng" current="${orderCurr + 0.0}" last="${orderLast + 0.0}" />
        <my:compare label="Khách hàng" current="${customerCurr + 0.0}" last="${customerLast + 0.0}" />
        <my:compare label="Doanh thu" current="${revenueCurr + 0.0}" last="${revenueLast + 0.0}" />
        <my:compare label="Sản phẩm bán" current="${productCurr + 0.0}" last="${productLast + 0.0}" />

    </div>

    </div>
    <!-- Top 5 sản phẩm bán chạy -->
    <div class="stat-card">
        <h4>Top 5 sản phẩm bán chạy</h4>
        <div class="product-columns">
            <ul>
                <c:forEach var="p" items="${topProducts}" varStatus="status">
                    <li><i class="fas fa-star text-warning"></i> ${status.index + 1}. ${p.name}</li>
                </c:forEach>
            </ul>
        </div>
    </div>

    <!-- Sản phẩm bán được trong 3 tháng -->
    <div class="stat-card">
        <h4>Sản phẩm bán được trong 3 tháng gần nhất</h4>
        <div class="product-columns">
            <ul>
                <c:forEach var="p" items="${sold3Months}" varStatus="loop">
                    <li><i class="fas fa-check-circle text-success"></i> ${loop.index + 1}. ${p.name}</li>
                </c:forEach>
            </ul>
        </div>
    </div>

    <!-- Sản phẩm bán được trong 6 tháng -->
    <div class="stat-card">
        <h4>Sản phẩm bán được trong 6 tháng gần nhất</h4>
        <div class="product-columns">
            <ul>
                <c:forEach var="p" items="${sold6Months}" varStatus="loop">
                    <li><i class="fas fa-check-circle text-success"></i> ${loop.index + 1}. ${p.name}</li>
                </c:forEach>
            </ul>
        </div>
    </div>

    <!-- Sản phẩm không bán được trong 3 tháng -->
    <div class="stat-card">
        <h4>Sản phẩm không bán được trong 3 tháng</h4>
        <div class="row">
            <div class="col-md-6">
                <ul>
                    <c:forEach var="p" items="${unsold3Months}" varStatus="loop">
                        <c:if test="${loop.index % 2 == 0}">
                            <li><i class="fas fa-times-circle text-danger"></i> ${loop.index + 1}. ${p.name}</li>
                        </c:if>
                    </c:forEach>
                </ul>
            </div>
            <div class="col-md-6">
                <ul>
                    <c:forEach var="p" items="${unsold3Months}" varStatus="loop">
                        <c:if test="${loop.index % 2 == 1}">
                            <li><i class="fas fa-times-circle text-danger"></i> ${loop.index + 1}. ${p.name}</li>
                        </c:if>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </div>

    <!-- Sản phẩm không bán được trong 6 tháng -->
    <div class="stat-card">
        <h4>Sản phẩm không bán được trong 6 tháng</h4>
        <div class="row">
            <div class="col-md-6">
                <ul>
                    <c:forEach var="p" items="${unsold6Months}" varStatus="loop">
                        <c:if test="${loop.index % 2 == 0}">
                            <li><i class="fas fa-times-circle text-danger"></i> ${loop.index + 1}. ${p.name}</li>
                        </c:if>
                    </c:forEach>
                </ul>
            </div>
            <div class="col-md-6">
                <ul>
                    <c:forEach var="p" items="${unsold6Months}" varStatus="loop">
                        <c:if test="${loop.index % 2 == 1}">
                            <li><i class="fas fa-times-circle text-danger"></i> ${loop.index + 1}. ${p.name}</li>
                        </c:if>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </div>

    <!-- Sản phẩm cần nhập kho (tồn kho thấp) -->
    <div class="stat-card">
        <h4>Sản phẩm cần nhập kho (số lượng tồn < 10)</h4>
        <div class="product-columns">
            <ul>
                <c:forEach var="p" items="${lowStock}" varStatus="loop">
                    <li><i class="fas fa-exclamation-triangle text-warning"></i> ${loop.index + 1}. ${p.name}</li>
                </c:forEach>
            </ul>
        </div>
    </div>

    <!-- Sản phẩm nên nhập kho (bán chạy nhưng tồn kho thấp) -->
    <div class="stat-card">
        <h4>Sản phẩm nên nhập kho (đang bán chạy, tồn kho thấp)</h4>
        <div class="product-columns">
            <ul>
                <c:forEach var="p" items="${smartRestock}" varStatus="loop">
                    <li><i class="fas fa-box text-primary"></i> ${loop.index + 1}. ${p.name}</li>
                </c:forEach>
            </ul>
        </div>
    </div>


</div>
</body>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>

</html>
