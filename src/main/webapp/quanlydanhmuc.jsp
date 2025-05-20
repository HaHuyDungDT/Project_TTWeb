<%@ page import="model.User, utils.SessionUtil, java.util.List, model.ProductType, dao.impl.ProductTypeDAOImpl" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
  // Kiểm tra đăng nhập & phân quyền
  User user = (User) SessionUtil.getInstance()
          .getKey((javax.servlet.http.HttpServletRequest) request, "user");
  if (user == null || (user.getRoleId() != 1 && user.getRoleId() != 2)) {
    response.sendRedirect("dangnhap.jsp");
    return;
  }
  // Lấy danh sách danh mục
  List<ProductType> types = new ProductTypeDAOImpl().findAll();
  request.setAttribute("types", types);
%>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport"
        content="width=device-width, initial-scale=1.0, user-scalable=0">
  <title>Quản lý danh mục sản phẩm</title>
  <link rel="icon" href="./img/logo.png" type="image/png"/>
  <!-- Bootstrap 4 CSS -->
  <link rel="stylesheet"
        href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
  <!-- Icons & custom CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"
        rel="stylesheet">
  <link rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
  <link rel="stylesheet" href="css/style.css"/>
  <link rel="stylesheet" href="css/styleAdmin.css"/>

  <style>
    .table-container { background-color: #fff; }
    .table-container .table tbody a {
      color: #007bff;
    }
    .table-container .table tbody a:hover {
      color: #0056b3;
      text-decoration: underline;
    }
  </style>
</head>
<body class="overlay-scrollbar">

<!-- NAVBAR -->
<nav class="navbar navbar-expand navbar-light bg-white shadow-sm">
  <ul class="navbar-nav">
    <li class="nav-item">
      <a class="nav-link" href="#"><i class="fa-solid fa-bars"
                                      onclick="collapseSidebar()"></i></a>
    </li>
    <li class="nav-item">
      <img src="./img/logo.png" alt="logo" class="logo logo-light">
    </li>
  </ul>
  <ul class="navbar-nav ml-auto nav-right">
    <li class="nav-item dropdown">
      <a class="nav-link" href="#">
        <i class="fas fa-bell dropdown-toggle" data-toggle="notification-menu"></i>
        <span class="navbar-badge">1</span>
      </a>
    </li>
    <li class="nav-item avt-wrapper">
      <div class="avt dropdown">
        <img src="./img/admin1.jpg" alt="User image"
             class="dropdown-toggle" data-toggle="user-menu">
      </div>
    </li>
  </ul>
</nav>
<!-- end NAVBAR -->

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
      <a href="quanlydanhmuc.jsp" class="sidebar-nav-link">
        <div><i class="fas fa-list-alt"></i></div>
        <span>Quản lý danh mục sản phẩm</span>
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

<!-- MAIN CONTENT -->
<div class="wrapper">
  <div class="container-fluid py-4">
    <!-- Header -->
    <div class="d-flex justify-content-between align-items-start mb-4">
      <div class="d-flex flex-column">
        <a href="#" class="text-muted text-decoration-none mb-1">
          <i class="bi bi-arrow-left me-1"></i> Danh mục
        </a>
        <h3 class="mb-0">Quản lý danh mục sản phẩm</h3>
      </div>
      <!-- Nút mở modal -->
      <button type="button"
              class="btn btn-primary"
              data-toggle="modal"
              data-target="#createCategoryModal">
        <i class="bi bi-plus-lg me-1"></i> Tạo danh mục
      </button>
    </div>

    <!-- Tabs -->
    <ul class="nav nav-tabs mb-4">
      <li class="nav-item">
        <a class="nav-link active" href="#">Tất cả danh mục</a>
      </li>
    </ul>

    <!-- Filter + Search -->
    <div class="mb-3">
      <div class="combined-input-group input-group border rounded">
        <button class="btn btn-outline-secondary dropdown-toggle"
                type="button" data-toggle="dropdown">
          Lọc danh mục
        </button>
        <ul class="dropdown-menu">
          <li><a class="dropdown-item" href="#">Tất cả</a></li>
          <li><a class="dropdown-item" href="#">Đang hoạt động</a></li>
          <li><a class="dropdown-item" href="#">Đã ẩn</a></li>
        </ul>
        <span class="input-group-text"><i class="bi bi-search"></i></span>
        <input type="text" class="form-control"
               placeholder="Tìm kiếm danh mục sản phẩm">
      </div>
    </div>

    <!-- Table danh mục -->
    <div class="table-container table-responsive mb-4">
      <table class="table align-middle table-hover mb-0">
        <thead class="table-light">
        <tr>
          <th style="width:40px"><input type="checkbox"/></th>
          <th>Danh mục</th>
          <th style="width:150px">Mã danh mục</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="type" items="${types}">
          <tr
                  data-id="${type.id}"
                  data-name="${type.name}"
                  data-code="${type.code}"
          >
            <td><input type="checkbox"/></td>
            <!-- Xóa hẳn phần <img> đi, giờ chỉ còn tên và code -->
            <td>${type.name}</td>
            <td>${type.code}</td>
          </tr>
        </c:forEach>

        </tbody>
      </table>
    </div>
  </div>
</div>
  <!-- end MAIN CONTENT -->

  <!-- Modal Form Tạo danh mục -->
  <div class="modal fade" id="createCategoryModal" tabindex="-1" role="dialog"
       aria-labelledby="createCategoryLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
      <div class="modal-content">
        <form action="storeCategory" method="post">
          <div class="modal-header">
            <h5 class="modal-title" id="createCategoryLabel">Tạo mới danh mục</h5>
            <button type="button" class="close" data-dismiss="modal"
                    aria-label="Đóng">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
            <div class="form-group mb-3">
              <label for="catName">Tên danh mục</label>
              <input type="text" class="form-control" id="catName"
                     name="name" required>
            </div>
            <div class="form-group mb-3">
              <label for="catDesc">Mô tả</label>
              <textarea class="form-control" id="catDesc"
                        name="description" rows="4"></textarea>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary"
                    data-dismiss="modal">Hủy</button>
            <button type="submit" class="btn btn-primary">Lưu</button>
          </div>
        </form>
      </div>
    </div>
  </div>

  <!-- Scripts -->
  <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
  <script src="js/admin.js"></script>
</body>
</html>