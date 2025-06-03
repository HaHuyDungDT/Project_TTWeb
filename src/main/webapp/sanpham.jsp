<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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

    <jsp:useBean id="productService" class="service.impl.ProductServiceImpl" scope="request"/>
    <jsp:useBean id="userService" class="service.impl.UserServiceImpl" scope="request"/>
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
            
            <!-- Product Rating Section -->
            <div class="col-md-12">
                <div class="product-rating-section">
                    <h3 class="rating-title">Đánh giá sản phẩm</h3>
                    
                    <div class="row">
                        <!-- Rating Overview -->
                        <div class="col-md-3">
                            <div id="rating">
                                <div class="rating-avg">
                                    <c:set var="avg" value="${ratingService.getAverageRating(product.id)}"/>
                                    <c:set var="fullStars" value="${fn:substringBefore(avg, '.')}" />
                                    <c:set var="decimal" value="${avg - fullStars}" />
                                    <c:set var="halfStar" value="${decimal >= 0.25 && decimal < 0.75 ? 1 : 0}" />
                                    <c:set var="emptyStars" value="${5 - fullStars - halfStar}" />
                                    <div class="rating-stars">
                                        <c:forEach begin="1" end="${fullStars}" var="i">
                                            <i class="fa fa-star text-warning" style="color: #D10024"></i>
                                        </c:forEach>
                                        <c:if test="${halfStar == 1}">
                                            <i class="fa fa-star-half-stroke text-warning" style="color: #D10024"></i>
                                        </c:if>
                                        <c:forEach begin="1" end="${emptyStars}" var="i">
                                            <i class="fa fa-star-o text-muted" style="color: #D10024"></i>
                                        </c:forEach>
                                    </div>
                                </div>
                                <c:set var="stars" value="${fn:split('5,4,3,2,1', ',')}" />
                                <ul class="rating">
                                    <c:forEach var="star" items="${stars}">
                                        <li>
                                            <div class="rating-stars">
                                                <c:forEach begin="1" end="5" var="i">
                                                    <i class="fa ${i <= star ? 'fa-star text-warning' : 'fa-star-o text-muted'}"></i>
                                                </c:forEach>
                                            </div>
                                            <div class="rating-progress">
                                                <c:set var="totalRatings" value="${ratingService.getRatingCount(product.id)}"/>
                                                <c:set var="starRatings" value="${ratingService.getRatingCountByStar(product.id, star)}"/>
                                                <div style="width: ${totalRatings > 0 ? (starRatings * 100 / totalRatings) : 0}%;"></div>
                                            </div>
                                            <span class="sum">${starRatings}</span>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                        <!-- /Rating Overview -->

                        <!-- Rating List -->
                        <div class="col-md-6">
                            <div id="reviews">
                                <ul class="reviews">
                                    <c:forEach var="rating" items="${ratingService.findByProductId(product.id)}">
                                        <li>
                                            <div class="review-heading">
                                                <h5 class="name">
                                                    <c:choose>
                                                        <c:when test="${not empty rating.userId}">
                                                            Khách hàng #${rating.userId}
                                                        </c:when>
                                                        <c:otherwise>
                                                            Khách hàng
                                                        </c:otherwise>
                                                    </c:choose>
                                                </h5>
                                                <p class="date">
                                                    <fmt:formatDate value="<%= new java.util.Date() %>" pattern="dd/MM/yyyy"/>
                                                </p>
                                                <div class="review-rating">
                                                    <c:forEach begin="1" end="5" var="i">
                                                        <i class="${i <= rating.star ? 'fa-solid fa-star text-warning' : 'fa-regular fa-star text-muted'}"></i>
                                                    </c:forEach>
                                                </div>
                                            </div>
                                            <div class="review-body">
                                                <p>${rating.comment}</p>
                                            </div>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                        <!-- /Rating List -->

                        <!-- Review Form -->
                        <div class="col-md-3">
                            <div class="review-form">
                                <h3>Viết đánh giá của bạn</h3>
                                <c:if test="${sessionScope.user != null}">
                                    <c:if test="${ratingService.hasUserPurchasedProduct(sessionScope.user.id, product.id)}">
                                        <c:if test="${!ratingService.hasUserRated(sessionScope.user.id, product.id)}">
                                            <form action="rating" method="post">
                                                <input type="hidden" name="productId" value="${product.id}">
                                                <div class="rating-input">
                                                    <label>Đánh giá của bạn:</label>
                                                    <div class="stars">
                                                        <c:forEach begin="1" end="5" var="star">
                                                            <input type="radio" id="star${star}" name="star" value="${star}" required>
                                                            <label for="star${star}"><i class="fas fa-star"></i></label>
                                                        </c:forEach>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label for="comment">Nhận xét của bạn:</label>
                                                    <textarea id="comment" name="comment" rows="4" required></textarea>
                                                </div>
                                                <button type="submit" class="btn-submit">Gửi đánh giá</button>
                                            </form>
                                        </c:if>
                                        <c:if test="${ratingService.hasUserRated(sessionScope.user.id, product.id)}">
                                            <p class="already-rated">Bạn đã đánh giá sản phẩm này.</p>
                                        </c:if>
                                    </c:if>
                                    <c:if test="${!ratingService.hasUserPurchasedProduct(sessionScope.user.id, product.id)}">
                                        <p class="purchase-required">Bạn cần mua sản phẩm này để có thể đánh giá.</p>
                                    </c:if>
                                </c:if>
                                <c:if test="${sessionScope.user == null}">
                                    <p class="login-required">Vui lòng <a href="login">đăng nhập</a> để đánh giá sản phẩm.</p>
                                </c:if>
                            </div>
                        </div>
                        <!-- /Review Form -->
                    </div>
                </div>
            </div>
            <!-- /Product Rating Section -->
            
            <!-- /product tab -->
        </div>
        <!-- /row -->
    </div>
    <!-- /container -->
</div>
<!-- /SECTION -->
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
