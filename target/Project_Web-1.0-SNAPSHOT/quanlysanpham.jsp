<%@ page import="model.Product" %>
<%@ page import="dao.impl.ProductDAOImpl" %>
<%@ page import="java.util.List" %>
<%@ page import="dao.impl.ProductTypeDAOImpl" %>
<%@ page import="dao.impl.ProductDAOImpl" %>
<%@ page import="java.util.Objects" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="utils.SessionUtil" %>
<%@ page import="model.User" %>
<%@ page import="dao.impl.UserDaoImpl" %>
<%
    String userId = (String) SessionUtil.getInstance().getKey((HttpServletRequest) request, "user");
    User currentUser = userId != null ? new UserDaoImpl().getUserByUserId(Integer.parseInt(userId)) : null;
    if (currentUser == null || "0".equals(currentUser.getRoleId())) {
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
<!-- sidebar -->
<div class="sidebar">
    <ul class="sidebar-nav">
        <li class="sidebar-nav-item">
            <a href="thongso.jsp" class="sidebar-nav-link" style="margin-top: 20px;">
                <div>
                    <i class="fa-solid fa-signal"></i>
                </div>
                <span>
						Thông số bán hàng
					</span>
            </a>
        </li>
        <li class="sidebar-nav-item">
            <a href="admin.jsp" class="sidebar-nav-link">
                <div>
                    <i class="fa fa-user"></i>
                </div>
                <span>Quản lý nhân viên</span>
            </a>
        </li>
        <li class="sidebar-nav-item">
            <a href="quanlysanpham.jsp" class="sidebar-nav-link">
                <div>
                    <i class="fa fa-mobile"></i>
                </div>
                <span>Quản lý sản phẩm</span>
            </a>
        </li>
        <li class="sidebar-nav-item">
            <a href="quanlyhoadon.jsp" class="sidebar-nav-link">
                <div>
                    <i class="fa-solid fa-layer-group"></i>
                </div>
                <span>Quản lý hóa đơn</span>
            </a>
        </li>
        <li class="sidebar-nav-item">
            <a href="quanlytaikhoan" class="sidebar-nav-link">
                <div>
                    <i class="fa-solid fa-circle-user"></i>
                </div>
                <span>Quản lý tài khoản</span>
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
                            <th>Mã loại sản phẩm</th>
                            <th>Tồn kho</th>
                            <th>Mã hãng sản xuất</th>
                            <th>Hình ảnh</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%
                            ProductDAOImpl productDAO = new ProductDAOImpl();
                            List<Product> listProduct = productDAO.findAll();
                            request.setAttribute("listAll", listProduct);
                            for (Product p : listProduct) {
                        %>
                        <tr>
                            <td><%=p.getId()%>
                            </td>
                            <td><%=p.getName()%>
                            </td>
                            <td>
                                <div>
                                    <fmt:formatNumber value="<%=p.getPrice()%>" type="number" pattern="#,##0"
                                                      var="formattedPrice"/>
                                    <h6 class="product-price">${formattedPrice} VNĐ</h6>
                                </div>
                            </td>
                            <td><%=p.getProductType().getId()%>
                            </td>
                            <td><%=p.getQuantity()%>
                            </td>
                            <td><%=p.getProducer().getId()%>
                            </td>
                            <td>
                                <img style="width: 70px; height: 70px" src="<%=p.getImages()%>" alt="">
                            </td>
                            <td>
                                <a href="#editEmployeeModal" class="edit" data-toggle="modal" data-product-id="<%=p.getId()%>">
                                    <i class="material-icons" data-toggle="tooltip" title="Edit">&#xE254;</i></a>

                                <a href="#deleteEmployeeModal" class="delete" data-toggle="modal"
                                   onclick="deleteProduct(<%=p.getId()%>)">
                                    <i class="material-icons" data-toggle="tooltip" title="Delete">&#xE872;</i></a>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <!-- Edit-->
    <div id="editEmployeeModal" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <form id="editForm" action="edit" method="post">
                    <div class="modal-header">
                        <h4 class="modal-title">Thay đổi thông tin</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label>#</label>
                            <input name="id" value="" type="text" class="form-control" readonly required>
                        </div>
                        <div class="form-group">
                            <label>Tên sản phẩm</label>
                            <input name="name" value="" type="text" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label>Giá</label>
                            <input name="price" value="" type="text" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label>Mã loại sản phẩm</label>
                            <select name="productType" class="form-select">
                                <c:forEach items="${c.selectAll()}" var="pt">
                                    <option value="${pt.id}">${pt.id}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Tồn kho</label>
                            <input name="quantity" value="" type="number" class="form-control"
                                   required>
                        </div>
                        <div class="form-group">
                            <label>Mã hãng sản xuất</label>
                            <select name="productCategory" class="form-select">
                                <c:forEach items="${b.selectAll()}" var="pc">
                                    <option value="${pc.id}">${pc.id}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Hình ảnh</label>
                            <input name="img" value="" type="text" class="form-control" required>
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
                <form id="deleteForm" action="delete" method="post">
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
                <form action="add" method="post">
                    <div class="modal-header">
                        <h4 class="modal-title">Thêm sản phẩm</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label>#</label>
                            <input name="id" type="text" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label>Tên sản phẩm</label>
                            <input name="name" type="text" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label>Giá</label>
                            <input name="price" type="text" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label>Mã loại sản phẩm</label>
                            <select name="productType" class="form-select">
                                <c:forEach items="${c.selectAll()}" var="pt">
                                    <option value="${pt.id}">${pt.id}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Tồn kho</label>
                            <input name="quantity" type="number" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label>Mã hãng sản xuất</label>
                            <select name="productCategory" class="form-select">
                                <c:forEach items="${b.selectAll()}" var="pc">
                                    <option value="${pc.id}">${pc.id}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Hình ảnh</label>
                            <input name="img" type="text" class="form-control" required>
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

</body>
</html>