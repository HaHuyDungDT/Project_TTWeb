<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <!-- favicon -->
  <link rel="icon" href="./img/logo.png" type="image/x-icon"/>

  <title>Đơn Hàng Của Tôi</title>

  <!-- Google Font -->
  <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">

  <!-- Bootstrap -->
  <link rel="stylesheet" href="css/bootstrap.min.css"/>

  <!-- Slick carousel -->
  <link rel="stylesheet" href="css/slick.css"/>
  <link rel="stylesheet" href="css/slick-theme.css"/>

  <!-- Nouislider -->
  <link rel="stylesheet" href="css/nouislider.min.css"/>

  <!-- Stylesheet của dự án -->
  <link rel="stylesheet" href="css/style.css"/>

  <!-- Font Awesome 6.4.0 (LOAD SAU style.css) -->
  <link rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
        integrity="sha512-papN8Auqwsb5Jnu3hU0MGLuedlitO+lQ9B+8R4zbmlF+M8sN+IN0KjhWtmjSel6BxGR+N4e244MQ7vq6QQP2mw=="
        crossorigin="anonymous" referrerpolicy="no-referrer"/>

  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">


  <!-- Toastify (nếu có dùng) -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css"/>

  <!-- jQuery & plugins -->
  <script src="js/jquery.min.js"></script>
  <script src="js/bootstrap.min.js"></script>
  <script src="js/slick.min.js"></script>
  <script src="js/nouislider.min.js"></script>
  <script src="js/jquery.zoom.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/toastify-js"></script>

  <style>
    /* === Layout chính: sidebar + content luôn trên một hàng === */
    .profile-container {
      display: flex;
      flex-wrap: nowrap;        /* không wrap xuống dòng */
      gap: 20px;
      margin: 20px auto;
      max-width: 1200px;
      padding: 20px;
    }
    .profile-container .sidebar {
      flex: 0 0 250px;
      background: #fff;
      padding: 20px;
      border: 1px solid #e0e0e0;
      border-radius: 8px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.1);
      transition: transform 0.3s;
    }
    .profile-container .sidebar:hover {
      transform: translateY(-3px);
    }
    .profile-container .sidebar .section-title {
      font-size: 16px;
      font-weight: bold;
      margin-bottom: 10px;
      color: #333;
      border-bottom: 1px solid #f0f0f0;
      padding-bottom: 5px;
      display: flex;
      align-items: center;
    }
    .profile-container .sidebar .section-title i {
      font-size: 1.2em;
      margin-right: 8px;
      color: #ff5722;
    }
    .profile-container .sidebar ul {
      list-style: none;
      padding: 0;
      margin: 0 0 20px;
    }
    .profile-container .sidebar li {
      margin-bottom: 10px;
    }
    .profile-container .sidebar a {
      display: flex;
      align-items: center;
      padding: 10px;
      color: #333;
      font-weight: bold;
      border-radius: 4px;
      text-decoration: none;
      transition: background-color 0.3s;
    }
    .profile-container .sidebar a i {
      margin-right: 8px;
      color: #555;
    }
    .profile-container .sidebar a:hover {
      background-color: #f7f7f7;
    }
    .profile-container .sidebar a.active {
      background-color: #ff5722;
      color: #fff;
    }
    .profile-container .sidebar a.active i {
      color: #fff;
    }

    .profile-container .content {
      flex: 1;
      min-width: 0;             /* cho phép flex item này co nhỏ đúng */
      background: #fff;
      padding: 30px;
      border: 1px solid #e0e0e0;
      border-radius: 8px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.1);
      transition: box-shadow 0.3s;
    }
    .profile-container .content:hover {
      box-shadow: 0 4px 12px rgba(0,0,0,0.2);
    }
    .profile-container .profile-title {
      font-size: 20px;
      font-weight: bold;
      margin-bottom: 15px;
      color: #333;
    }

    /* === Tab đơn hàng: cuộn ngang ẩn scrollbar === */
    .order-tabs-container {
      overflow-x: auto;
      -ms-overflow-style: none;   /* IE/Edge */
      scrollbar-width: none;      /* Firefox */
      margin-bottom: 20px;
      border-bottom: 1px solid #f0f0f0;
    }
    .order-tabs-container::-webkit-scrollbar {
      display: none;              /* Chrome/Safari/Opera */
    }
    .order-tabs {
      white-space: nowrap;
    }
    .order-tabs ul {
      display: inline-flex;
      gap: 10px;
      padding: 0;
      margin: 0;
      list-style: none;
    }
    .order-tabs ul li {
      flex: 0 0 auto;
      padding: 10px 0;
    }
    .order-tabs ul li a {
      display: block;
      padding: 5px 10px;
      text-decoration: none;
      color: #333;
      transition: color 0.3s, border-bottom 0.3s;
    }
    .order-tabs ul li.active a,
    .order-tabs ul li a:hover {
      color: #ff5722;
      font-weight: bold;
      border-bottom: 2px solid #ff5722;
    }

    /* === Search bar === */
    .search-bar {
      margin-bottom: 20px;
    }
    .search-bar form {
      display: flex;
    }
    .search-bar input[type="text"] {
      flex: 1;
      padding: 10px;
      font-size: 14px;
      border: 1px solid #ccc;
      border-radius: 4px 0 0 4px;
    }
    .search-bar button {
      padding: 10px 20px;
      font-size: 14px;
      border: none;
      background: #ff5722;
      color: #fff;
      border-radius: 0 4px 4px 0;
      cursor: pointer;
      transition: background-color 0.3s;
    }
    .search-bar button:hover {
      background: #e64a19;
    }

    /* === Bảng đơn hàng === */
    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 20px;
    }
    table th, table td {
      padding: 12px;
      border-bottom: 1px solid #e0e0e0;
      text-align: left;
    }
    table th {
      font-size: 14px;
      font-weight: 500;
      color: #555;
      text-transform: uppercase;
    }
    table td {
      font-size: 14px;
      color: #333;
    }

    @media (max-width: 768px) {
      /* Nếu muốn mobile thì wrap */
      .profile-container {
        flex-wrap: wrap;
      }
      .profile-container .sidebar {
        width: 100%;
      }
    }
  </style>
