<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
  <title>Danh sách sản phẩm</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
  <h2 class="mb-4">Danh sách sản phẩm</h2>
  <a href="${pageContext.request.contextPath}/admin/add-product" class="btn btn-success mb-3">+ Thêm sản phẩm mới</a>

  <table class="table table-bordered table-striped align-middle">
    <thead class="table-dark">
    <tr>
      <th>ID</th>
      <th>Tên</th>
      <th>Giá</th>
      <th>Loại</th>
      <th>NSX</th>
      <th>Số lượng</th>
      <th>Trạng thái</th>
      <th>Ngày nhập</th>
      <th>Hành động</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="p" items="${products}">
      <tr>
        <td>${p.id}</td>
        <td>${p.name}</td>
        <td>${p.price}</td>
        <td>${p.productTypeID}</td>
        <td>${p.producerID}</td>
        <td>${p.quantity}</td>
        <td>${p.status}</td>
        <td>${p.import_date}</td>
        <td>
          <a href="${pageContext.request.contextPath}/admin/edit-product?id=${p.id}" class="btn btn-sm btn-primary">Sửa</a>
          <a href="${pageContext.request.contextPath}/admin/delete-product?id=${p.id}" class="btn btn-sm btn-danger"
             onclick="return confirm('Bạn có chắc chắn muốn xoá sản phẩm này không?');">Xoá</a>
        </td>
      </tr>
    </c:forEach>
    </tbody>
  </table>
</div>
</body>
</html>
