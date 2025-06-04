<%@ page import="model.Order" %>
<%@ page import="java.util.List" %>
<%@ page import="model.User" %>
<%@ page import="dao.impl.UserDaoImpl" %>
<%@ page import="dao.impl.OrderDAOImpl" %>
<%@ page import="service.impl.UserServiceImpl" %>
<%@ page import="utils.SessionUtil" %>
<%@ page import="java.util.Objects" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    // Kiểm tra đăng nhập và phân quyền (chỉ admin và mod mới được vào trang này)
    User userId = (User) SessionUtil.getInstance().getKey((HttpServletRequest) request, "user");
    if(userId == null ||
            (userId.getRoleId() != 1 && userId.getRoleId() != 2)) {
        response.sendRedirect("dangnhap.jsp");
    }
%>

<!DOCTYPE html>
<html>
<head lang="en">
    <title>Admin</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport"
          content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="icon" type="image/png" href="./img/logo.png"/>

    <!-- Import lib -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.css">
    <link rel="stylesheet" type="text/css" href="./css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet">
    <link type="text/css" rel="stylesheet" href="css/style.css"/>
    <!-- End import lib -->

    <link rel="stylesheet" type="text/css" href="css/styleAdmin.css">
</head>
<style>
    button.btn:disabled,
    a.btn.disabled,
    button.btn.disabled {
        background-color: #6c757d !important;
        color: white !important;
        border: none;
        cursor: not-allowed;
        opacity: 1!important;;
    }

    .type_white_color {
        color: white;
    }

</style>
<body class="overlay-scrollbar">
<!-- navbar -->
<div class="navbar">
    <!-- nav left -->
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link">
                <i class="fa-solid fa-bars" onclick="collapseSidebar()"></i>
            </a>
        </li>
        <li class="nav-item">
            <img src="./img/logo.png" alt="logo" class="logo logo-light">
        </li>
    </ul>
    <!-- end nav left -->

    <!-- nav right -->
    <ul class="navbar-nav nav-right">
        <li class="nav-item">
            <div class="avt dropdown">
                <%--                <%--%>
                <%--                    User user = (User) SessionUtil.getInstance().getKey((HttpServletRequest) request, "user");--%>
                <%--                %>--%>
                <%--                <a><i class="fa fa-user-o"></i> <%= user.getName() %></a>--%>

                <ul id="user-menu" class="dropdown-menu">
                    <li class="dropdown-menu-item">
                        <a href="logout" class="dropdown-menu-link">
                            <div>
                                <i class="fas fa-sign-out-alt"></i>
                            </div>
                            <span>Đăng xuất</span>
                        </a>
                    </li>
                </ul>
            </div>
        </li>
        <li class="nav-item">
            <div class="avt dropdown">
                <img src="./img/admin1.jpg" alt="User image" class="dropdown-toggle" data-toggle="user-menu">

            </div>
        </li>
    </ul>

    <!-- end nav right -->
</div>
<br>

