<%--
  Created by IntelliJ IDEA.
  User: hadun
  Date: 11/12/2023
  Time: 10:17 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="Cart.Cart" %>
<%@ page import="utils.SessionUtil" %>
<%@ page import="service.impl.userServiceImpl" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Cart cart = (Cart) session.getAttribute("cart");
    if(cart == null) cart = new Cart();
%>
<html>
<head>
    <title>Header</title>
    <link rel="icon" type="image/png" href="./img/logo.png"/>
</head>
<body>
<!-- HEADER -->
<header>
    <!-- TOP HEADER -->
    <div id="top-header">
        <div class="container">
            <ul class="header-links pull-left">
                <li><a href="#"><i class="fa fa-phone"></i> 0973206403</a></li>
                <li><a href="#"><i class="fa fa-envelope-o"></i> hadung6765@gmail.com</a></li>
                <li><a href="#"><i class="fa fa-map-marker"></i>Quận Thủ Đức - Tp.Hồ Chí Minh</a></li>
            </ul>
            <ul class="header-links pull-right">
                <c:if test="${sessionScope.user == null}">
                    <li><a href="dangky.jsp"><i class="fa fa-user-o"></i> Đăng kí</a></li>
                    <li><a href="dangnhap.jsp"><i class="fa fa-user-o"></i> Đăng nhập</a></li>
                </c:if>
                <c:if test="${sessionScope.user != null}">
                    <li><a><i class="fa fa-user-o"></i> <%= new userServiceImpl().getById(SessionUtil.getInstance().getKey((HttpServletRequest) request, "user").toString()).getName() %></a></li>
                    <li><a href="logout"><i class="fa fa-user-o"></i> Đăng xuất</a></li>
                </c:if>

            </ul>
        </div>
    </div>
    <!-- /TOP HEADER -->

    <!-- MAIN HEADER -->
    <div id="header">
        <!-- container -->
        <div class="container">
            <!-- row -->
            <div class="row">
                <!-- LOGO -->
                <div class="col-md-3">
                    <div class="header-logo">
                        <a href="#" class="logo">
                            <img src="img/logo.png" alt="">
                        </a>
                    </div>
                </div>
                <!-- /LOGO -->

                <!-- SEARCH BAR -->
                <div class="col-md-6">
                    <div class="header-search">
                        <form action="search" method="post">
                            <input class="input" name="search" placeholder="Tìm kiếm tại đây">
                            <input class="search-btn" type="submit" name="btnGo" value="Tìm kiếm">
                        </form>
                    </div>
                </div>
                <!-- /SEARCH BAR -->

                <!-- ACCOUNT -->
                <div class="col-md-3 clearfix">
                    <div class="header-ctn">
                        <!-- Cart -->
                        <div class="dropdown">
                            <a class="dropdown-toggle" href="giohang.jsp">
                                <i class="fa fa-shopping-cart"></i>
                                <span>Giỏ Hàng</span>
                                <div class="qty"><%=cart.getTotal()%></div>  <!--Code + khi thêm vào giỏ hàng-->
                            </a>
                        </div>
                        <!-- /Cart -->

                        <!-- Menu Toogle -->
                        <div class="menu-toggle">
                            <a href="#">
                                <i class="fa fa-bars"></i>
                                <span>Menu</span>
                            </a>
                        </div>
                        <!-- /Menu Toogle -->
                    </div>
                </div>
                <!-- /ACCOUNT -->
            </div>
            <!-- row -->
        </div>
        <!-- container -->
    </div>
    <!-- /MAIN HEADER -->
</header>
<!-- /HEADER -->
</body>
</html>

