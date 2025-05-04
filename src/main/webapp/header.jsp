<%--
  Created by IntelliJ IDEA.
  User: hadun
  Date: 11/12/2023
  Time: 10:17 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %> <!-- Import model.User -->
<html>
<head>
    <title>Header</title>
    <link rel="icon" type="image/png" href="./img/logo.png"/>
    <style>
        .auth-link {
            color: #fff;              /* Màu trắng */
            font-size: 14px;          /* Kích thước nhỏ hơn */
            margin-right: 15px;       /* Khoảng cách giữa các liên kết */
            text-decoration: none;    /* Bỏ gạch chân nếu có */
        }
        .auth-link:last-child {
            margin-right: 0;
        }

        #search-results {
            position: absolute;
            background-color: white;
            width: 100%;
            max-height: 200px;
            overflow-y: auto;
            box-shadow: 0px 5px 10px rgba(0, 0, 0, 0.1);
            border: 1px solid #ddd;
            z-index: 999;
            display: none; /* Ban đầu ẩn dropdown */
        }

        .search-result-item {
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }

        .search-result-item a {
            text-decoration: none;
            color: #333;
            display: block;
        }

        .search-result-item:hover {
            background-color: #f1f1f1;
        }

        .no-results {
            padding: 10px;
            color: #888;
        }

        #search-results.show {
            display: block;
        }

    </style>
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
                <c:set var="user" value="${sessionScope.user}" />
                <c:if test="${not empty user}">
                    <a href="profile?userId=${user.id}" class="auth-link"><i class="fa fa-user-o"></i> ${user.name}</a>
                    <a href="logout" class="auth-link"><i class="fa fa-sign-out-alt"></i> Đăng xuất</a>
                </c:if>
                <c:if test="${empty user}">
                    <a href="dangky.jsp" class="auth-link"><i class="fa fa-user-o"></i> Đăng kí</a>
                    <a href="dangnhap.jsp" class="auth-link"><i class="fa fa-user-o"></i> Đăng nhập</a>
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
                        <a href="index.jsp" class="logo">
                            <img src="img/logo.png" alt="">
                        </a>
                    </div>
                </div>
                <!-- /LOGO -->

                <!-- SEARCH BAR -->
                <div class="col-md-6">
                    <div class="header-search" style="position: relative;">
                        <form action="${pageContext.request.contextPath}/productList" method="get" id="searchForm">
                            <input class="input" id="searchInput" name="query" placeholder="Tìm kiếm tại đây">
                            <div id="search-results" class="search-results"></div>
                            <input class="search-btn" type="submit" name="" value="Tìm kiếm">
                        </form>
                    </div>
                </div>
                <!-- /SEARCH BAR -->

                <!-- ACCOUNT -->
                <div class="col-md-3 clearfix">
                    <div class="header-ctn">
                        <!-- cart -->
                        <div class="dropdown">
                            <a class="dropdown-toggle" href="display-cart">
                                <i class="fa fa-shopping-cart"></i>
                                <span>Giỏ Hàng</span>
                                <div id="cart-quantity" class="qty"><c:out value="${totalItem}"/></div>
                            </a>
                        </div>
                        <!-- /cart -->

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
<script>
    $(document).ready(function () {
        const user = <%= session.getAttribute("user") != null ? "true" : "false" %>;
        if (user) {
            $.ajax({
                url: 'api/cart/total-cart-item',
                method: 'GET',
                dataType: 'json',
                success: function (response) {
                    $('#cart-quantity').text(response);
                },
                error: function (xhr, status, error) {
                    console.error('Failed to fetch cart count:', error);
                    $('#cart-quantity').text("0");
                }
            });
        } else {
            $('#cart-quantity').text("0");
        }
    });

    $(document).ready(function () {
        $('#searchInput').on('input', function() {
            var query = $(this).val();
            if (query.length > 2) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/autocomplete',
                    method: 'GET',
                    data: { query: query },
                    dataType: 'json',
                    success: function(response) {
                        var resultHtml = '';
                        if (response.length > 0) {
                            response.forEach(function(product) {
                                resultHtml += `<div class="search-result-item">
    <a href="${pageContext.request.contextPath}/productList?id=\${product.id}">
       \${product.name} - \${product.price} VND
    </a>
</div>`;
                            });
                        } else {
                            resultHtml = '<div class="no-results">Không tìm thấy sản phẩm nào</div>';
                        }
                        $('#search-results').html(resultHtml).addClass('show');
                    },
                    error: function(xhr, status, error) {
                        console.error('Lỗi khi tìm kiếm:', error);
                        $('#search-results').html('<div class="no-results">Không thể tìm kiếm</div>').addClass('show');
                    }
                });
            } else {
                $('#search-results').html('').removeClass('show');
            }
        });

        $(document).click(function(event) {
            if (!$(event.target).closest('#searchInput').length) {
                $('#search-results').removeClass('show');
            }
        });
    });

</script>
</body>
</html>