</head>
<body>

<!-- HEADER & MENU -->
<jsp:include page="header.jsp"/>
<jsp:include page="menu.jsp"/>

<div class="profile-container">
  <!-- SIDEBAR -->
  <div class="sidebar">
    <div class="section-title"><i class="fas fa-address-card"></i> Tài Khoản</div>
    <ul>
      <li><a href="#"><i class="fas fa-user-circle"></i> Hồ Sơ</a></li>
      <li><a href="#"><i class="fas fa-university"></i> Ngân Hàng</a></li>
      <li><a href="#"><i class="fas fa-map-marker-alt"></i> Địa Chỉ</a></li>
      <li><a href="changePassword"><i class="fas fa-key"></i> Đổi Mật Khẩu</a></li>
      <li><a href="#"><i class="fas fa-bell"></i> Cài Đặt Thông Báo</a></li>
      <li><a href="#"><i class="fas fa-cog"></i> Thiết Lập Riêng Tư</a></li>
    </ul>
    <div class="section-title"><i class="fas fa-shopping-cart"></i> Đơn Hàng</div>
    <ul>
      <li><a href="#" class="active"><i class="fas fa-file-alt"></i> Đơn mua</a></li>
      <li><a href="#"><i class="fas fa-gift"></i> Kho Voucher</a></li>
      <li><a href="#"><i class="fas fa-coins"></i> Shopee Xu</a></li>
      <li><a href="#"><i class="fas fa-star"></i> Siêu Hội Freeship</a></li>
    </ul>
    <div class="section-title"><i class="fas fa-ellipsis-h"></i> Khác</div>
    <ul>
      <li><a href="#"><i class="fas fa-question-circle"></i> Trợ Giúp</a></li>
      <li><a href="#"><i class="fas fa-sign-out-alt"></i> Đăng Xuất</a></li>
    </ul>
  </div>

  <!-- CONTENT -->
  <div class="content">
    <h2 class="profile-title">Đơn Hàng Của Tôi</h2>

    <!-- ORDER TABS -->
    <div class="order-tabs-container">
      <div class="order-tabs">
        <ul>
          <li class="active"><a href="orderTracking.jsp?status=all">Tất cả</a></li>
          <li><a href="orderTracking.jsp?status=pending_confirmation">Chờ Xác Nhận</a></li>
          <li><a href="orderTracking.jsp?status=pending_pickup">Chờ Lấy Hàng</a></li>
          <li><a href="orderTracking.jsp?status=pending_delivery">Chờ Giao Hàng</a></li>
          <li><a href="orderTracking.jsp?status=shipping">Đang Giao</a></li>
          <li><a href="orderTracking.jsp?status=delivered">Đã Giao</a></li>
          <li><a href="orderTracking.jsp?status=canceled">Đã Hủy</a></li>
          <li><a href="orderTracking.jsp?status=returned">Trả Hàng/Hoàn Tiền</a></li>
        </ul>
      </div>
    </div>

    <!-- SEARCH BAR -->
    <div class="search-bar">
      <form action="orderTracking.jsp" method="get">
        <input type="text" name="query" placeholder="Tìm theo tên Shop, ID đơn hàng hoặc Tên sản phẩm"/>
        <button type="submit"><i class="fas fa-search"></i> Tìm kiếm</button>
      </form>
    </div>

    <!-- ORDERS TABLE -->
    <c:if test="${empty orders}">
      <div style="display:flex;flex-direction:column;align-items:center;justify-content:center;height:200px;">
        <img src="https://storage.googleapis.com/a1aa/image/eQFBbg0UD2XCVTY8RCvIsX9WQPES9fVcNoGt_O64JT8.jpg"
             alt="No orders" width="100" height="100" style="margin-bottom:10px;"/>
        <span style="color:#888;">Bạn hiện không có đơn hàng nào</span>
      </div>
    </c:if>
    <c:if test="${not empty orders}">
      <table>
        <thead>
        <tr>
          <th>Mã đơn hàng</th>
          <th>Ngày đặt</th>
          <th>Trạng thái</th>
          <th>Tổng tiền</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="order" items="${orders}">
          <tr>
            <td>${order.id}</td>
            <td><fmt:formatDate value="${order.order_date}" pattern="dd/MM/yyyy"/></td>
            <td><c:out value="${fn:toUpperCase(order.status)}"/></td>
            <td><fmt:formatNumber value="${order.total_price}" type="currency" currencySymbol="₫"/></td>
          </tr>
        </c:forEach>
        </tbody>
      </table>
    </c:if>
  </div>
</div>

<!-- FOOTER -->
<jsp:include page="footer.jsp"/>
<script src="js/main.js"></script>
</body>
</html>