<!-- end navbar -->
<!-- sidebar -->
<div class="sidebar">
    <ul class="sidebar-nav">
        <li class="sidebar-nav-item">
            <a href="/admin" class="sidebar-nav-link">
                <div>
                    <i class="fa fa-user"></i>
                </div>
                <span>Dashboard</span>
            </a>
        </li>
        <li class="sidebar-nav-item">
            <a href="/thongke" class="sidebar-nav-link" >
                <div><i class="fa-solid fa-signal"></i></div>
                <span>Thông số bán hàng</span>
            </a>
        </li>
        <li class="sidebar-nav-item">
            <a href="/quanlysanpham" class="sidebar-nav-link">
                <div><i class="fa fa-mobile"></i></div>
                <span>Quản lý sản phẩm</span>
            </a>
        </li>
        <li class="sidebar-nav-item">
            <a href="/quanlydanhmuc.jsp" class="sidebar-nav-link">
                <div><i class="fas fa-list-alt"></i></div>
                <span>Quản lý danh mục sản phẩm</span>
            </a>
        </li>
        <li class="sidebar-nav-item">
            <a href="/quanlydonhang" class="sidebar-nav-link">
                <div>
                    <i class="fa-solid fa-layer-group"></i>
                </div>
                <span>Quản lý đơn hàng</span>
            </a>
        </li>
        <li class="sidebar-nav-item">
            <a href="/quanlytaikhoan" class="sidebar-nav-link">
                <div>
                    <i class="fa-solid fa-circle-user"></i>
                </div>
                <span>Quản lý tài khoản</span>
            </a>
        </li>
        <li class="sidebar-nav-item">
            <a href="/quanlytonkho" class="sidebar-nav-link">
                <div>
                    <i class="fa-solid fa-boxes-stacked"></i>
                </div>
                <span>Quản lý tồn kho</span>
            </a>
        </li>
        <li class="sidebar-nav-item">
            <a href="/quanlylog.jsp" class="sidebar-nav-link ">
                <div>
                    <i class="fa-solid fa-clipboard-list"></i>
                </div>
                <span>Quản lý log</span>
            </a>
        </li>
    </ul>
</div>

<!-- end sidebar -->

