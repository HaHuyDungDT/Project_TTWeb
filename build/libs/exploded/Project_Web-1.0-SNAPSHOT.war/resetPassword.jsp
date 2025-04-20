<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Cập nhập lại mật khẩu</title>
    <link rel="stylesheet" href="css/register.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"/>
    <link type="text/css" rel="stylesheet" href="css/bootstrap.min.css"/>
</head>
<body>
<div class="wrapper">
    <h1>Cập nhập lại mật khẩu</h1>
    <c:if test="${not empty error}">
        <p class="alert alert-danger">${error}</p>
    </c:if>
    <!-- Hiển thị thông báo success nếu có -->
    <c:if test="${not empty success}">
        <p class="alert alert-success">${success}</p>
    </c:if>
    <form action="${pageContext.request.contextPath}/resetpassword" method="post">
        <input type="password" placeholder="Mật khẩu" name="password" required>
        <input type="password" placeholder="Nhập lại mật khẩu" name="enterPassword" required>
        <button style="border: none" type="submit">Cập nhập mật khẩu</button>
    </form>
</div>
<c:if test="${not empty success}">
    <script>
        // Sau 3 giây chuyển hướng sang trang đăng nhập
        setTimeout(function(){
            window.location.href = "${pageContext.request.contextPath}/dangnhap.jsp";
        }, 3000);
    </script>
</c:if>
</body>
</html>