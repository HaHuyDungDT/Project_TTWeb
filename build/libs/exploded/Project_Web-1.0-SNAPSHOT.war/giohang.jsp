<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" href="./img/logo.png" type="image/x-icon"/>
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">
    <link type="text/css" rel="stylesheet" href="css/bootstrap.min.css"/>
    <link type="text/css" rel="stylesheet" href="css/slick.css"/>
    <link type="text/css" rel="stylesheet" href="css/slick-theme.css"/>
    <link type="text/css" rel="stylesheet" href="css/nouislider.min.css"/>
    <link rel="stylesheet" href="css/font-awesome.min.css">
    <link type="text/css" rel="stylesheet" href="css/style.css"/>
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/slick.min.js"></script>
    <script src="js/nouislider.min.js"></script>
    <script src="js/jquery.zoom.min.js"></script>
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
    <title>Giỏ hàng</title>
</head>
<body>
<jsp:include page="header.jsp"/>
<jsp:include page="menu.jsp"/>
<div id="breadcrumb" class="section">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <ul class="breadcrumb-tree">
                    <li><a href="index.jsp">Trang chủ</a></li>
                    <li class="active">Giỏ hàng</li>
                </ul>
            </div>
        </div>
    </div>
</div>
<div class="container main-section">
    <div class="row">
        <div class="col-lg-12 pl-3 pt-3">
            <table class="table table-hover border bg-white">
                <thead>
                <tr>
                    <input type="checkbox" id="selectAll" onchange="selectAll()"> Chọn tất cả<br>
                    <th>
                        <h4><b>Thông tin sản phẩm</b></h4>
                    </th>
                    <th style="width:20%;">
                        <h4><b>Đơn Giá</b></h4>
                    </th>
                    <th style="width:10%;">
                        <h4><b>Số lượng</b></h4>
                    </th>
                    <th style="width:20%;">
                        <h4><b>Số tiền</b></h4>
                    </th>
                    <th>
                        <h4><b>Xóa</b></h4>
                    </th>
                </tr>
                </thead>
                <form id="checkoutForm" action="check-out" method="post">
                    <tbody>
                    <c:forEach items="${cartItems}" var="item">
                        <tr class="cart-item" id="item-${item.product.id}">
                            <td>
                                <input type="checkbox" class="productCheckbox" name="selectedProductIds"
                                       value="${item.product.id}"
                                       data-price="${item.product.price}"
                                       data-quantity="${item.quantity}"
                                       onchange="updateTotalAmount()" style="margin-left: -30px; position: absolute;">

                                <div class="row">
                                    <div class="col-lg-2 Product-img">
                                        <img src="${item.product.images[0].linkImage}" alt=".   .."
                                             class="img-responsive"/>
                                    </div>
                                    <div class="col-lg-10">
                                        <h5 class="nomargin"><b>${item.product.name}
                                        </b></h5>
                                        <p></p>
                                    </div>
                                </div>
                                <input type="hidden" name="${item.product.id}"
                                       value="${item.product.name}"/>
                            </td>
                            <fmt:formatNumber value="${item.product.price}" type="number" pattern="#,##0"
                                              var="formattedPrice"/>
                            <td class="product-price"><strong class="product-price">${formattedPrice} VNĐ</strong></td>
                            <td data-th="Quantity">
                                <div class="input-group quantity mx-auto" style="width: 100px;">
                                    <div class="input-group-btn">
                                        <button type="button" class="btn btn-sm btn-primary btn-minus"
                                                style="background: #5cb85c; border: none">
                                            <i class="fa fa-minus"></i>
                                        </button>
                                    </div>
                                    <input type="text" class="form-control bg-secondary text-center"
                                           value="${item.quantity}">
                                    <div class="input-group-btn">
                                        <button type="button" class="btn btn-sm btn-primary btn-plus"
                                                style="background: #5cb85c; border: none">
                                            <i class="fa fa-plus"></i>
                                        </button>
                                    </div>
                                </div>
                            </td>
                            <fmt:formatNumber value="${item.product.price * item.quantity}" type="number"
                                              pattern="#,##0" var="formattedPrice1"/>
                            <td id="subtotal-${item.product.id}"><strong class="total-price">${formattedPrice1}
                                VNĐ</strong></td>
                            <td class="actions" data-th="" style="width:10%;"><p data-toggle="modal"
                                                                                 data-product-id="${item.product.id}"
                                                                                 data-target="#delete"
                                                                                 class="btn btn-danger btn-sm delete-product">
                                <i class="fa fa-trash-o"></i></p>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                    <tfoot>
                    <tr>
                        <td><a href="index.jsp" class="btn btn-success "> <i class="fa fa-angle-left"> </i> Tiếp tục mua
                            sắm</a></td>
                        <td colspan="2" class="hidden-xs"></td>
                        <td class="hidden-xs text-center" style="width:10%;">
                            <span id="totalAmountLabel" style="font-weight: bold;">
                            <strong>Tổng tiền : <fmt:formatNumber value="${totalPrice}" type="number" pattern="#,##0" /></strong>
                            </span>
                        </td>
                        <td>
                            <input type="submit" id="paybutton" name="action" class="btn btn-success btn-block"
                                   value="Thanh toán">
                        </td>
                    </tr>
                    </tfoot>
                </form>
            </table>
            <div id="delete" class="modal fade">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title">Xóa sản phẩm này khỏi giỏ hàng</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-footer">
                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Hủy">
                            <input type="hidden" name="productId" value="${item.product.id}">
                            <button id="confirm-delete" type="button" class="btn btn-danger">Xóa</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp"/>
