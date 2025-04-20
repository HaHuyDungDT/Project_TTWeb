<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Quên mật khẩu</title>
    <link rel="stylesheet" href="css/register.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"/>
    <link type="text/css" rel="stylesheet" href="css/bootstrap.min.css"/>
</head>
<body>
<div class="wrapper">
    <h1>Quên mật khẩu</h1>
    <c:if test="${error != null}">
        <p class="alert alert-danger">${error}</p>
    </c:if>
    <form action="" method="post">
        <input type="email" placeholder="Email" name="email" required value="${email}">
        <div class="recover">
        </div>
        <button style="border: none" type="submit">Xác nhận</button>
    </form>

    <div class="member">
        Chưa có tài khoản ? <a href="dangky.jsp">
        Đăng ký ngay
    </a>
    </div>
</div>
</body>
</html>