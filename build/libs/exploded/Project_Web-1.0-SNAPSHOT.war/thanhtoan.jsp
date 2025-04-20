<%@ page import="java.util.Map" %>
<%@ page import="Model.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="Cart.CartProduct" %>
<%@ page import="Cart.Cart" %>
<%@ page import="java.util.HashMap" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1"> <!-- Phù hợp mọi loại màn hình -->


    <title>Thanh toán</title>

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


    <jsp:useBean id="a" class="DAO.OrderDetailsDAO" scope="request"/>
    <jsp:useBean id="b" class="DAO.OrderDAO" scope="request"/>
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
                    <li class="active">Thanh toán</li>
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
            <form id="orderForm" action="./order" method="post">
                <div class="col-md-7">
                    <c:if test="${error != null}">
                        <p class="alert alert-danger">${error}</p>
                    </c:if>
                    <!-- Billing Details -->
                    <div class="billing-details">
                        <div class="section-title">
                            <h3 class="title">Thông tin thanh toán</h3>
                        </div>
                        <div class="form-group">
                            <input class="input" type="text" name="name" placeholder="Họ và tên" required value="${name}">
                        </div>
                        <div class="form-group">
                            <input class="input" type="email" name="email" placeholder="Email" required value="${email}">
                        </div>
                        <div class="form-group">
                            <input class="input" type="text" name="delivery_address" placeholder="Địa chỉ nhận hàng" required>
                        </div>
                        <div class="form-group">
                            <input class="input" type="tel" name="phone_number" placeholder="Số điện thoại" required value="${phone_number}">
                        </div>

                    </div>
                    <!-- /Billing Details -->

                    <!-- Shiping Details -->
                    <div class="shiping-details">
                        <div class="section-title">
                            <h3 class="title">Yêu cầu khác</h3>
                        </div>

                    </div>
                    <!-- /Shiping Details -->

                    <!-- Order notes -->
                    <div class="order-notes">
                        <textarea class="input" placeholder="Yêu cầu khác(Không bắt buộc)"></textarea>
                    </div>
                    <!-- /Order notes -->
                </div>

                <!-- Order Details -->
                <div class="col-md-5 order-details">
                    <div class="section-title text-center">
                        <h3 class="title">Đơn hàng của bạn</h3>
                    </div>
                    <div class="order-summary">
                        <div class="order-col">
                            <div><strong>SẢN PHẨM</strong></div>
                            <div><strong>GIÁ</strong></div>
                        </div>
                        <% Cart cart = (Cart) session.getAttribute("cart");
                            List<CartProduct> cartProducts = cart != null ? cart.getCartProducts() : null;
                            double totalAmout = 0;
                            if (cart != null) {
                                for (CartProduct cartProduct : cartProducts) {
                                    totalAmout += cartProduct.getProduct().getPrice() * cartProduct.getQuantity();
                        %>
                        <div class="order-products">
                            <div class="order-col">
                                <div><%= cartProduct.getQuantity() %>X</div>
                                <div><%= cartProduct.getProduct().getName() %>
                                </div>
                                <div>
                                    <fmt:formatNumber value="<%=cartProduct.getProduct().getPrice()%>" type="number"
                                                      pattern="#,##0"
                                                      var="formattedPrice"/>
                                    <h5 class="product-price">${formattedPrice} VNĐ</h5>
                                </div>
                            </div>
                        </div>
                        <% }%>
                        <div class="order-col">
                            <div>Phí vận chuyển</div>
                            <div><strong>Miễn Phí</strong></div>
                        </div>
                        <div class="order-col">
                            <div><strong>TỔNG TIỀN</strong></div>
                            <div>
                                <strong class="order-total"><fmt:formatNumber value="<%=totalAmout%>" type="number"
                                                                              pattern="#,##0"
                                                                              var="formattedPrice"/>
                                    <h5 class="product-price">${formattedPrice} VNĐ</h5></strong>
                            </div>
                        </div>
                    </div>
                    <% } else {
                    }%>
                    <h5>HÌNH THỨC THANH TOÁN</h5>
                    <div class="payment-method">
                        <div class="input-radio">
                            <input type="radio" name="payment" id="payment-1" value="Chuyển khoản trực tiếp">
                            <label for="payment-1">
                                <span></span>
                                Chuyển khoản trực tiếp
                            </label>
                            <div class="caption">
                                <p>Quý khách vui lòng chuyển khoản qua số tài khoản: 0973206403 với nội dung là : Số
                                    điện
                                    thoại + Họ và tên</p>
                            </div>
                        </div>
                        <div class="input-radio">
                            <input type="radio" name="payment" id="payment-2" value="Thanh toán khi nhận hàng">
                            <label for="payment-2">
                                <span></span>
                                Thanh toán khi nhận hàng
                            </label>
                            <div class="caption">
                                <p>Sản phẩm sẽ được gửi tới cho quý khách theo địa chỉ nhận hàng. Quý khách nhận sản
                                    phẩm và
                                    thanh toán cho người giao hàng</p>
                            </div>
                        </div>
                    </div>
                    <div class="input-checkbox">
                        <input type="checkbox" id="terms" required>
                        <label for="terms">
                            <span></span>
                            Tôi đã đọc và chấp nhận <a href="chinhsachbaomat.jsp">các điều khoản trên</a>
                        </label>
                        <button onclick="validateForm()" data-toggle="modal" class="primary-btn order-submit">Đặt hàng</button>
                    </div>
                    <!-- /Order Details -->
                </div>
            </form>
            <!-- /row -->
        </div>
        <!-- /container -->
    </div>

    <!-- Order-->
    <div id="oderEmployeeModal" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">Bạn đã đặt hàng thành công</h4>
                </div>
                <div class="modal-footer">
                    <button id="confirmOrderBtn" onclick="confirmOrder()" type="button" class="btn btn-danger">Xác nhận</button>
                </div>
            </div>
        </div>
    </div>
    <!--/ Order-->

    <!-- /SECTION -->
</div>
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

<script>
    function validateForm() {
        var orderForm = document.getElementById('orderForm');
        var selectedPayment = document.querySelector('input[name="payment"]:checked');
        var checkbox = document.getElementById('terms');
        if (checkbox.checked && orderForm.checkValidity() && selectedPayment) {
            $('#oderEmployeeModal').modal('show');
        } else {
            alert("Vui lòng điền đầy đủ thông tin và đồng ý với các điều khoản.");
        }
    }

    function confirmOrder() {
        $('#oderEmployeeModal').modal('hide');
        window.location.href = 'index.jsp';
    }

</script>

<script>
    $(document).ready(function () {
        <% Boolean OrderSuccess = (Boolean)request.getSession().getAttribute("OrderSuccess");%>
        <% if (OrderSuccess != null && OrderSuccess) { %>
        $('#oderEmployeeModal').modal('show');
        <% request.getSession().removeAttribute("OrderSuccess"); %>
        <% } %>
    });
</script>

</body>
</html>
