<%@ page import="service.impl.UserServiceImpl" %>
<%@ page import="utils.SessionUtil" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="model.User" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    // Kiểm tra đăng nhập và phân quyền (chỉ admin mới được vào trang này)
    User userId = (User) SessionUtil.getInstance().getKey((HttpServletRequest) request, "user");
    if(userId == null || userId.getRoleId() != 1) {
        response.sendRedirect("dangnhap.jsp");
    }
%>


<jsp:useBean id="a" class="DAO.OrderDAO" scope="request"></jsp:useBean>
<jsp:useBean id="b" class="DAO.OrderDetailsDAO" scope="request"></jsp:useBean>
<c:set var="currentDate" value="<%=java.time.LocalDate.now()%>"/>
<style>
    #dataForm {
        display: none;
    }
</style>
<!DOCTYPE html>
<html>
<head lang="en">
    <title>Admin</title>
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
                    <a><i class="fa fa-user-o"></i> <%= new UserServiceImpl().getById(SessionUtil.getInstance().getKey((HttpServletRequest) request, "user").toString()).getName() %></a>
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
            <a href="quanlysanpham.jsp" class="sidebar-nav-link">
                <div>
                    <i class="fa fa-mobile"></i>
                </div>
                <span>Quản lý sản phẩm</span>
            </a>
        </li>
        <li class="sidebar-nav-item">
            <a href="quanlydanhmuc.jsp" class="sidebar-nav-link">
                <div><i class="fas fa-list-alt"></i></div>
                <span>Quản lý danh mục sản phẩm</span>
            </a>
        </li>
        <li class="sidebar-nav-item">
            <a href="quanlydonhang.jsp" class="sidebar-nav-link">
                <div>
                    <i class="fa-solid fa-layer-group"></i>
                </div>
                <span>Quản lý đơn hàng</span>
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
    <div class="row">

        <div class="col-3 col-m-6 col-sm-6">
            <div class="counter bg-primary">
                <p>
                    <i class="fas fa-tasks"></i>
                </p>
                <h3 id="countOrd">${a.countOrdersInMonth(currentDate)}</h3>
                <p>Đơn hàng tháng này</p>
            </div>
        </div>
        <div class="col-3 col-m-6 col-sm-6">
            <div class="counter bg-warning">
                <p>
                    <i class="fas fa-user"></i>
                </p>
                <h3 id="countCus">${a.countCustomersWithOrdersInMonth(currentDate)}</h3>
                <p>Khách mua hàng tháng này</p>
            </div>
        </div>
        <div class="col-3 col-m-6 col-sm-6">
            <div class="counter bg-success">
                <p>
                    <i>$</i>
                </p>
                <fmt:formatNumber value="${b.calculateRevenueInThisMonth()}" type="number"
                                  pattern="#,##0" var="formattedPrice"/>
                <h3 id="calculateRev">${formattedPrice} VND</h3>
                <p>Doanh thu tháng này</p>
            </div>
        </div>
        <div class="col-3 col-m-6 col-sm-6">
            <div class="counter bg-danger">
                <p>
                    <i class="fas fa-box"></i>
                </p>
                <h3 id="countPro">${b.countSoldProductsInThisMonth()}</h3>
                <p>Sản phẩm tháng này bán ra</p>
            </div>
        </div>
        <form id="dataForm" action="/par" method="post">
            <!-- Các trường input hidden để lưu giá trị -->
            <input type="hidden" id="orderCountInput" name="countOrd" value="">
            <input type="hidden" id="customerCountInput" name="countCus" value="">
            <input type="hidden" id="revenueInput" name="calculateRev" value="">
            <input type="hidden" id="productCountInput" name="countPro" value="">
        </form>
    </div>
    <div class="row">
        <%
            ParameterDAO p = new ParameterDAO();
            int currentMonth = LocalDate.now().getMonthValue();
            int currentYear = LocalDate.now().getYear();

            int lastMonth = currentMonth - 1;
            int lastYear = currentYear;
            if (lastMonth == 0) {
                lastMonth = 12;
                lastYear--;
            }
            List<Parameter> list = p.getByMonth(currentMonth, currentYear);
            List<Parameter> listLast = p.getByMonth(lastMonth, lastYear);
            if (list != null && listLast != null) {
                for (Parameter currentP : list) {
                    for (Parameter lastP : listLast) {%>
        <div class="col-4 col-m-12 col-sm-12">
            <div class="card">
                <div class="card-header">
                    <h3>
                        Biến động
                    </h3>
                    <i class="fas fa-ellipsis-h"></i>
                </div>
                <div class="card-content">
                    <div class="progress-wrapper">
                        <p>
                            Số đơn hàng so với tháng trước
                            <span class="float-right"><%=((currentP.getNumber_ord() - lastP.getNumber_ord()) / lastP.getNumber_ord()) * 100%>%</span>
                        </p>
                        <div class="progress">
                            <div class="bg-success"
                                 style="width: <%=((currentP.getNumber_ord()- lastP.getNumber_ord())/lastP.getNumber_ord())*100%>%"></div>
                        </div>
                    </div>
                    <div class="progress-wrapper">
                        <p>
                            Số khách mua hàng so với tháng trước
                            <span class="float-right"><%=((currentP.getNumber_cus() - lastP.getNumber_cus()) / lastP.getNumber_cus()) * 100%>%</span>
                        </p>
                        <div class="progress">
                            <div class="bg-primary"
                                 style="width:<%=((currentP.getNumber_cus()- lastP.getNumber_cus())/lastP.getNumber_cus())*100%>%"></div>
                        </div>
                    </div>
                    <div class="progress-wrapper">
                        <p>
                            Doanh thu so với tháng trước
                            <span class="float-right"><%=((currentP.getRevenue() - lastP.getRevenue()) / lastP.getRevenue()) * 100%>%</span>
                        </p>
                        <div class="progress">
                            <div class="bg-warning"
                                 style="width:<%=((currentP.getRevenue()- lastP.getRevenue())/lastP.getRevenue())*100%>%"></div>
                        </div>
                    </div>
                    <div class="progress-wrapper">
                        <p>
                            Lượng sản phẩm bán ra so với tháng trước
                            <span class="float-right"><%=((currentP.getNumber_pro() - lastP.getNumber_pro()) / lastP.getNumber_pro()) * 100%>%</span>
                        </p>
                        <div class="progress">
                            <div class="bg-danger"
                                 style="width:<%=((currentP.getNumber_pro()- lastP.getNumber_pro())/lastP.getNumber_pro())*100%>%"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%
                    }
                }
            }
        %>
    </div>
</div>
<!-- end main content -->

<!-- import script -->

<script>
    window.onload = function () {
        // Lấy giá trị từ các thẻ <h3> và cập nhật các trường input hidden
        document.getElementById("orderCountInput").value = "${a.countOrdersInMonth(currentDate)}";
        document.getElementById("customerCountInput").value = "${a.countCustomersWithOrdersInMonth(currentDate)}";
        document.getElementById("revenueInput").value = "${b.calculateRevenueInThisMonth()}";
        document.getElementById("productCountInput").value = "${b.countSoldProductsInThisMonth()}";
        document.getElementById("dataForm").submit();
    };
</script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js"></script>
<script src="js/admin.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
<!-- end import script -->
</body>
</html>