<!-- main content -->
<div class="wrapper">
    <div class="row">
        <div class="col-8 col-m-12 col-sm-12">
            <div class="card">
                <div class="card-header" style="display: flex">
                    <h3>
                        Quản lý hóa đơn
                    </h3>
                    <a href="#addEmployeeModal" class="btn btn-success" data-toggle="modal" style="margin-left: auto">
                        <span>Thêm đơn hàng mới</span></a>
                </div>
                <div class="card-content">
                    <table>
                        <thead>

                        <tr>
                            <th>Id</th>
                            <th>Mã khách hàng</th>
                            <th>Địa chỉ giao hàng</th>
                            <th>Trạng thái đơn hàng</th>
                            <th>Phương thức thanh toán</th>
                            <th>Ngày đặt hàng</th>
                            <th>Ngày nhận hàng</th>
                            <th>Tổng tiền</th>
                            <th>Thao tác</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var ="p" items = "${orders}">
                            <tr>
                                <td>${p.getId()}
                                </td>
                                <td>${p.getUser().getId()}
                                </td>
                                <td>${p.getAddress()}
                                </td>
                                <td class="order-status" id="status-${p.id}">${p.status}</td>

                                <td>${p.getPayment_method()}
                                </td>
                                <td>${p.getOrderDate()}
                                </td>
                                <td>${p.getDeliveryDate()}
                                </td>
                                <td>${p.getTotalPrice() } VNĐ
                                </td>
                                <td>
                                    <a href="#"
                                       class="btn btn-info btn-view-order"
                                       data-toggle="modal"
                                       data-id="${p.id}">
                                        <i class="material-icons">visibility</i> Xem
                                    </a>
                                    <a href="#editOrderModal" class=
                                            "btn btn-success edit-order btn-edit
                                            ${p.status == 'Hoàn tất' || p.status == 'Hủy đơn hàng' ? 'disabled' : ''}"
                                       data-toggle="modal"  data-id="${p.id}"  data-order-id="${p.id}">
                                        <i class="material-icons">edit</i> Chỉnh sửa
                                    </a>

                                    <!-- Nút Xác nhận đã giao -->
                                    <button type="button"
                                            class="
                                            btn btn-primary btn-confirm
                                            ${p.status == 'Hoàn tất' || p.status == 'Hủy đơn hàng' ? 'disabled' : ''}"
                                            data-id="${p.id}"
                                            data-order-id="${p.id}">
                                        <i class="material-icons">check_circle</i> Xác nhận đã giao
                                    </button>

                                    <!-- Nút Hủy đơn -->
                                    <button type="button"
                                            class="btn btn-danger btn-cancel
                                            ${p.status == 'Hoàn tất' || p.status == 'Hủy đơn hàng' ? 'disabled' : ''}"
                                            data-id="${p.id}"
                                            data-order-id="${p.id}">
                                        <i class="material-icons">cancel</i> Hủy đơn
                                    </button>

                                    <!-- Nút Đặt lại trạng thái -->
                                    <button type="button"
                                            class="btn btn-warning btn-reset"
                                            data-id="${p.id}"
                                            data-order-id="${p.id}">
                                        <i class="material-icons" title="Đặt lại trạng thái là đang giao hàng">refresh</i>
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>

                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <!-- Edit-->
    <div id="editOrderModal" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <form action="/order-edit" method="post" id="editOrderForm">
                    <div class="modal-header">
                        <h4 class="modal-title">Chỉnh sửa đơn hàng</h4>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
                        <input type="hidden" name="id" id="editOrderId">
                        <div class="form-group">
                            <label>Mã khách hàng</label>
                            <input type="text" class="form-control" name="userid" id="editUserId" required>
                        </div>
                        <div class="form-group">
                            <label>Địa chỉ giao hàng</label>
                            <input type="text" class="form-control" name="address" id="editAddress" required>
                        </div>
                        <div class="form-group">
                            <label>Số điện thoại</label>
                            <input type="text" class="form-control" name="phone_number" id="editPhoneNumber" required>
                        </div>
                        <div class="form-group">
                            <label>Trạng thái</label>
                            <select name="status" id="editStatus" class="form-control">
                                <option value="Xác nhận đơn hàng">Xác nhận đơn hàng</option>
                                <option value="Chuẩn bị đơn hàng">Chuẩn bị đơn hàng</option>
                                <option value="Đang giao">Đang giao</option>
                                <option value="Hoàn tất">Hoàn tất</option>
                                <option value="Hủy đơn hàng">Hủy đơn hàng</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Ghi chú</label>
                            <input type="text" class="form-control" name="note" id="editNote">
                        </div>
                        <div class="form-group">
                            <label>Phương thức thanh toán</label>
                            <select name="payment" id="editPayment" class="form-control" required>
                                <option value="Chuyển khoản trực tiếp">Chuyển khoản trực tiếp</option>
                                <option value="Thanh toán khi nhận hàng">Thanh toán khi nhận hàng</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Ngày đặt hàng</label>
                            <input type="date" class="form-control" name="dateOrder" id="editOrderDate" required>
                        </div>
                        <div class="form-group">
                            <label>Ngày nhận hàng</label>
                            <input type="date" name="doneDate" class="form-control" id="editDeliveryDate">

                        <%--                            <input type="date" class="form-control" name="doneDate" id="editDeliveryDate" required>--%>
                        </div>
                        <div class="form-group">
                            <label>Tổng tiền</label>
                            <input type="number" class="form-control" step="1000" name="totalPrice" id="editTotalPrice" required>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <input type="button" class="btn btn-secondary" data-dismiss="modal" value="Hủy">
                        <button type="submit" class="btn btn-info">Lưu</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <!--/ Edit-->

    <!--/ Add-->
    <div id="addEmployeeModal" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <form action="/order-add" method="post">
                    <div class="modal-header">
                        <h4 class="modal-title">Thêm hóa đơn</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label>Mã khách hàng</label>
                            <input type="text" name = "userid" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label>Địa chỉ giao hàng</label>
                            <input type="text" name="address" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label>Số điện thoại</label>
                            <input type = "text" name = "phone_number" class = "form-control" required>
                        </div>
                        <div class="form-group">
                            <label>Trạng thái đơn hàng</label>
                            <select name="status" id="addStatus" class="form-control">
                                <option value="" disabled selected>Trạng thái</option>
                                <option value="Xác nhận đơn hàng">Xác nhận đơn hàng</option>
                                <option value="Chuẩn bị đơn hàng">Chuẩn bị đơn hàng</option>
                                <option value="Đang giao">Đang giao</option>
                                <option value="Hoàn tất">Hoàn tất</option>
                                <option value="Hủy đơn hàng">Hủy đơn hàng</option>
                            </select>
                        </div>
                        <div class = "form-group">
                            <label>Ghi chú</label>
                            <input type = "text" name = "note" class = "form-control" required>
                        </div>
                        <div class="form-group">
                            <label>Phương thức thanh toán</label>
                            <select name="payment" class="form-control" required>
                                <option value="" disabled selected>Phương thức thanh toán</option>
                                <option value="Chuyển khoản trực tiếp">Chuyển khoản trực tiếp</option>
                                <option value="Thanh toán khi nhận hàng">Thanh toán khi nhận hàng</option>
                            </select>

                        </div>
                        <div class="form-group">
                            <label>Ngày đặt hàng</label>
                            <input type="date" name="dateOrder" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label>Ngày nhận hàng</label>
                            <input type="date" name="doneDate" class="form-control" id="addDeliveryDate"/>

