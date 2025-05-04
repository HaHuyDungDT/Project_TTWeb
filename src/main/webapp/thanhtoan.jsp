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
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">
    <link type="text/css" rel="stylesheet" href="css/bootstrap.min.css"/>
    <link type="text/css" rel="stylesheet" href="css/slick.css"/>
    <link type="text/css" rel="stylesheet" href="css/slick-theme.css"/>
    <link type="text/css" rel="stylesheet" href="css/nouislider.min.css"/>
    <link rel="stylesheet" href="css/font-awesome.min.css">
    <link type="text/css" rel="stylesheet" href="css/style.css"/>
    <link rel="icon" href="./img/logo.png" type="image/x-icon"/>
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/slick.min.js"></script>
    <script src="js/nouislider.min.js"></script>
    <script src="js/jquery.zoom.min.js"></script>
    <jsp:useBean id="a" class="dao.impl.OrderDetailDAOImpl" scope="request"/>
    <jsp:useBean id="b" class="dao.impl.CouponImpl" scope="request"/>
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
</head>
<body>
<jsp:include page="header.jsp"/>
<jsp:include page="menu.jsp"/>
<div id="breadcrumb" class="section">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <ul class="breadcrumb-tree">
                    <li><a href="#">Trang chủ </a></li>
                    <li class="active">Thanh toán</li>
                </ul>
            </div>
        </div>
    </div>
