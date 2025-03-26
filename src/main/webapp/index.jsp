<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1"> <!-- Phù hợp mọi loại màn hình -->


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

    <jsp:useBean id="a" class="dao.SaleProductDAO" scope="request"></jsp:useBean>
    <jsp:useBean id="b" class="dao.SellingProductDAO" scope="request"></jsp:useBean>
    <jsp:useBean id="c" class="dao.NewProductDAO" scope="request"></jsp:useBean>
    <jsp:useBean id="d" class="model.ProductType" scope="request"></jsp:useBean>

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
                        <a href="type?idProductType=Pt_1" class="cta-btn">Đến ngay <i class="fa fa-arrow-circle-right"></i></a>
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
                        <a href="type?idProductType=Pt_3" class="cta-btn">Đến ngay <i class="fa fa-arrow-circle-right"></i></a>
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
                        <a href="type?idProductType=Pt_2" class="cta-btn">Đến ngay <i class="fa fa-arrow-circle-right"></i></a>
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
<div class="section">
    <!-- container -->
    <div class="container">
        <!-- row -->
        <div class="row">

            <!-- section title -->
            <div class="col-md-12">
                <div class="section-title">
                    <h3 class="title">Sản phẩm mới</h3>
                </div>
            </div>
            <!-- /section title -->

            <!-- Products tab & slick -->
            <div class="col-md-12">
                <div  class="row" >
                    <div class="products-tabs">
                        <!-- tab -->
                        <div id="tab1" class="tab-pane active">
                            <!-- product -->
                            <c:forEach items="${c.selectAll()}" var="productNew">
                                <div class="col-md-4 col-xs-6">
                                    <div class="product">
                                        <div class="product-img">
                                            <img src="${productNew.product.img}" alt="">
                                            <div class="product-label">
                                                <span class="new">Mới</span>
                                            </div>
                                        </div>
                                        <div class="product-body">
                                            <p class="product-category">${productNew.product.producer.name}</p>
                                            <h3 class="product-name"><a href="sanpham.jsp?id=${productNew.product.id}">${productNew.product.name}</a></h3>
                                            <fmt:formatNumber value="${productNew.product.price}" type="number"
                                                              pattern="#,##0" var="formattedPrice"/>
                                            <h4 class="product-price">${formattedPrice} VNĐ</h4>
                                            <div class="product-rating">
                                            </div>
                                        </div>
                                        <div class="add-to-cart">
                                            <form action="addcart" method="post">
                                                <input type="hidden" name="id" value="${ productNew.product.id }">
                                                <button type="submit" class="add-to-cart-btn"><i class="fa fa-shopping-cart"></i> Thêm vào giỏ hàng</button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                            <!-- /product -->

                            <!-- /tab -->

                        </div>
                    </div>
                </div>
            </div>
            <!-- Products tab & slick -->
        </div>
        <!-- /row -->
    </div>
    <!-- /container -->
</div>
<!-- /SECTION -->


<!-- SECTION -->
<div class="section">
    <!-- container -->
    <div class="container">
        <!-- row -->

        <!-- section title -->
        <div class="col-md-12">
            <div class="section-title">
                <h3 class="title">Sản phẩm bán chạy</h3>
            </div>
        </div>
        <!-- /section title -->

        <!-- Products tab & slick -->
        <div class="col-md-12">
            <div class="row">
                <div class="products-tabs">
                    <!-- tab -->
                    <div id="tab2" class="tab-pane fade in active">
                        <!-- product -->
                        <c:forEach items="${b.selectAll()}" var="productSelling">
                            <div class="col-md-4 col-xs-6">
                                <div class="product">
                                    <div class="product-img">
                                        <img src="${productSelling.product.img}" alt="">
                                    </div>
                                    <div class="product-body">
                                        <p class="product-category">${productSelling.product.producer.name}</p>
                                        <h3 class="product-name"><a href="sanpham.jsp?id=${productSelling.product.id}">${productSelling.product.name}</a></h3>
                                        <fmt:formatNumber value="${productSelling.product.price}" type="number"
                                                          pattern="#,##0" var="formattedPrice"/>
                                        <h4 class="product-price">${formattedPrice} VNĐ</h4>
                                        <div class="product-rating"></div>
                                    </div>
                                    <div class="add-to-cart">
                                        <form action="addcart" method="post">
                                            <input type="hidden" name="id" value="${ productSelling.product.id }">
                                            <button type="submit" class="add-to-cart-btn"><i class="fa fa-shopping-cart"></i> Thêm vào giỏ hàng</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                        <!-- /product -->
                    </div>
                </div>
                <!-- /Products tab & slick -->
            </div>
            <!-- /row -->
        </div>
        <!-- /container -->
    </div>
    <!-- /SECTION -->
</div>
<!-- SECTION -->
<div class="section">
    <!-- container -->
    <div class="container">
        <!-- row -->
        <div class="row">

            <!-- section title -->
            <div class="col-md-12">
                <div class="section-title">
                    <h3 class="title" >Sản phẩm khuyến mãi</h3>
                </div>
            </div>
            <!-- /section title -->
            <!-- Products tab & slick -->
            <div class="col-md-12" id="hot-deal">
                <div class="row">
                    <div class="products-tabs">
                        <!-- tab -->
                        <div id="tab3" class="tab-pane fade in active">
                            <!-- product -->
                            <c:forEach items="${a.selectAll()}" var="productSale">
                                <div class="col-md-4 col-xs-6">
                                    <div class="product">
                                        <div class="product-img">
                                            <img src="${productSale.product.img}" alt="">
                                        </div>
                                        <div class="product-body">
                                            <p class="product-category">${productSale.product.producer.name}</p>
                                            <h3 class="product-name"><a href="sanpham.jsp?id=${productSale.product.id}">${productSale.product.name}</a></h3>
                                            <fmt:formatNumber value="${productSale.product.price}" type="number"
                                                              pattern="#,##0" var="formattedPrice"/>
                                            <fmt:formatNumber value="${productSale.discount}" type="number"
                                                              pattern="#,##0" var="formattedDiscount"/>
                                            <h4 class="product-price">${formattedPrice} VNĐ</h4>
                                            <h6 class="product-btns"> Giảm ngay: ${formattedDiscount} VND</h6>
                                            <div class="product-rating"></div>
                                        </div>
                                        <div class="add-to-cart">
                                            <form action="addcart" method="post">
                                                <input type="hidden" name="id" value="${ productSale.product.id}">
                                                <button type="submit" class="add-to-cart-btn"><i class="fa fa-shopping-cart"></i> Thêm vào giỏ hàng</button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                            <!-- /product -->
                        </div>
                        <!-- /tab -->
                    </div>
                </div>
            </div>
            <!-- /Products tab & slick -->
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