<%--                            <input type="date" name="doneDate" class="form-control" required>--%>
                        </div>
                        <div class = "form-group">
                            <label>Tổng tiền</label>
                            <input type="number" step="1000" name="totalPrice" class="form-control" required>
                        </div>

                    </div>
                    <div class="modal-footer">
                        <input type="button" class="btn btn-default" data-dismiss="modal" value="Hủy">
                        <input type="submit" class="btn btn-info" value="Thêm">
                    </div>
                </form>
            </div>
        </div>
    </div>
    <!--/ Add -->
</div>
<!-- end main content -->

<%--Modal thông báo --%>
<!-- Modal Thông báo Xóa Thành Công -->
<div id="deleteSuccessModal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Xóa Thành Công</h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body">
                <p>Sản phẩm đã được xóa thành công!</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
            </div>
        </div>
    </div>
</div>
<!-- Modal Thông báo Xóa Thành Công -->

<!-- Modal Thông báo Thêm Sản Phẩm Thành Công -->
<div id="addSuccessModal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Thêm sản phẩm thành công</h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body">
                <p>Sản phẩm đã được thêm thành công!</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
            </div>
        </div>
    </div>
</div>
<!-- Modal Thông báo Thêm Sản Phẩm Thành Công -->

<!-- Modal Thông báo Sửa Sản Phẩm Thành Công -->
<div id="editSuccessModal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Sửa sản phẩm thành công</h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body">
                <p>Sản phẩm đã được sửa thành công!</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
            </div>
        </div>
    </div>
</div>
<!-- Modal Thông báo Sửa Sản Phẩm Thành Công -->
<!-- Modal Chi tiết đơn hàng -->
<!-- Modal -->
<div class="modal fade" id="orderDetailsModal" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Chi tiết đơn hàng</h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body">
                <table class="table table-bordered">
                    <tr><th>Mã đơn hàng:</th><td id="orderId"></td></tr>
                    <tr><th>Tài khoản:</th><td id="orderCustomer"></td></tr>
                    <tr><th>Địa chỉ:</th><td id="orderAddress"></td></tr>
                    <tr><th>SĐT:</th><td id="orderPhone"></td></tr>
                    <tr><th>Trạng thái:</th><td id="orderStatus"></td></tr>
                    <tr><th>Phương thức thanh toán:</th><td id="orderPayment"></td></tr>
                    <tr><th>Ngày đặt hàng:</th><td id="orderDate"></td></tr>
                    <tr><th>Ngày giao:</th><td id="doneDate"></td></tr>
                    <tr><th>Ghi chú:</th><td id="orderNote"></td></tr>
                    <tr><th>Tổng tiền:</th><td id="orderTotal"></td></tr>
                </table>

                <h5>Sản phẩm trong đơn hàng</h5>
                <table class="table table-striped">
                    <thead>
                    <tr>
                        <th>Id</th>
                        <th>Tên sản phẩm</th>
                        <th>Số lượng</th>
                        <th>Đơn giá</th>
                        <th>Thành tiền</th>
                    </tr>
                    </thead>
                    <tbody id="orderDetailBody"></tbody>
                </table>
            </div>
        </div>
    </div>
