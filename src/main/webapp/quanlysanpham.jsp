<%@ page import="model.Product" %>
<%@ page import="dao.impl.ProductDAOImpl" %>
<%@ page import="java.util.List" %>
<%@ page import="dao.impl.ProductTypeDAOImpl" %>
<%@ page import="dao.impl.ProductDAOImpl" %>
<%@ page import="java.util.Objects" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="service.impl.UserServiceImpl" %>
<%@ page import="utils.SessionUtil" %>
<%@ page import="model.User" %>
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

    <jsp:useBean id="a" class="dao.impl.ProductDAOImpl" scope="request"></jsp:useBean>
    <jsp:useBean id="b" class="dao.impl.ProductDAOImpl" scope="request"></jsp:useBean>
    <jsp:useBean id="c" class="dao.impl.ProductTypeDAOImpl" scope="request"></jsp:useBean>
</head>
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
        <li class="nav-item dropdown">
            <a class="nav-link">
                <i class="fas fa-bell dropdown-toggle" data-toggle="notification-menu"></i>
                <span class="navbar-badge">1</span>
            </a>
            <ul id="notification-menu" class="dropdown-menu notification-menu">
                <div class="dropdown-menu-header">
						<span>
							Thông báo
						</span>
                </div>
                <div class="dropdown-menu-content overlay-scrollbar scrollbar-hover">
                    <li class="dropdown-menu-item">
                        <a href="#" class="dropdown-menu-link">
                            <div>
                                <i class="fas fa-gift"></i>
                            </div>
                            <span>
									Thông báo kết thúc khuyến mãi
									<br>
									<span>
										15/07/2020
									</span>
								</span>
                        </a>
                    </li>
                </div>
                <div class="dropdown-menu-footer">
						<span>
						</span>
                </div>
            </ul>
        </li>

        <li class="nav-item avt-wrapper">
            <div class="avt dropdown">
                <img src="./img/admin1.jpg" alt="User image" class="dropdown-toggle" data-toggle="user-menu">
                <ul id="user-menu" class="dropdown-menu">
                    <li class="dropdown-menu-item">
                        <a class="dropdown-menu-link">
                            <div>
                                <i class="fas fa-user-tie"></i>
                            </div>
                            <span>Thông tin cá nhân</span>
                        </a>
                    </li>
                    <li class="dropdown-menu-item">
                        <a href="#" class="dropdown-menu-link">
                            <div>
                                <i class="fas fa-sign-out-alt"></i>
                            </div>
                            <span>Đăng xuất</span>
                        </a>
                    </li>
                </ul>
            </div>
        </li>
    </ul>
    <!-- end nav right -->
