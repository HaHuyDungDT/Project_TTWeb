<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Product" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
  <title>Danh sách sản phẩm</title>
</head>
<body>
<h2>Danh sách sản phẩm</h2>

<a href="${pageContext.request.contextPath}/admin/add-product">+ Thêm sản phẩm mới</a><br><br>

<table border="1" cellpadding="8" cellspacing="0">
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
        <a href="${pageContext.request.contextPath}/admin/edit-product?id=${p.id}">Sửa</a> |
        <a href="${pageContext.request.contextPath}/admin/delete-product?id=${p.id}" onclick="return confirm('Bạn có chắc chắn xoá?');">Xoá</a>
      </td>
    </tr>
  </c:forEach>
</table>

</body>
</html>