</div>



<%--Modal phần chi tiết order--%>



<!-- import script -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js"></script>
<script src="js/admin.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>





<!--Script Xóa Sản Phẩm-->
<script>
    function deleteProduct(productId) {
        document.getElementById('productIdToDelete').value = productId;
        $('#deleteEmployeeModal').modal('show');
    }

    function submitDeleteForm() {
        document.getElementById('deleteForm').submit();
        $('#deleteEmployeeModal').modal('hide');
    }
</script>
<!--Script Xóa Sản Phẩm-->
<!--Script Sửa Đơn Hàng-->
<script>
    // Khi modal chỉnh sửa đơn hàng sắp hiển thị
    $('#editOrderModal').on('show.bs.modal', function (event) {
        const button = $(event.relatedTarget); // nút được click
        const modal = $(this);

        // Lấy dữ liệu từ các thuộc tính data-*
        modal.find('#editOrderId').val(button.data('id'));
        modal.find('#editUserId').val(button.data('user_id'));
        modal.find('#editAddress').val(button.data('address'));
        modal.find('#editPhoneNumber').val(button.data('phone_number'));
        modal.find('#editStatus').val(button.data('status'));
        modal.find('#editNote').val(button.data('note'));
        modal.find('#editPayment').val(button.data('payment'));

        const formatDate = (dateStr) => {
            if (!dateStr) return '';
            const d = new Date(dateStr);
            return d.toISOString().split('T')[0];
        };

        modal.find('#editOrderDate').val(formatDate(button.data('order_date')));
        modal.find('#editDeliveryDate').val(formatDate(button.data('delivery_date')));
        modal.find('#editTotalPrice').val(button.data('total_price'));
    });

    // Hàm submit form
    function submitEditOrderForm() {
        document.getElementById('editOrderForm').submit();
        $('#editOrderModal').modal('hide');
    }
</script>
<script>
    $(document).ready(function () {
        <% Boolean editSuccess = (Boolean) session.getAttribute("editOrderSuccess"); %>
        <% if (editSuccess != null && editSuccess) { %>
        $('#editSuccessModal').modal('show');
        <% session.removeAttribute("editOrderSuccess"); %>
        <% } %>
    });
</script>
<!-- Modal Thông báo Sửa Sản Phẩm Thành Công -->



<!--Script Thông báo Xóa Sản Phẩm-->
<script>
    $(document).ready(function () {
        <% Boolean deleteSuccess = (Boolean)request.getSession().getAttribute("deleteOrderSuccess"); %>
        <% if (deleteSuccess != null && deleteSuccess) { %>
        $('#deleteSuccessModal').modal('show');
        <% request.getSession().removeAttribute("deleteSuccess"); %>
        <% } %>
    });
</script>
<!--Script Thông báo Xóa Sản Phẩm-->


<!--Script Thông báo Thêm Sản Phẩm-->
<script>
    $(document).ready(function () {
        <% Boolean addOrderSuccess = (Boolean)request.getSession().getAttribute("addOrderSuccess"); %>
        <% if (Objects.nonNull(addOrderSuccess) && addOrderSuccess) { %>
        $('#addSuccessModal').modal('show');
        <% request.getSession().removeAttribute("addOrderSuccess"); %>
        <% } %>
    });
</script>
<!--Script Thông báo Thêm Sản Phẩm-->


