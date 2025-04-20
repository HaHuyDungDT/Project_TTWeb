<%@ page import="dao.impl.UserDaoImpl" %>
<%@ page import="model.User" %>
<%@ page import="dao.impl.OrderDAOImpl" %>
<%@ page import="model.Order" %>
<%@ page import="java.util.List" %>
<%@ page import="dao.impl.OrderDetailDAOImpl" %>
<%@ page import="model.OrderDetails" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1"> <!-- Phù hợp mọi loại màn hình -->


    <title>Thông tin người dùng</title>

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
    <link rel="stylesheet" href="css/information.css">
    <link type="text/css" rel="stylesheet" href="css/style.css"/>
    <link rel="icon" href="./img/logo.png" type="image/x-icon"/>

    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/slick.min.js"></script>
    <script src="js/nouislider.min.js"></script>
    <script src="js/jquery.zoom.min.js"></script>

    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/toastify-js"></script>

    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/toastify-js"></script>

    <jsp:useBean id="a" class="dao.impl.UserDaoImpl" scope="request"/>

    <style>

        .top, .card-content th {
            color: white;
        }

        .billing-details .top{
            color: yellowgreen;
        }

        .button-container {
            display: flex;
            justify-content: space-between;
            gap: 10px;
        }

        .button-container .btn {
            flex: 1;  /* This ensures both buttons take equal space */
            padding: 10px;
            text-align: center;
        }

        .button-container .btn-primary {
            background-color: #28a745;
            color: white;
        }

        .button-container .btn-secondary {
            background-color: #dc3545;
            color: white;
        }
        .card-content table {
            width: 100%; /* Make the table width take up the full available space */
            table-layout: fixed; /* Ensures columns take equal space */
        }

        .card-content th {
            white-space: nowrap; /* Prevent text from wrapping */
            padding: 10px; /* Add some padding for better readability */
        }

        .card-content td {
            padding: 10px; /* Add some padding for better readability */
        }

        .order-detail {
            width: 100%; /* Ensure the container takes up full width */
        }
    </style>

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
            <div class="col-md-7">
                <!-- Billing Details -->
                <div class="billing-details">
                    <div class="section-title">
                        <h5 class="title">Thông tin người dùng</h5>
                    </div>
                    <%
                        UserDaoImpl userDAO = new UserDaoImpl();
                        User user = userDAO.getUserByUserId(Integer.valueOf(request.getParameter("id")));
                    %>
                    <div class="form-group">
                        <div class="top">Tên Người Dùng</div>
                        <div class="bot"><%=user.getName()%>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="top">Email</div>
                        <div class="bot"><%=user.getEmail()%>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="top">Tên đăng nhập</div>
                        <div class="bot"><%=user.getName()%>
                        </div>
                    </div>
                </div>
                <!-- /Billing Details -->
            </div>
            <div class="order-detail" style="width: 950px; height: 297px; border-radius: 10px 10px 0 0">
                <div class="detail">
                    <div class="detail">
                        <div class="title-2">Đơn hàng đã đặt</div>
                        <div>
                            <div class="card-content" style="width: 873px; max-height: 250px; border-bottom: none">
                                <table>
                                    <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Địa chỉ</th>
                                        <th>Trạng thái</th>
                                        <th>Thanh toán</th>
                                        <th>Đặt hàng</th>
                                        <th>Nhận hàng</th>
                                        <th>Tổng</th>
                                        <th>Xác thực</th>
                                        <th>Chi tiết</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <%
                                        OrderDAOImpl orderDAO = new OrderDAOImpl();

                                        List<Order> orders = orderDAO.findByIdUser(Integer.valueOf(request.getParameter("id")));

                                        for (Order order : orders) {
                                    %>
                                    <tr style="background-color: #fff2db">
                                        <td><%=order.getId()%>
                                        </td>
                                        <td><%=order.getAddress()%>
                                        </td>
                                        <td><%=order.getStatus()%>
                                        </td>
                                        <td><%=order.getPayment_method()%>
                                        </td>
                                        <td><%=order.getOrderDate()%>
                                        </td>
                                        <td><%=order.getDeliveryDate()%>
                                        </td>
                                        <td><strong class="order-total">
                                            <fmt:formatNumber value="<%=order.getTotalPrice()%>" type="number"
                                                              pattern="#,##0" var="formattedPrice"/>
                                            <h5 class="product-price">${formattedPrice} VNĐ</h5>
                                        </strong>
                                        </td>
                                        <td>
                                            <% if (!order.getStatus().equals("Đã xác thực")) { %>
                                            <a href="xacthuc.jsp?id=<%=order.getId()%>">
                                                <img src="https://cdn-icons-png.flaticon.com/128/1828/1828843.png"
                                                     width="35px" height="35px" style="margin-left: 10px" alt="Xác thực">
                                            </a>
                                            <% } else { %>
                                            <img src="https://cdn-icons-png.flaticon.com/128/190/190411.png"
                                                 width="35px" height="35px" style="margin-left: 10px" alt="Đã xác thực">
                                            <% } %>
                                        </td>

                                        <td>
                                            <div style="display: flex; justify-content: center; align-items: center;">
                                                <a href="chitietdonhang.jsp?id=<%=order.getId()%>&userId=<%= order.getUser().getId() %>">
                                                    <img src="https://cdn-icons-png.flaticon.com/128/9183/9183248.png"
                                                         width="30px" height="30px" style="margin-left: 10px"
                                                         alt="Chi tiết">
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                    <div class="modal fade" id="orderDetailModal<%=order.getId()%>" tabindex="-1"
                                         role="dialog"
                                         aria-labelledby="orderDetailLabel<%=order.getId()%>" aria-hidden="true">
                                        <div class="modal-dialog" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="orderDetailLabel<%=order.getId()%>">Chi
                                                        tiết đơn hàng</h5>
                                                    <button type="button" class="close" data-dismiss="modal"
                                                            aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                                                </div>
                                                <%
                                                    OrderDetailDAOImpl orderDetailsDAO = new OrderDetailDAOImpl();
                                                    List<OrderDetails> orderDetails = orderDetailsDAO.findByIdOrder(order.getId());
                                                    for (OrderDetails orderDetail : orderDetails) {
                                                %>
                                                <div class="modal-body">
                                                    <p><strong>Mã sản phẩm:</strong> <%=orderDetail.getId()%>
                                                    </p>
                                                    <p><strong>Số lượng:</strong> <%=orderDetail.getId()%>
                                                    </p>
                                                    <p><strong>Đơn giá:</strong> <fmt:formatNumber
                                                            value="<%=orderDetail.getAmount()%>" type="number"
                                                            pattern="#,##0"/> VNĐ</p>
                                                    <p><strong>Khuyến mãi:</strong> <fmt:formatNumber
                                                            value="<%=orderDetail.getDiscount()%>" type="number"
                                                            pattern="#,##0"/> VNĐ</p>
                                                    <p><strong>Thành tiền:</strong> <fmt:formatNumber
                                                            value="<%=orderDetail.getAmount()*orderDetail.getQuantity()%>" type="number"
                                                            pattern="#,##0"/> VNĐ</p>
                                                    <%
                                                        }
                                                    %>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary"
                                                            data-dismiss="modal">Đóng
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <%
                                        }
                                    %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /row -->
            </div>
            <!-- /container -->
        </div>
        <!-- /SECTION -->
    </div>
</div>
<!-- FOOTER -->
<jsp:include page="footer.jsp"/>
<!-- /FOOTER -->
<!-- jQuery Plugins -->

<script src="js/main.js"></script>

</body>

</html>