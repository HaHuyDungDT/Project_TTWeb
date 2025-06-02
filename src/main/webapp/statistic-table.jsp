<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<table class="table table-bordered text-center">
    <thead class="thead-dark">
    <tr>
        <th colspan="5">${param.title}</th>
    </tr>
    <tr>
        <th>Đơn hàng</th>
        <th>Khách hàng</th>
        <th>Sản phẩm bán</th>
        <th>Doanh thu</th>
    </tr>
    </thead>
    <tbody>
    <tr>
        <td>${param.order}</td>
        <td>${param.customer}</td>
        <td>${param.product}</td>
        <td><fmt:formatNumber value="${param.revenue}" pattern="#,##0"/> VND</td>
    </tr>
    </tbody>
</table>
