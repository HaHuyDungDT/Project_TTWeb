
<%@ page import="Model.Product" %>
<%@ page import="DAO.ProductDAO" %>
<%@ page import="DAO.ProductDetailsDAO" %>
<%@ page import="Model.ProductDetails" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Sản phẩm</title>

    <!-- Google font -->
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">

    <!-- Bootstrap -->
    <link type="text/css" rel="stylesheet" href="css/bootstrap.min.css"/>

    <!-- Slick -->
    <link type="text/css" rel="stylesheet" href="css/slick.css"/>
    <link type="text/css" rel="stylesheet" href="css/slick-theme.css"/>

    <!-- nouislider -->
    <link type="text/css" rel="stylesheet" href="css/nouislider.min.css"/>

    <!-- Font Awesome Icon -->
    <link rel="stylesheet" href="css/font-awesome.min.css">

    <!-- Custom stylesheet -->
    <link type="text/css" rel="stylesheet" href="css/style.css"/>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

    <jsp:useBean id="a" class="DAO.ProductDAO" scope="request"/>
    <jsp:useBean id="b" class="DAO.ProductDetailsDAO" scope="request"/>
</head>
<body>
<!-- HEADER -->
<jsp:include page="header.jsp"/>
<!-- /HEADER -->

<!-- MENU -->
<jsp:include page="menu.jsp"/>
<!-- /MENU -->

<!-- BREADCRUMB -->
<div id="breadcrumb" class="section">
    <!-- container -->
    <div class="container">
        <!-- row -->
        <div class="row">
            <div class="col-md-12">
                <ul class="breadcrumb-tree">
                    <li><a href="#">Trang chủ </a></li>
                    <li class="active">Sản phẩm</li>
                </ul>
            </div>
        </div>
        <!-- /row -->
    </div>
    <!-- /container -->
</div>
<!-- /BREADCRUMB -->

<!-- SECTION -->
<div class="section">
    <!-- container -->
    <div class="container">
        <!-- row -->
        <div class="row">
            <%
                Product product = ProductDAO.getById(request.getParameter("id"));

                ProductDetailsDAO productDetailsDAO = new ProductDetailsDAO();
                ProductDetails productDetails = productDetailsDAO.getProductDetail(product);
            %>
            <!-- Product main img -->
            <div class="col-md-5 col-md-push-2">
                <div id="product-main-img">
                    <div class="product-preview">
                        <img src="<%= productDetails.getProduct().getImg()%>" alt="">
                    </div>

                    <div class="product-preview">
                        <img src="<%= productDetails.getProduct().getImg()%>" alt="">
                    </div>

                    <div class="product-preview">
                        <img src="<%= productDetails.getProduct().getImg()%>" alt="">
                    </div>

                    <div class="product-preview">
                        <img src="<%= productDetails.getProduct().getImg()%>" alt="">
                    </div>
                </div>
            </div>
            <!-- /Product main img -->

            <!-- Product thumb imgs -->
            <div class="col-md-2 col-md-pull-5">
                <div id="product-imgs">
                    <div class="product-preview">
                        <img src="<%= productDetails.getProduct().getImg()%>" alt="">
                    </div>

                    <div class="product-preview">
                        <img src="<%= productDetails.getProduct().getImg()%>" alt="">
                    </div>

                    <div class="product-preview">
                        <img src="<%= productDetails.getProduct().getImg()%>" alt="">
                    </div>

                    <div class="product-preview">
                        <img src="<%= productDetails.getProduct().getImg()%>" alt="">
                    </div>
                </div>
            </div>
            <!-- /Product thumb imgs -->

            <!-- Product details -->
            <div class="col-md-5">
                <div class="product-details">
                    <h2 class="product-name"><%= productDetails.getProduct().getName()%>
                    </h2>
                    <div>
                        <fmt:formatNumber value="<%=productDetails.getProduct().getPrice()%>" type="number" pattern="#,##0"
                                          var="formattedPrice"/>
                        <h3 class="product-price">${formattedPrice} VNĐ</h3>
                    </div>
                    <p>
                    <ul style="list-style-type: disc">
                        <li><%= productDetails.getDescription()%></li>
                    </ul>
                    <div class="form-group">
                        <label for="quantity">Số lượng:</label>
                        <input style="width: 70px" type="number" class="form-control" id="quantity" name="quantity" min="1" max="100" value="1">  <!-- Đặt value mặc định là 1 -->
                    </div>

                    <br>
                    <div class="add-to-cart">
                        <form action="addcart" method="post">
                            <input type="hidden" name="id" value="<%= productDetails.getProduct().getId() %>">
                            <button type="submit" class="add-to-cart-btn"><i class="fa fa-shopping-cart"></i> Thêm vào giỏ hàng</button>
                        </form>
                    </div>
                </div>
            </div>
            <!-- /Product details -->
            <!-- /product tab -->
        </div>
        <!-- /row -->
    </div>
    <!-- /container -->
</div>
<!-- /SECTION -->

<!-- FOOTER -->
<jsp:include page="footer.jsp"/>
<!-- /FOOTER -->

<!-- jQuery Plugins -->
<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/slick.min.js"></script>
<script src="js/nouislider.min.js"></script>
<script src="js/jquery.zoom.min.js"></script>
<script src="js/main.js"></script>
</body>
</html>
