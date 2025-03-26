<%@ page import="Cart.Cart" %>
<%@ page import="Cart.CartProduct" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"  language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

    <title>Giỏ hàng</title>

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

    <jsp:useBean id="a" class="dao.NewProductDAO" scope="request"/>
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
                    <li class="active">Giỏ hàng</li>
                </ul>
            </div>
        </div>
        <!-- /row -->
    </div>
    <!-- /container -->
</div>
<!-- /BREADCRUMB -->

<!-- SECTION -->
<%
    Cart cart = (Cart) session.getAttribute("cart");
    List<CartProduct> cartProducts = cart != null ? cart.getCartProducts() : null;

    if (cart != null) {

%>
<div class="container main-section">
    <div class="row">

    <div class="col-lg-12 pl-3 pt-3">
            <table class="table table-hover border bg-white">
                <thead>
                <tr>
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
                <tbody>

                <% for (CartProduct cartProduct : cartProducts) { %>
                <tr>
                    <td>
                        <div class="row">
                            <div class="col-lg-2 Product-img">
                                <img src="<%=cartProduct.getProduct().getImg()%>" alt="..." class="img-responsive"/>
                            </div>
                            <div class="col-lg-10">
                                <h5 class="nomargin"> <b> <%=cartProduct.getProduct().getName()%></b> </h5>
                                <p> </p>
                            </div>
                        </div>
                    </td>
                    <fmt:formatNumber value="<%=cartProduct.getProduct().getPrice()%>" type="number" pattern="#,##0"
                                      var="formattedPrice"/>
                    <td> <strong> ${formattedPrice} VND</strong> </td>
                    <td data-th="Quantity">
                        <div class="input-group quantity-control">
                            <button class="btn btn-outline-secondary decrease-qty" data-id="<%= cartProduct.getProduct().getId() %>">-</button>
                            <input type="text" class="form-control text-center quantity-input" data-id="<%= cartProduct.getProduct().getId() %>"
                                   value="<%= cartProduct.getQuantity() %>" min="1">
                            <button class="btn btn-outline-secondary increase-qty" data-id="<%= cartProduct.getProduct().getId() %>">+</button>
                        </div>
                    </td>


                    <fmt:formatNumber value="<%=cartProduct.getProduct().getPrice()*cartProduct.getQuantity()%>" type="number" pattern="#,##0"
                                      var="formattedPrice1"/>
                    <td> <strong> ${formattedPrice1} VND</strong> </td>
                    <td class="actions" data-th="" style="width:10%;">
                        <!-- Delete-->
                        <div id="deleteEmployeeModal_<%= cartProduct.getProduct().getId() %>" class="modal fade">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <form action="delcart" method="post">
                                        <div class="modal-header">
                                            <h4 class="modal-title">Xóa sản phẩm này khỏi giỏ hàng</h4>
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                        </div>
                                        <div class="modal-footer">
                                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Hủy">
                                            <input type="hidden" name="productId" value="<%= cartProduct.getProduct().getId()%>">
                                            <input type="submit" class="btn btn-danger" value="Xóa">
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <!--/ Delete-->
                        <button data-toggle="modal" data-target="#deleteEmployeeModal_<%= cartProduct.getProduct().getId() %>" class="btn btn-danger btn-sm"> <i class="fa fa-trash-o"> </i> </button>
                    </td>
                </tr>
                <%
                        }
                %>
                </tbody>
                <tfoot>
                <tr>
                    <td> <a href="index.jsp" class="btn btn-success "> <i class="fa fa-angle-left"> </i> Tiếp tục mua sắm </a> </td>
                    <td colspan="2" class="hidden-xs"> </td>

                    <td class="hidden-xs text-center" style="width:10%;">
                        <fmt:formatNumber value="<%= cart.amount(cartProducts) %>" type="number" pattern="#,##0"
                                          var="formattedPrice2"/>
                        <strong>Tổng tiền : ${formattedPrice2} VND</strong>
                    </td>

                    <td> <a href="thanhtoan.jsp" class="btn btn-success btn-block"> Thanh toán <i class="fa fa-angle-right"> </i> </a> </td>
                </tr>
                </tfoot>
            </table>
        </div>
        <%
            } else { %>
        <!-- Xử lý khi giỏ hàng không tồn tại -->
        <a  style=" text-align: center; margin-left: 500px; font-size: 30px" >
            <strong>Giỏ hàng trống</strong>
            <br>
            <br>
            <a href="index.jsp" class="btn btn-success " style="margin-left: 540px;"> <i class="fa fa-angle-left"> </i> Tiếp tục mua sắm </a>
            <br>
        </a>
        <% } %>
    </div>
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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function () {
        $(".increase-qty, .decrease-qty").click(function () {
            let productId = $(this).data("id");
            let inputField = $(".quantity-input[data-id='" + productId + "']");
            let currentQty = parseInt(inputField.val());
            let newQty = $(this).hasClass("increase-qty") ? currentQty + 1 : currentQty - 1;

            if (newQty < 1) return;

            updateCartQuantity(productId, newQty);
        });

        $(".quantity-input").change(function () {
            let productId = $(this).data("id");
            let newQty = parseInt($(this).val());

            if (isNaN(newQty) || newQty < 1) {
                $(this).val(1);
                newQty = 1;
            }

            updateCartQuantity(productId, newQty);
        });

        function updateCartQuantity(productId, quantity) {
            $.ajax({
                url: "<%= request.getContextPath() %>/updateCart",
                type: "POST",
                data: { productId: productId, quantity: quantity },
                success: function (response) {
                    location.reload();
                },
                error: function () {
                    alert("Có lỗi xảy ra khi cập nhật số lượng!");
                }
            });
        }
    });
</script>

</body>
</html>