</div>
<!-- end navbar -->
<br>

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
                        Quản lý sản phẩm
                    </h3>
                    <a href="#addEmployeeModal" class="btn btn-success" data-toggle="modal" style="margin-left: auto">
                        <span>Thêm sản phẩm mới</span></a>

                </div>
                <div class="card-content">
                    <table>
                        <thead>
                        <tr>
                            <th>#</th>
                            <th>Tên sản phẩm</th>
                            <th>Giá</th>
                            <th>Số lượng</th>
                            <th>Loại sản phẩm</th>
                            <th>Nhà sản xuất</th>
                            <th>Trạng thái</th>
                            <th>Ngày nhập</th>
                            <th>Mã giảm giá</th>
                            <th>Hình ảnh</th>
                            <th>Hành động</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="p" items="${products}">
                            <tr>
                                <td>${p.id}</td>
                                <td>${p.name}</td>
                                <td>
                                    <fmt:formatNumber value="${p.price}" type="number" pattern="#,##0" /> VNĐ
                                </td>
                                <td>${p.quantity}</td>
                                <td>${p.productType.name}</td>  <!-- Lấy tên loại sản phẩm -->
                                <td>${p.producer.name}</td>     <!-- Lấy tên nhà sản xuất -->
                                <td>${p.status}</td>
                                <td><fmt:formatDate value="${p.import_date}" pattern="dd/MM/yyyy" /></td> <!-- Định dạng ngày nhập -->
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty p.couponId}">
                                            ${p.couponId}
                                        </c:when>
                                        <c:otherwise>
                                            Không có
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:forEach var="image" items="${p.images}">
                                        <img src="${image.linkImage}" alt="Product Image" style="width: 50px; height: 50px;">
                                    </c:forEach>
                                </td>
                                <td>
                                    <!-- Nút Edit -->
                                    <a href="#editEmployeeModal" class="edit" data-toggle="modal" data-product-id="${p.id}">
                                        <i class="material-icons" data-toggle="tooltip" title="Edit">&#xE254;</i>
                                    </a>
                                    <!-- Nút Delete -->
                                    <a href="#deleteEmployeeModal" class="delete" data-toggle="modal" onclick="deleteProduct(${p.id})">
                                        <i class="material-icons" data-toggle="tooltip" title="Delete">&#xE872;</i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>

                    <div class="pagination" style="margin-top: 20px; text-align: right;">
                        <c:if test="${currentPage > 1}">
                            <a href="quanlysanpham?page=${currentPage - 1}" class="btn btn-outline-primary btn-sm mr-1">&laquo; Prev</a>
                        </c:if>

                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <c:choose>
                                <c:when test="${i == currentPage}">
                                    <span class="btn btn-primary btn-sm mr-1 disabled">${i}</span>
                                </c:when>
                                <c:otherwise>
                                    <a href="quanlysanpham?page=${i}" class="btn btn-outline-primary btn-sm mr-1">${i}</a>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>

                        <c:if test="${currentPage < totalPages}">
                            <a href="quanlysanpham?page=${currentPage + 1}" class="btn btn-outline-primary btn-sm">Next &raquo;</a>
                        </c:if>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <!-- Edit-->
    <div id="editEmployeeModal" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <!-- Form chỉnh sửa sản phẩm -->
                <form id="editForm" action="/quanlysanpham/product-edit" method="POST" enctype="multipart/form-data">
                    <div class="modal-header">
                        <h4 class="modal-title">Sửa thông tin sản phẩm</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    </div>
                    <div class="modal-body">
                        <input type="hidden" name="id" id="editProductId">
                        <div class="form-group">
                            <label>Tên sản phẩm</label>
                            <input name="name" id="editProductName" type="text" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label>Giá</label>
                            <input name="price" id="editProductPrice" type="text" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label>Số lượng</label>
                            <input name="quantity" id="editProductQuantity" type="number" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label>Mô tả</label>
                            <textarea name="detail" id="editProductDetail" class="form-control" required></textarea>
                        </div>
                        <!-- Loại sản phẩm -->
                        <div class="form-group">
                            <label>Loại sản phẩm</label>
                            <select name="productType" id="editProductType" class="form-control" required>
                                <!-- Các lựa chọn sẽ được điền tự động qua AJAX -->
                            </select>
                        </div>

                        <!-- Hãng sản xuất -->
                        <div class="form-group">
                            <label>Hãng sản xuất</label>
                            <select name="producer" id="editProductProducer" class="form-control" required>
                                <!-- Các lựa chọn sẽ được điền tự động qua AJAX -->
                            </select>
                        </div>

                        <div class="form-group">
                            <label>Trạng thái</label>
                            <select name="status" id="editProductStatus" class="form-control" required>
                                <option value="available">Còn hàng</option>
                                <option value="out_of_stock">Hết hàng</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Ngày nhập</label>
                            <input type="date" name="import_date" id="editProductImportDate" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label>Mã giảm giá</label>
                            <input name="couponId" id="editProductCouponId" type="text" class="form-control">
                        </div>
                        <div class="form-group">
                            <label>Ảnh sản phẩm hiện tại</label>
                            <img id="currentProductImage" src="" alt="Current Product Image" style="width: 100px; height: 100px;">
                        </div>

                        <!-- Cho phép người dùng tải lên ảnh mới -->
                        <div class="form-group">
                            <label>Chọn ảnh sản phẩm mới (nếu có)</label>
                            <input type="file" name="imageFile" class="form-control">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <input type="button" class="btn btn-default" data-dismiss="modal" value="Hủy">
                        <input type="submit" class="btn btn-info" value="Lưu">
                    </div>
                </form>
            </div>
        </div>
    </div>
    <!--/ Edit-->

    <!-- Delete-->
    <div id="deleteEmployeeModal" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <form id="deleteForm" action="/quanlysanpham/product-delete" method="post">
                    <div class="modal-header">
                        <h4 class="modal-title">Xóa sản phẩm này</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    </div>
                    <div class="modal-body">
                        <p>Bạn có chắc chắn muốn xóa sản phẩm này?</p>
                        <p class="text-warning"><small>Hành động này sẽ không thể hoàn lại.</small></p>
                    </div>
                    <div class="modal-footer">
                        <input type="button" class="btn btn-default" data-dismiss="modal" value="Hủy">
                        <input type="submit" class="btn btn-danger" value="Xóa" onclick="submitDeleteForm()">
                        <input type="hidden" id="productIdToDelete" name="productIdToDelete" value="">
                    </div>
                </form>
            </div>
        </div>
    </div>
    <!--/ Delete-->
    <!--/ Add-->
    <div id="addEmployeeModal" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <form action="/quanlysanpham/product-add" method="POST" enctype="multipart/form-data">
                    <div class="modal-header">
                        <h4 class="modal-title">Thêm sản phẩm mới</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label>Tên sản phẩm</label>
                            <input name="name" type="text" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label>Giá</label>
                            <input name="price" type="text" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label>Số lượng</label>
                            <input name="quantity" type="number" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label>Mô tả</label>
                            <textarea name="detail" class="form-control" required></textarea>
                        </div>
                        <div class="form-group">
                            <label>Loại sản phẩm</label>
                            <select name="productType" class="form-control" required>
                                <c:forEach items="${productTypes}" var="pt">
                                    <option value="${pt.id}">${pt.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Hãng sản xuất</label>
                            <select name="producer" class="form-control" required>
                                <c:forEach items="${producers}" var="pc">
                                    <option value="${pc.id}">${pc.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Trạng thái</label>
                            <select name="status" class="form-control" required>
                                <option value="available">Còn hàng</option>
                                <option value="out_of_stock">Hết hàng</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Ngày nhập</label>
                            <input type="date" name="import_date" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label>Mã giảm giá</label>
                            <input name="couponId" type="text" class="form-control">
                        </div>

                        <div class="form-group">
                            <label>Chọn ảnh sản phẩm</label>
                            <input type="file" name="imageFile" class="form-control">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <input type="button" class="btn btn-default" data-dismiss="modal" value="Hủy">
                        <input type="submit" class="btn btn-success" value="Thêm">
                    </div>
                </form>

            </div>
        </div>
    </div>
    <!--/ Add -->
</div>
<!-- end main content -->

<!-- Modal Thông báo-->

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
<div id="addProductSuccessModal" class="modal fade">
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
<div id="editProductSuccessModal" class="modal fade">
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

<!-- Modal Thông báo-->

<!-- import script -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js"></script>
<script src="js/admin.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
<!-- end import script -->

<!--Script-->
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

<!--Script Sửa Sản Phẩm-->
<script>
    $('#editEmployeeModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        var productId = button.data('product-id');


        $('#editForm input[name="id"]').val(productId);
    });

    function submitEditForm() {
        document.getElementById('editForm').submit();
        $('#editEmployeeModal').modal('hide');
    }
</script>
<!--Script Sửa Sản Phẩm-->

<!--Script Thông báo Xóa Sản Phẩm-->
<script>
    $(document).ready(function () {
        <% Boolean deleteSuccess = (Boolean)request.getSession().getAttribute("deleteSuccess"); %>
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
        <% Boolean addProductSuccess = (Boolean)request.getSession().getAttribute("addProductSuccess"); %>
        <% if (Objects.nonNull(addProductSuccess) && addProductSuccess) { %>
        $('#addProductSuccessModal').modal('show');
        <% request.getSession().removeAttribute("addProductSuccess"); %>
        <% } %>
    });
</script>
<!--Script Thông báo Thêm Sản Phẩm-->

<!--Script Thông báo Thêm Sản Phẩm-->
<script>
    $(document).ready(function () {
        <% Boolean editProductSuccess = (Boolean)request.getSession().getAttribute("editProductSuccess"); %>
        <% if (Objects.nonNull(editProductSuccess) && editProductSuccess) { %>
        $('#editProductSuccessModal').modal('show');
        <% request.getSession().removeAttribute("editProductSuccess"); %>
        <% } %>
    });
</script>
<!--Script Thông báo Thêm Sản Phẩm-->

<!-- Script -->

<%--AJAX--%>
<script>
    $(document).ready(function() {
        // Sự kiện chỉnh sửa sản phẩm
        $('.edit').click(function (e) {
            e.preventDefault();
            var productId = $(this).data('product-id');
            console.log("Clicked Edit Product ID: " + productId);  // Debug: In ra ID sản phẩm khi nhấn edit

            $.ajax({
                url: "/quanlysanpham/product-edit",
                method: "GET",
                data: { id: productId },
                dataType: "json",
                success: function (response) {
                    console.log("✅ Dữ liệu sản phẩm:", response);

                    // Gán dữ liệu vào form
                    $('#editProductId').val(response.product.id || '');
                    $('#editProductName').val(response.product.name || '');
                    $('#editProductPrice').val(response.product.price || '');
                    $('#editProductQuantity').val(response.product.quantity != null ? response.product.quantity : '0');
                    $('#editProductDetail').val(response.product.detail || '');

                    // Cập nhật loại sản phẩm
                    var productTypesDropdown = $('#editProductType');
                    productTypesDropdown.empty();  // Xóa tất cả các lựa chọn hiện tại
                    response.productTypes.forEach(function(productType) {
                        var selected = productType.id === response.product.productType.id ? 'selected' : '';
                        productTypesDropdown.append('<option value="' + productType.id + '" ' + selected + '>' + productType.name + '</option>');
                    });

                    // Cập nhật hãng sản xuất
                    var producersDropdown = $('#editProductProducer');
                    producersDropdown.empty();  // Xóa tất cả các lựa chọn hiện tại
                    response.producers.forEach(function(producer) {
                        var selected = producer.id === response.product.producer.id ? 'selected' : '';
                        producersDropdown.append('<option value="' + producer.id + '" ' + selected + '>' + producer.name + '</option>');
                    });

                    // Các trường khác
                    $('#editProductStatus').val(response.product.status || 'available');

                    // Format ngày yyyy-MM-dd
                    if (response.product.import_date) {
                        const d = new Date(response.product.import_date);
                        const formattedDate = d.toISOString().split('T')[0];
                        $('#editProductImportDate').val(formattedDate);
                    } else {
                        $('#editProductImportDate').val('');
                    }

                    $('#editProductCouponId').val(response.product.couponId || '');
                    // Hiển thị ảnh sản phẩm hiện tại
                    if (response.product.images && response.product.images.length > 0) {
                        $('#currentProductImage').attr('src', response.product.images[0].linkImage);
                    } else {
                        $('#currentProductImage').attr('src', 'default-image.jpg'); // Hoặc bạn có thể dùng ảnh mặc định
                    }

                    // Hiện modal
                    $('#editEmployeeModal').modal('show');
                },
                error: function (xhr) {
                    console.error("❌ Lỗi khi lấy thông tin sản phẩm:", xhr);
                    alert('Không thể lấy dữ liệu sản phẩm!');
                }
            });
        });

        // Sự kiện submit chỉnh sửa sản phẩm
        $('#edit').on('submit', function (e) {
            e.preventDefault();  // Ngừng hành động submit mặc định của form

            var formData = $(this).serialize(); // Lấy toàn bộ dữ liệu form

            $.ajax({
                url: "/quanlysanpham/product-edit",
                method: "POST",
                data: formData,  // Gửi dữ liệu đã chỉnh sửa lên server
                success: function (response) {
                    alert('Cập nhật sản phẩm thành công!');
                    $('#editProductModal').modal('hide');
                    location.reload();  // Reload lại trang
                },
                error: function () {
                    alert('Đã có lỗi xảy ra khi cập nhật sản phẩm');
                }
            });
        });
    });

</script>
<%--AJAX--%>


</body>
</html>