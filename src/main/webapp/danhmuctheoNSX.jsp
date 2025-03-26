<%@ page import="model.Product" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% List<Product> data = (List<Product>) request.getAttribute("listC");%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Danh mục sản phẩm</title>

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

    <!-- Custom stlylesheet -->
    <link type="text/css" rel="stylesheet" href="css/style.css"/>

    <jsp:useBean id="a" class="dao.ProductDAO" scope="request"></jsp:useBean>
    <jsp:useBean id="b" class="dao.ProducerDAO" scope="request"></jsp:useBean>
    <jsp:useBean id="c" class="dao.ProductTypeDAO" scope="request"></jsp:useBean>

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
                    <li><a href="index.jsp">Trang chủ</a></li>
                    <li><a href="#">Danh mục sản phẩm</a></li>
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
            <!-- ASIDE -->
            <div id="aside" class="col-md-3">
                <!-- aside Widget -->
                <div class="aside">
                    <h3 class="aside-title">Hãng sản xuất</h3>
                    <div class="checkbox-filter">
                        <c:forEach items="${b.selectAll()}" var="producer">
                            <div class="input-checkbox">
                                <a href="category?idProducer=${producer.id}">${producer.name}</a>
                            </div>
                        </c:forEach>
                    </div>
                </div>
                <!-- /aside Widget -->

                <!-- aside Widget -->
                <div class="aside">
                    <h3 class="aside-title">Danh mục</h3>
                    <div class="checkbox-filter">
                        <c:forEach items="${c.selectAll()}" var="productType">
                            <div class="input-checkbox">
                                <a href="type?idProductType=${productType.id}">${productType.name}</a>
                            </div>
                        </c:forEach>
                    </div>
                </div>
                <!-- /aside Widget -->
            </div>
            <!-- /ASIDE -->

            <!-- store products -->

            <div class="row">
                <!-- fullproduct -->
                <% for (Product p : data){%>
                    <div class="col-md-4 col-xs-6">
                        <div class="product">
                            <div class="product-img">
                                <img src="<%=p.getImg()%>" alt="">
                            </div>
                            <div class="product-body">
                                <p class="product-category"><%=p.getProducer().getName()%></p>
                                <h3 class="product-name"><a href="sanpham.jsp?id=<%=p.getId()%>"><%=p.getName()%></a></h3>
                                <fmt:formatNumber value="<%=p.getPrice()%>" type="number" pattern="#,##0"
                                                  var="formattedPrice"/>
                                <h4 class="product-price">${formattedPrice} VNĐ</h4>
                                <div class="product-rating">
                                </div>
                                <div class="product-btns">
                                </div>
                            </div>
                            <div class="add-to-cart">
                                <form action="addcart" method="post">
                                    <input type="hidden" name="id" value="<%= p.getId() %>">
                                    <button type="submit" class="add-to-cart-btn"><i class="fa fa-shopping-cart"></i> Thêm vào giỏ hàng</button>
                                </form>
                            </div>
                        </div>
                    </div>
                <%}%>
            </div>
            <!-- /fullproduct -->


        </div>
        <!-- /store products -->

    </div>
    <!-- /STORE -->
</div>
<!-- /row -->
<!-- /container -->
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