</div>
<div class="section">
    <div class="container">
        <div class="row">
            <form id="orderForm" action="order" method="post" onsubmit="updateAddress()">
                <div class="col-md-7">
                    <c:if test="${error != null}">
                        <p class="alert alert-danger">${error}</p>
                    </c:if>
                    <div class="billing-details">
                        <div class="section-title">
                            <h3 class="title">Thông tin thanh toán</h3>
                        </div>
                        <div class="form-group">
                            <input class="input" type="text" name="name" placeholder="Họ và tên" required
                                   value="${name}">
                        </div>
                        <div class="form-group">
                            <input class="input" type="email" name="email" placeholder="Email" required
                                   value="${email}">
                        </div>
                        <div class="container-address col-12"
                             style="display: flex; flex-direction: row; justify-content: space-between">
                            <div class="form-group col-3">
                                <select class="form-select form-control" id="province-select" name="province">
                                    <option value="">--Chọn Tỉnh Thành--</option>
                                </select>
                            </div>
                            <div class="form-group  col-3">
                                <select class="form-select form-control" id="district-select" name="district">
                                    <option value="">--Chọn Quận Huyện--</option>
                                </select>
                            </div>
                            <div class="form-group col-3">
                                <select class="form-select form-control" id="ward-select" name="ward">
                                    <option value="">--Chọn Phường Xã--</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <input class="input" type="tel" name="phone_number" placeholder="Số điện thoại" required
                                   value="${phone_number}">
                        </div>
                    </div>
                    <div class="shiping-details">
                        <div class="section-title">
                            <h3 class="title">Yêu cầu khác</h3>
                        </div>
                    </div>
                    <div class="order-notes">
                        <textarea name="note" class="input" placeholder="Yêu cầu khác(Không bắt buộc)"></textarea>
                    </div>
                </div>
                <div class="col-md-5 order-details">
                    <div class="section-title text-center">
                        <h3 class="title">Đơn hàng của bạn</h3>
                    </div>
                    <div class="order-summary">
                        <div class="order-col">
                            <div><strong>SẢN PHẨM</strong></div>
                            <div><strong>GIÁ</strong></div>
                        </div>
                        <c:set var="totalPrice" value="0"/>
                        <div class="order-products">
                            <c:forEach var="item" items="${selectedProductsList}" >
                                <div class="order-col" data-product-id="${item.product.id}" data-selected="true">
                                    <div>${item['quantity']} X</div>
                                    <div>${item.product.name}</div>
                                    <div>
                                        <fmt:formatNumber value="${item.product.price}" type="number" pattern="#,##0" var="formattedPrice"/>
                                        <h5 class="product-price"
                                            data-product-id="${item.product.id}"
                                            data-original-price="${item.product.price}"
                                            data-coupon-id="${item.product.couponId}">${formattedPrice} VNĐ</h5>
                                    </div>
                                </div>
                                <c:set var="totalPrice" value="${totalPrice + (item.product.price * item.quantity)}"/>
                            </c:forEach>
                        </div>
                        <c:set var="totalPrice" value="${totalPrice}" />
                        <c:if test="${not empty sessionScope.coupons}">
                            <div class="order-col">
                                <div>Chọn mã giảm giá</div>
                                <div>
                                    <select name="selectedCouponId" id="couponSelect" onchange="calculateDiscount()">
                                        <c:forEach var="coupon" items="${sessionScope.coupons}">
                                            <option value="${coupon.id}" data-discount="${coupon.percent_discount}">
                                                    ${coupon.code} - ${coupon.percent_discount}%
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                        </c:if>
                        <div class="order-col">
                            <div>Phí vận chuyển</div>
                            <div id="fee-delivery">
                                <strong class="order-total">
                                    <h5 class="product-price total" id="formattedPrice">0 VNĐ</h5>
                                </strong>
                            </div>
                        </div>
                        <div class="order-col">
                            <div><strong>TỔNG TIỀN</strong></div>
                            <div>
                                <strong class="order-total">
                                    <fmt:formatNumber value="${totalPrice}" type="number" pattern="#,##0"
                                                      var="formattedPrice"/>
                                    <h5 id="product-price" class="product-price total">${formattedPrice} VNĐ</h5>
                                </strong>
                            </div>
                        </div>
                    </div>
                    <h5>HÌNH THỨC THANH TOÁN</h5>
                    <div class="payment-method">
                        <div class="input-radio">
                            <input type="radio" name="payment" id="payment-1" value="Chuyển khoản trực tiếp">
                            <label for="payment-1">
                                <span></span>
                                Chuyển khoản trực tiếp
                            </label>
                            <div class="caption">
                                <p>Quý khách vui lòng quét mã để chuyển khoản với nội dung: Họ tên người mua + số điện
                                    thoại</p>
                                <img id="qr_code" alt="qr_code" src="" style="width: 200px; height: 200px"/>
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
                        <input type="hidden" id="selectedProvince" name="selectedProvince">
                        <input type="hidden" id="selectedDistrict" name="selectedDistrict">
                        <input type="hidden" id="selectedWard" name="selectedWard">
                        <input type="hidden" id="hiddenTotalPrice" name="totalPrice" value="${totalPrice}" />
                        <button onclick="validateForm()" data-toggle="modal" class="primary-btn order-submit">Đặt hàng
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <div id="oderEmployeeModal" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">Bạn đã đặt hàng thành công</h4>
                </div>
                <div class="modal-footer">
                    <button id="confirmOrderBtn" onclick="confirmOrder()" type="button" class="btn btn-danger">Xác
                        nhận
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp"/>
<script src="js/main.js"></script>
<script>
    $("#payment-1").change(() => {
        var productPriceText = $('.product-price.total').text();
        productPriceText = productPriceText.replace(' VNĐ', '');
        productPriceText = productPriceText.replace('.', '');
        var price = parseInt(productPriceText);
        payByVNPay(price);
    });

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
    };
    function payByVNPay(amount) {
        $.ajax({
            type: "POST",
            url: "https://api.vietqr.io/v2/generate",
            header: {
                'x-client-id': 'c04356b0-1f95-4f7b-8032-f423154ad6d2',
                'x-api-key': '459490ee-74af-4645-ad59-e47be0dd3f8e',
                'Content-Type': 'application/json'
            },
            data: {
                "accountNo": "31410004064069",
                "accountName": "Hà Huy Dũng",
                "acqId": "970418",
                "addInfo": "Thanh Toán mua hàng",
                "amount": amount,
                "template": "compact"
            },
            success: function (response) {
                $("#qr_code").attr("src", response.data.qrDataURL);
            },
            error: function (xhr, status, error) {
                console.error("Error sending payment method:", error);
            }
        });
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

<script>
    // Function to update selected values and submit form
    function updateAddress() {
        var provinceSelect = document.getElementById('province-select');
        var districtSelect = document.getElementById('district-select');
        var wardSelect = document.getElementById('ward-select');

        var provinceName = provinceSelect.options[provinceSelect.selectedIndex].text;
        var districtName = districtSelect.options[districtSelect.selectedIndex].text;
        var wardName = wardSelect.options[wardSelect.selectedIndex].text;

        // Set the names to hidden fields or directly to form fields
        document.getElementById('selectedProvince').value = provinceName;
        document.getElementById('selectedDistrict').value = districtName;
        document.getElementById('selectedWard').value = wardName;

        fetchAndUpdateTotalPrice();
    }
</script>
<script>
    var originalTotalPrice = 0;

    document.addEventListener('DOMContentLoaded', function() {
        var totalPriceElement = document.getElementById('product-price');
        originalTotalPrice = parseInt(totalPriceElement.textContent.replace(' VNĐ', '').replace(/,/g, '')) || 0;
    });

    function calculateDiscount() {
        var selectElement = document.getElementById('couponSelect');
        if (!selectElement) return;

        var selectedCouponId = selectElement.value;
        var discountPercent = parseFloat(selectElement.options[selectElement.selectedIndex].getAttribute('data-discount')) || 0;

        var orderProducts = document.querySelectorAll('.order-products .order-col');

        orderProducts.forEach(function(productRow) {
            var productPriceElement = productRow.querySelector('.product-price');
            var originalPrice = parseFloat(productPriceElement.getAttribute('data-original-price'));
            var productCouponId = productPriceElement.getAttribute('data-coupon-id');

            var discountedPrice = originalPrice;
            if (productCouponId === selectedCouponId) {
                discountedPrice = originalPrice * (1 - discountPercent / 100);
            }

            var formattedDiscountedPrice = discountedPrice.toFixed(0).replace(/\B(?=(\d{3})+(?!\d))/g, ',') + ' VNĐ';
            productPriceElement.textContent = formattedDiscountedPrice;
        });

        updateTotalAmount();
    }

    function updateTotalPrice(shippingFee) {
        // Lấy tổng giá sản phẩm ban đầu
        var totalPriceElement = document.getElementById('product-price');
        var totalPriceText = totalPriceElement.textContent.replace(' VNĐ', '').replace(/\./g, '');
        var totalPrice = parseInt(totalPriceText) || 0;

        // Áp dụng giảm giá nếu có
        var couponSelect = document.getElementById('couponSelect');
        if (couponSelect) {
            var discountPercent = parseFloat(couponSelect.options[couponSelect.selectedIndex].getAttribute('data-discount')) || 0;
            totalPrice = totalPrice * (1 - discountPercent / 100);
        }

        // Cộng thêm phí vận chuyển
        totalPrice += shippingFee;

        // Định dạng lại số tiền
        var formattedTotal = new Intl.NumberFormat('vi-VN').format(totalPrice) + ' VNĐ';

        // Cập nhật lên giao diện
        totalPriceElement.textContent = formattedTotal;

        // Cập nhật vào hidden field để submit form
        document.getElementById('hiddenTotalPrice').value = totalPrice;
    }

    function fetchAndUpdateTotalPrice() {
        var couponId = document.getElementById('couponSelect')?.value || "";

        var shippingFeeText = document.getElementById('formattedPrice').textContent.replace(' VNĐ', '').replace(/\./g, '');
        var shippingFee = parseInt(shippingFeeText) || 0;

        $.ajax({
            url: 'update-total-price',
            type: 'POST',
            data: {
                couponId: couponId,
                shippingFee: shippingFee
            },
            success: function(response) {
                if (response && response.totalPrice !== undefined) {
                    var formatted = new Intl.NumberFormat('vi-VN').format(response.totalPrice) + ' VNĐ';
                    document.getElementById('product-price').textContent = formatted;
                    document.getElementById('hiddenTotalPrice').value = response.totalPrice;
                }
            },
            error: function(xhr, status, error) {
                console.error("Update total price failed", error);
            }
        });
    }




</script>


</body>
</html>
