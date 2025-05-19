<%@ page import="model.Product" %>
<%@ page import="dao.impl.ProductDAOImpl" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <link rel="icon" href="./img/logo.png" type="image/x-icon"/>

    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/slick.min.js"></script>
    <script src="js/nouislider.min.js"></script>
    <script src="js/jquery.zoom.min.js"></script>

    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/toastify-js"></script>


    <jsp:useBean id="a" class="service.impl.ProductServiceImpl" scope="request"/>

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
            <!-- Product main img -->
            <div class="col-md-5 col-md-push-2">
                <div id="product-main-img">
                    <c:forEach var="image" items="${product.images}">
                        <div class="product-preview">
                            <img src="${image.linkImage}" alt="Product Image">
                        </div>
                    </c:forEach>
                </div>
            </div>
            <!-- /Product main img -->

            <!-- Product thumb imgs -->
            <div class="col-md-2 col-md-pull-5">
                <div id="product-imgs">
                    <c:forEach var="image" items="${product.images}">
                        <div class="product-preview">
                            <img src="${image.linkImage}" alt="Product Image">
                        </div>
                    </c:forEach>
                </div>
            </div>
            <!-- /Product thumb imgs -->

            <!-- Product details -->
            <div class="col-md-5">
                <div class="product-details">
                    <h2 class="product-name">${product.name}</h2>
                    </h2>
                    <div>
                        <fmt:formatNumber value="${product.price}" type="number" pattern="#,##0" var="formattedPrice"/>
                        <h3 class="product-price">${formattedPrice} VNĐ</h3>
                    </div>
                    <p>
                    <ul>
                        <li>${product.detail}</li>
                    </ul>
                    <br>
                    <div class="add-to-cart">
                        <button class="add-to-cart-btn" data-product="${product.id}"><i class="fa fa-shopping-cart"></i>
                            Thêm vào giỏ hàng
                        </button>
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

<style>
.product-ratings {
    padding: 20px;
    background: #f8f9fa;
    border-radius: 8px;
}

.rating-summary {
    text-align: center;
    margin-bottom: 20px;
}

.rating-score {
    font-size: 24px;
    margin: 10px 0;
}

.rating-score .average {
    font-size: 36px;
    font-weight: bold;
    color: #ffc107;
}

.stars {
    margin: 10px 0;
}

.star-rating {
    display: flex;
    flex-direction: row-reverse;
    justify-content: flex-end;
}

.star-rating input {
    display: none;
}

.star-rating label {
    cursor: pointer;
    font-size: 25px;
    color: #ddd;
    margin: 0 2px;
}

.star-rating input:checked ~ label,
.star-rating label:hover,
.star-rating label:hover ~ label {
    color: #ffc107;
}

.review-item {
    border-bottom: 1px solid #dee2e6;
    padding: 15px 0;
}

.review-content {
    margin-top: 10px;
    color: #212529;
}
</style>

<!-- SECTION - RECOMMENDED PRODUCTS -->
<div class="section">
    <!-- container -->
    <div class="container">
        <!-- row -->
        <div class="row">
            <div class="col-md-12">
                <div class="section-title text-center">
                    <h3 class="title">Sản phẩm tương tự</h3>
                </div>
            </div>

            <!-- Related Products -->
            <div class="col-md-12">
                <div class="row">
                    <div class="products-tabs">
                        <!-- tab -->
                        <div id="tab1" class="tab-pane active">
                            <div class="products-slick" data-nav="#slick-nav-1">
                                <c:forEach var="relatedProduct" items="${relatedProducts}">
                                    <!-- product -->
                                    <div class="product">
                                        <div class="product-img">
                                            <c:if test="${not empty relatedProduct.images}">
                                                <img src="${relatedProduct.images[0].linkImage}" alt="${relatedProduct.name}">
                                            </c:if>
                                        </div>
                                        <div class="product-body">
                                            <h3 class="product-name">
                                                <a href="product?id=${relatedProduct.id}">${relatedProduct.name}</a>
                                            </h3>
                                            <fmt:formatNumber value="${relatedProduct.price}" type="number" pattern="#,##0" var="formattedRelatedPrice"/>
                                            <h4 class="product-price">${formattedRelatedPrice} VNĐ</h4>
                                        </div>
                                        <div class="add-to-cart">
                                            <button class="add-to-cart-btn" data-product="${relatedProduct.id}">
                                                <i class="fa fa-shopping-cart"></i> Thêm vào giỏ hàng
                                            </button>
                                        </div>
                                    </div>
                                    <!-- /product -->
                                </c:forEach>
                            </div>
                            <div id="slick-nav-1" class="products-slick-nav"></div>
                        </div>
                        <!-- /tab -->
                    </div>
                </div>
            </div>
            <!-- /Related Products -->
        </div>
        <!-- /row -->
    </div>
    <!-- /container -->
</div>
<!-- /SECTION - RECOMMENDED PRODUCTS -->

<!-- FOOTER -->
<jsp:include page="footer.jsp"/>
<script src="js/main.js"></script>
<!-- /FOOTER -->

<!-- jQuery Plugins -->
<script>
    $(document).ready(function() {
        // Initialize Slick carousel for recommended products
        $('.products-slick').slick({
            slidesToShow: 4,
            slidesToScroll: 1,
            autoplay: true,
            autoplaySpeed: 3000,
            dots: false,
            infinite: true,
            responsive: [
                {
                    breakpoint: 991,
                    settings: {
                        slidesToShow: 2,
                        slidesToScroll: 1
                    }
                },
                {
                    breakpoint: 480,
                    settings: {
                        slidesToShow: 1,
                        slidesToScroll: 1
                    }
                }
            ]
        });

        // Initialize Slick Navigation
        $('.products-slick-nav').each(function() {
            var $this = $(this);
            var $nav = $this;
            var $prevBtn = $('<div class="slick-prev"><i class="fa fa-angle-left"></i></div>');
            var $nextBtn = $('<div class="slick-next"><i class="fa fa-angle-right"></i></div>');

            $nav.append($prevBtn).append($nextBtn);

            $prevBtn.on('click', function() {
                $nav.closest('.products-tabs').find('.products-slick').slick('slickPrev');
            });

            $nextBtn.on('click', function() {
                $nav.closest('.products-tabs').find('.products-slick').slick('slickNext');
            });
        });
    });
</script>

</body>
</html>
