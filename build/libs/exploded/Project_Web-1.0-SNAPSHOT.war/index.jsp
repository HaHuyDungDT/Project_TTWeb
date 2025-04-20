<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1"> <!-- Phù hợp mọi loại màn hình -->
    <link rel="icon" href="./img/logo.png" type="image/x-icon"/>

    <title>Trang chủ - Phone Accessories</title>

    <!-- Google font -->
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">

    <!-- Bootstrap -->
    <link type="text/css" rel="stylesheet" href="css/bootstrap.min.css"/>

    <!-- Slick -->
    <link type="text/css" rel="stylesheet" href="css/slick.css"/>
    <link type="text/css" rel="stylesheet" href="css/slick-theme.css"/>


    <link type="text/css" rel="stylesheet" href="css/nouislider.min.css"/>

    <!-- Font Awesome Icon -->
    <link rel="stylesheet" href="css/font-awesome.min.css">

    <!-- stlylesheet -->
    <link type="text/css" rel="stylesheet" href="css/style.css"/>
    <link rel="icon" href="./img/logo.png" type="image/x-icon"/>

    <jsp:useBean id="a" class="service.impl.ProductServiceImpl" scope="request"></jsp:useBean>
    <jsp:useBean id="d" class="model.ProductType" scope="request"></jsp:useBean>
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/slick.min.js"></script>
    <script src="js/nouislider.min.js"></script>
    <script src="js/jquery.zoom.min.js"></script>


    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/toastify-js"></script>

    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
</head>
<body>
<!-- HEADER -->
<jsp:include page="header.jsp"/>
<!-- /HEADER -->

<!-- MENU -->
<jsp:include page="menu.jsp"/>
<!-- /MENU -->

<!-- SECTION -->
<div class="section">
    <!-- container -->
    <div class="container">
        <!-- row -->
        <div class="row">
            <!-- shop -->
            <div class="col-md-4 col-xs-6">
                <div class="shop">
                    <div class="shop-img">
                        <img src="img/shop1.png" alt="">
                    </div>
                    <div class="shop-body">
                        <h3>Adapter<br> Cáp sạc</h3>
                        <a href="type?id=1" class="cta-btn">Đến ngay <i class="fa fa-arrow-circle-right"></i></a>
                    </div>
                </div>
            </div>
            <!-- /shop -->

            <!-- shop -->
            <div class="col-md-4 col-xs-6">
                <div class="shop">
                    <div class="shop-img">
                        <img src="img/shop2.png" alt="">
                    </div>
                    <div class="shop-body">
                        <h3>Tai nghe</h3>
                        <a href="type?id=3" class="cta-btn">Đến ngay <i class="fa fa-arrow-circle-right"></i></a>
                    </div>
                </div>
            </div>

            <!-- /shop -->

            <!-- shop -->
            <div class="col-md-4 col-xs-6">
                <div class="shop">
                    <div class="shop-img">
                        <img src="img/shop3.png" alt="">
                    </div>
                    <div class="shop-body">
                        <h3>Ốp lưng</h3>
                        <a href="type?id=2" class="cta-btn">Đến ngay <i class="fa fa-arrow-circle-right"></i></a>
                    </div>
                </div>
            </div>
            <!-- /shop -->
        </div>
        <!-- /row -->
    </div>
    <!-- /container -->
</div>
<!-- /SECTION -->

<!-- SECTION -->
<div class="section" style="${a.findNewProduct() != null && !a.findNewProduct().isEmpty() ? '' : 'display:none;'}">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="section-title">
                    <h3 class="title">Sản phẩm mới</h3>
                </div>
            </div>
            <div class="col-md-12">
                <div class="row">
                    <div class="products-tabs">
                        <div id="tab1" class="tab-pane active">
                            <c:forEach items="${a.findNewProduct()}" var="product">
                                <div class="col-md-4 col-xs-6">
                                    <div class="product">
                                        <div class="product-img">
                                            <c:if test="${not empty product.images}">
                                                <img src="${product.images[0].linkImage}" alt="">
                                            </c:if>
                                            <div class="product-label">
                                                <span class="new">Mới</span>
                                            </div>
                                        </div>
                                        <div class="product-body">
                                            <p class="product-category">${product.producer.name}</p>
                                            <h3 class="product-name"><a
                                                    href="product?id=${product.id}">${product.name}</a></h3>
                                            <fmt:formatNumber value="${product.price}" type="number" pattern="#,##0"
                                                              var="formattedPrice"/>
                                            <h4 class="product-price">${formattedPrice} VNĐ</h4>
                                            <div class="product-rating">
                                            </div>
                                        </div>
                                        <div class="add-to-cart">
                                            <button class="add-to-cart-btn  d-block"
                                                    data-product="${product.id}">
                                                <i class="fa fa-shopping-cart"></i> Thêm vào giỏ hàng
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<!-- SECTION -->
<div class="section">
    <div class="container">
        <div class="col-md-12">
            <div class="section-title">
                <h3 class="title">Sản phẩm bán chạy</h3>
            </div>
        </div>
        <div class="col-md-12">
            <div class="row">
                <div class="products-tabs">
                    <div id="tab2" class="tab-pane fade in active">
                        <c:forEach items="${a.findSaleProduct()}" var="product">
                            <div class="col-md-4 col-xs-6">
                                <div class="product">
                                    <div class="product-img">
                                        <img src="${product.images[0].linkImage}" alt="">
                                    </div>
                                    <div class="product-body">
                                        <p class="product-category">${product.producer.name}</p>
                                        <h3 class="product-name"><a
                                                href="product?id=${product.id}">${product.name}</a>
                                        </h3>
                                        <fmt:formatNumber value="${product.price}" type="number"
                                                          pattern="#,##0" var="formattedPrice"/>
                                        <h4 class="product-price">${formattedPrice} VNĐ</h4>
                                        <div class="product-rating"></div>
                                    </div>
                                    <div class="add-to-cart">
                                        <button class="add-to-cart-btn d-block"
                                                data-product="${product.id}">
                                            <i class="fa fa-shopping-cart"></i> Thêm vào giỏ hàng
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- SECTION -->
<div class="section">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="section-title">
                    <h3 class="title">Sản phẩm khuyến mãi</h3>
                </div>
            </div>
            <div class="col-md-12" id="hot-deal">
                <div class="row">
                    <div class="products-tabs">
                        <div id="tab3" class="tab-pane fade in active">
                            <c:forEach items="${a.findSellingProduct()}" var="product">
                                <div class="col-md-4 col-xs-6">
                                    <div class="product">
                                        <div class="product-img">
                                            <img src="${product.images[0].linkImage}" alt="">
                                        </div>
                                        <div class="product-body">
                                            <p class="product-category">${product.producer.name}</p>
                                            <h3 class="product-name"><a
                                                    href="product?id=${product.id}">${product.name}</a>
                                            </h3>
                                            <fmt:formatNumber value="${product.price}" type="number"
                                                              pattern="#,##0" var="formattedPrice"/>
                                            <h4 class="product-price">${formattedPrice} VNĐ</h4>
                                            <div class="product-rating"></div>
                                        </div>
                                        <div class="add-to-cart">
                                            <button class="add-to-cart-btn  d-block"
                                                    data-product="${product.id}">
                                                <i class="fa fa-shopping-cart"></i> Thêm vào giỏ hàng
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- /SECTION -->


<!-- FOOTER -->
<jsp:include page="footer.jsp"/>
<script src="js/main.js"></script>
<!-- /FOOTER -->

<!-- jQuery Plugins -->


</body>
</html>