<%--AJAX XỬ LÍ PHẦN DỮ LIỆU FORM EDIT--%>
<script>
    $(document).on('click', '.edit-order', function (e) {
        e.preventDefault();
        const id = $(this).data('id');
        console.log("📝 Edit Order ID:", id);

        $.ajax({
            url: "/order-edit?orderId=" + id,
            method: "GET",
            dataType: "json",
            success: function (order) {
                $('#editOrderId').val(order.id);
                $('#editUserId').val(order.user.id);
                $('#editAddress').val(order.address);
                $('#editPhoneNumber').val(order.phone_number);
                $('#editStatus').val(order.status);
                $('#editNote').val(order.note);
                $('#editPayment').val(order.payment_method);

                // Format ngày
                const formatDate = (datetime) => {
                    if (!datetime) return "";
                    const dateObj = new Date(datetime);
                    return dateObj.toISOString().split('T')[0];
                };

                var statusDropdown = $('#editStatus');
                statusDropdown.empty(); // Xóa các option cũ

                const statuses = [
                    "Xác nhận đơn hàng",
                    "Chuẩn bị đơn hàng",
                    "Đang giao",
                    "Hoàn tất",
                    "Hủy đơn hàng"
                ];

                statuses.forEach(function(status) {
                    const selected = (order.status && order.status.trim() === status) ? 'selected' : '';
                    statusDropdown.append('<option value="' + status + '" ' + selected + '>' + status + '</option>');
                });

                // Cập nhật phương thức thanh toán
                var paymentDropdown = $('#editPayment');
                paymentDropdown.empty(); // Xóa các option cũ

                const payments = [
                    "Chuyển khoản trực tiếp",
                    "Thanh toán khi nhận hàng"
                ];

                payments.forEach(function(payment) {
                    const selected = (order.payment_method && order.payment_method.trim() === payment) ? 'selected' : '';
                    paymentDropdown.append('<option value="' + payment + '" ' + selected + '>' + payment + '</option>');
                });


                $('#editOrderDate').val(formatDate(order.orderDate));
                $('#editDeliveryDate').val(formatDate(order.deliveryDate));
                $('#editTotalPrice').val(order.totalPrice);

                $('#editOrderModal').modal('show');
            },
            error: function () {
                alert("❌ Không thể lấy thông tin đơn hàng!");
            }
        });
    });
</script>

<%--AJAX--%>


<script>
    function setOrderStatus(orderId, status) {
        $.post("/order-set-status", { id: orderId, status: status }, function () {
            updateButtonState(orderId, status);
        });
    }

    // Hàm cập nhật giao diện các nút và ô trạng thái
    function updateButtonState(orderId, status) {
        const confirmBtn = $('button.btn-confirm[data-order-id="' + orderId + '"]');
        const cancelBtn = $('button.btn-cancel[data-order-id="' + orderId + '"]');
        const editBtn = $('a.btn-edit[data-id="' + orderId + '"]');
        const resetBtn = $('button.btn-reset[data-order-id="' + orderId + '"]');

        // Reset: bật lại tất cả
        confirmBtn.prop('disabled', false).removeClass('disabled');
        cancelBtn.prop('disabled', false).removeClass('disabled');
        editBtn.prop('disabled', false).removeClass('disabled');
        resetBtn.prop('disabled', false).removeClass('disabled');

        if (status === "Hoàn tất") {
            confirmBtn.prop('disabled', true).addClass('disabled');
            cancelBtn.prop('disabled', true).addClass('disabled');
            editBtn.prop('disabled', true).addClass('disabled');
        } else if (status === "Hủy đơn hàng") {
            confirmBtn.prop('disabled', true).addClass('disabled');
            cancelBtn.prop('disabled', true).addClass('disabled');
            editBtn.prop('disabled', true).addClass('disabled');
        }

        // Cập nhật status trong bảng
        $('#status-' + orderId).text(status);
    }

    // Gắn sự kiện click cho từng nút
    $(document).on('click', '.btn-confirm', function () {
        const id = $(this).data('id');
        setOrderStatus(id, "Hoàn tất");
    });

    $(document).on('click', '.btn-cancel', function () {
        const id = $(this).data('id');
        setOrderStatus(id, "Hủy đơn hàng");
    });

    $(document).on('click', '.btn-reset', function () {
        const id = $(this).data('id');
        setOrderStatus(id, "Đang giao");
    });
