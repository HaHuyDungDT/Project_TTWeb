    <%@ page import="model.User" %>
    <%@ page import="java.text.SimpleDateFormat" %>
    <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <c:if test="${ sessionScope.codes == null }">
        <c:redirect url="/login"/>
    </c:if>
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Nhập mã xác nhận</title>
        <link rel="stylesheet" href="css/register.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"/>
        <link type="text/css" rel="stylesheet" href="css/bootstrap.min.css"/>
    </head>
    <body>
    <div class="wrapper">
        <h1>Nhập mã xác nhận</h1>
        <c:if test="${not empty error}">
            <p class="alert alert-danger">${error}</p>
        </c:if>
        <!-- Form OTP chỉ hiển thị khi OTP chưa được xác nhận -->
        <c:if test="${empty sessionScope.otpSuccess}">
            <form id="registrationForm" action="entercode" method="post">
                <input type="text" class="form-control form-control-xl" placeholder="Mã xác nhận" name="code" required value="${code != null ? code : ''}">
            </form>
            <button onclick="submitForm()">Gửi</button>
        </c:if>
    </div>

    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/slick.min.js"></script>
    <script src="js/nouislider.min.js"></script>
    <script src="js/jquery.zoom.min.js"></script>
    <script src="js/main.js"></script>

    <script>
        function submitForm() {
            $('#registrationForm').submit();
        }
        // Nếu otpSuccess đã được đặt, hiển thị overlay và chuyển hướng sau 5 giây
        <c:if test="${not empty sessionScope.otpSuccess}">
        $(document).ready(function(){
            $('#overlay').show();
            setTimeout(function(){
                window.location.href = "dangnhap.jsp";
            }, 5000);
        });
        </c:if>
    </script>
    <c:if test="${not empty sessionScope.otpSuccess}">
    <div class="overlay" id="overlay">
        <div class="success-message">
            <p>Đăng ký thành công!</p>
            <br><a href="dangnhap.jsp">Đăng nhập ngay</a>
        </div>
    </div>
    </c:if>
    </body>
    </html>

