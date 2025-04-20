<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="model.User" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Đăng ký</title>
    <link rel="stylesheet" href="css/register.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"/>
    <link type="text/css" rel="stylesheet" href="css/bootstrap.min.css"/>
</head>
<body>
<div class="wrapper">
    <h1>Đăng ký</h1>
    <c:if test="${error != null}">
        <p class="alert alert-danger">${error}</p>
    </c:if>
    <c:if test="${success != null}">
        <p class="alert alert-success">${success}</p>
    </c:if>
    <form id="registrationForm" action="register" method="post">
        <input class="form-control form-control-xl" type="text" placeholder="Tên người dùng" name="name" required value="${success == null && user != null ? user.name : ''}">
        <textarea type="text" class="form-control form-control-xl mt-2 mb-2" placeholder="Địa chỉ" name="address" required>${success == null && user != null ? user.address : ""}</textarea>
        <%
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        %>
        <input type="date" class="form-control form-control-xl" placeholder="Ngày sinh"
               value="${success == null && user != null && user.createdAt != null ? user.createdAt.format(java.time.format.DateTimeFormatter.ISO_LOCAL_DATE) : ''}"
               name="birthDay" required>
<%--        <input type="date" class="form-control form-control-xl" placeholder="Ngày sinh" value="<%=request.getAttribute("user") == null ? "" : sdf.format(((User)request.getAttribute("user")).getBirth_day())%>" name="birthDay" required>--%>
<%--        <input type="phone" class="form-control form-control-xl" placeholder="Số điện thoại" value="${success == null && user != null ? user.phone_number : ""}" name="phoneNumber" required>--%>
        <input class="form-control form-control-xl" type="email" placeholder="Email" value="${success == null && user != null ? user.email : ''}" name="email" required>
        <input type="text" class="form-control form-control-xl" placeholder="Tên đăng nhập" value="${success == null && user != null ? user.username : ''}" name="username" required>
        <input class="form-control form-control-xl" type="password" placeholder="Mật khẩu" value="" name="password" required>
        <input class="form-control form-control-xl" type="password" placeholder="Nhập lại mật khẩu" value="" name="confirmPassword" required>    </form>
    <div class="terms">
        <input type="checkbox" id="checkbox">
        <label for="checkbox">Tôi đồng ý những<a href="chinhsachbaomat.jsp"> chính sách của cửa hàng</a></label>
    </div>
    <button onclick="submitForm()">Đăng ký</button>
<div class="member">
    Đã có tài khoản? <a href="dangnhap.jsp">Đăng nhập ở đây</a>
</div>
</div>

<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/slick.min.js"></script>
<script src="js/nouislider.min.js"></script>
<script src="js/jquery.zoom.min.js"></script>
<script src="js/main.js"></script>

<script>
    function submitForm() {
        var registrationForm = document.getElementById('registrationForm');
        var checkbox = document.getElementById('checkbox');
        if (checkbox.checked && registrationForm.checkValidity()) {
            $('#registrationForm').submit();
        } else {
            alert("Vui lòng điền đầy đủ thông tin và đồng ý với các điều khoản.");
        }
    }
</script>
<div class="overlay" id="overlay">
    <div class="success-message">
        <p> Đăng ký thành công!</p>
        <br><a href="dangnhap.jsp">Đăng nhập ngay</a>
    </div>
</div>

</body>
</html>