</script>


<script>
    $(document).on('click', '.btn-view-order', function () {
        const orderId = $(this).data('id');
        console.log("🔍 Đang lấy đơn hàng ID:", orderId);

        $.ajax({
            url: "/order-view?id=" + orderId,
            method: "GET",
            dataType: "json",
            success: function (data) {
                console.log("✅ Dữ liệu nhận được:", data);

                const order = data.order;
                const details = data.details;

                // Hiển thị thông tin đơn hàng
                $('#orderId').text(order.id);
                $('#orderCustomer').text(order.user.username);
                $('#orderAddress').text(order.address);
                $('#orderPhone').text(order.phone_number);
                $('#orderStatus').text(order.status);
                $('#orderPayment').text(order.payment_method);
                $('#orderDate').text(order.orderDate.split("T")[0]);
                // $('#doneDate').text(order.deliveryDate.split("T")[0]);
                if (order.deliveryDate) {
                    $('#doneDate').text(order.deliveryDate.split("T")[0]);
                } else {
                    $('#doneDate').text("Chưa được giao");
                }
                $('#orderNote').text(order.note || '');
                $('#orderTotal').text(Number(order.totalPrice).toLocaleString() + " VND");

                // Tạo nội dung chi tiết đơn hàng
                let htmlDetails = "";
                details.forEach((item, index) => {
                    console.log("🔍 Item:", item);

                    const product = item.product || {}; // fallback rỗng nếu null
                    const productName = product.name || "Tên không xác định";
                    const quantity = item.quantity ?? '0';
                    const productPrice = product.price != null
                        ? Number(product.price).toLocaleString()
                        : '0';
                    const amount = item.amount != null
                        ? Number(item.amount).toLocaleString()
                        : '0';

                    htmlDetails += "<tr>" +
                        "<td>" + (index + 1) + "</td>" +
                        "<td>" + productName + "</td>" +
                        "<td>" + quantity + "</td>" +
                        "<td>" + productPrice + " VND</td>" +
                        "<td>" + amount + " VND</td>" +
                        "</tr>";

                });

                console.log("✅ htmlDetails tạo ra:", htmlDetails);
                $('#orderDetailBody').html(htmlDetails);
                $('#orderDetailsModal').modal('show');


            },
            error: function (xhr) {
                console.error("❌ Lỗi khi gọi API:", xhr.responseText);
                $('#orderDetailBody').html("<tr><td colspan='5' class='text-danger'>Không thể tải chi tiết đơn hàng.</td></tr>");
                $('#orderDetailsModal').modal('show');
            }
        });
    });

</script>

<script>
    function toggleDeliveryRequired(statusId, deliveryId) {
        const status = document.getElementById(statusId);
        const deliveryInput = document.getElementById(deliveryId);

        if (!status || !deliveryInput) return;

        if (status.value === "Hoàn tất") {
            deliveryInput.setAttribute("required", "required");
        } else {
            deliveryInput.removeAttribute("required");
        }
    }

    document.addEventListener("DOMContentLoaded", function () {
        // Gọi cho Edit
        const editStatus = document.getElementById("editStatus");
        if (editStatus) {
            editStatus.addEventListener("change", function () {
                toggleDeliveryRequired("editStatus", "editDeliveryDate");
            });
            toggleDeliveryRequired("editStatus", "editDeliveryDate");
        }

        // Gọi cho Add
        const addStatus = document.getElementById("addStatus");
        if (addStatus) {
            addStatus.addEventListener("change", function () {
                toggleDeliveryRequired("addStatus", "addDeliveryDate");
            });
            toggleDeliveryRequired("addStatus", "addDeliveryDate");
        }
    });
</script>

<!-- end import script -->
</body>
</html>