<script>
    $('.btn-minus').click(function () {
        var input = $(this).closest('.input-group').find('input');
        var newValue = parseInt(input.val()) - 1;
        if (newValue >= 1) {
            input.val(newValue);
            var productId = $(this).closest('.cart-item').attr('id').split('-')[1];
            updateQuantity(productId, newValue);
        }
    });

    $('.btn-plus').click(function () {
        var input = $(this).closest('.input-group').find('input');
        var newValue = parseInt(input.val()) + 1;
        input.val(newValue);
        var productId = $(this).closest('.cart-item').attr('id').split('-')[1];
        updateQuantity(productId, newValue);
    });

    $('.quantity input').change(function () {
        var newValue = parseInt($(this).val());
        if (newValue >= 1) {
            var productId = $(this).closest('.cart-item').attr('id').split('-')[1];
            updateQuantity(productId, newValue);
        } else {
            $(this).val(1);
            var productId = $(this).closest('.cart-item').attr('id').split('-')[1];
            updateQuantity(productId, 1);
        }
    });

    function updateQuantity(productId, quantity) {
        var data = {
            productId: productId,
            quantity: quantity
        };
        $.ajax({
            url: '/update-quantity-cart-item',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(data),
            success: function (response) {
                updateCartItem(productId, response.newPrice);
                updateTotalAmount();
            },
            error: function (xhr) {
                Toastify({
                    text: 'Cập nhật thất bại',
                    duration: 3000,
                    newWindow: true,
                    close: true,
                    gravity: "top",
                    position: "right",
                    stopOnFocus: true,
                    style: {
                        background: "#D10024",
                    },
                    onClick: function () {
                    }
                }).showToast();
            }
        });
    }

    const formatter = Intl.NumberFormat('vi-VN', {
        style: 'currency',
        currency: 'VND'
    });

    function updateCartItem(productId, newPrice) {
        var cartItem = $('#item-' + productId);
        var totalElement = cartItem.find('.total-price');
        totalElement.text(formatter.format(newPrice).replace(/₫/, 'VNĐ'));
    }

    function updateTotalAmount() {
        $.ajax({
            url: '/cart/total', // đường dẫn servlet/controller xử lý
            type: 'GET',
            dataType: 'json',
            success: function (data) {
                // Format tiền theo kiểu Việt Nam
                var formattedAmount = new Intl.NumberFormat('vi-VN').format(data.totalAmount);
                $('#totalAmountLabel').html('<strong>Tổng tiền : ' + formattedAmount + '</strong>');
            },
            error: function () {
                console.error("Không thể cập nhật tổng tiền.");
            }
        });
    }

    // Gọi hàm khi số lượng thay đổi
    $(document).ready(function () {
        $('.form-control').on('change', function () {
            // Có thể gửi thêm AJAX cập nhật số lượng tại đây nếu muốn
            updateTotalAmount(); // Sau khi cập nhật, gọi hàm này
        });
    });

</script>
<script>
    $('#checkoutForm').on('submit', function (event) {
        var checkboxes = $('input[name="selectedProductIds"]:checked');
        if (checkboxes.length === 0) {
            event.preventDefault();
            Toastify({
                text: "Vui lòng chọn ít nhất một sản phẩm trước khi thanh toán",
                duration: 3000,
                newWindow: true,
                close: true,
                gravity: "top",
                position: "right",
                stopOnFocus: true,
                style: {
                    background: "#D10024",
                },
                onClick: function () {
                }
            }).showToast();
        }
    });

    $('#selectAll').on('change', function () {
        var isChecked = $(this).is(':checked');
        $('input[name="selectedProductIds"]').prop('checked', isChecked);
        updateTotalAmount();
    });

    $('input[name="selectedProductIds"]').on('change', function () {
        updateTotalAmount();
    });
</script>
<script>
    function removeCartItem(productId) {
        $.ajax({
            url: 'api/remove-cart-item?productId=' + productId,
            type: 'DELETE',
            success: function (response) {
                $('#item-' + productId).remove();
                $(`#delete`).modal('hide');
                const totalItem = $(`#cart-quantity`);
                totalItem.text(parseInt(totalItem.text()) - 1);
            },
            error: function (error) {
                console.error('Có lỗi xảy ra khi xóa sản phẩm:', error);
            }
        });
    }

    $(document).ready(function () {
        $('.delete-product').click(function () {
            let productId = $(this).data('product-id');
            $(`#delete`).data('product-id', productId);
        });

        $('#confirm-delete').click(function () {
            let productId = $(`#delete`).data('product-id');
            removeCartItem(productId);
        });
    });
</script>
<script src="js/main.js"></script>
</body>
</html>
