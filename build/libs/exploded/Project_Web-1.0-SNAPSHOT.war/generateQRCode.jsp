<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    // Lấy thông tin user, secretKey và email từ session hoặc request
    model.User user = (model.User) session.getAttribute("user");
    String userEmail = "";
    String secretKey = "";
    if(user != null) {
        userEmail = user.getEmail();
        secretKey = user.getSecretKey();
    }
    if(secretKey == null || secretKey.trim().isEmpty()){
        secretKey = request.getParameter("secretKey");
    }
    if(userEmail == null || userEmail.trim().isEmpty()){
        userEmail = request.getParameter("userEmail");
    }
    String appName = "phukienphone.com";
    String qrCodeUrl = "otpauth://totp/" + appName + ":" + userEmail + "?secret=" + secretKey + "&issuer=" + appName;
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Kích hoạt Google Authenticator</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <style>
        body { background-color: #f7f7f7; font-family: Arial, sans-serif; }
        .container {
            margin: 50px auto; max-width: 500px; background: #fff; padding: 30px;
            border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,0.1); text-align: center;
        }
        .qr-code img { margin-top: 20px; border: 1px solid #eee; }
    </style>
</head>
<body>
<div class="container">
    <h2>Kích hoạt Google Authenticator</h2>
    <p>Quét mã QR bên dưới bằng ứng dụng Google Authenticator (hoặc Authy) để liên kết tài khoản của bạn.</p>
    <div class="qr-code">
        <img src="qrcode?data=<%= java.net.URLEncoder.encode(qrCodeUrl, "UTF-8") %>&size=200" alt="QR Code 2FA">
    </div>
    <p>Mã bí mật của bạn: <strong><%= secretKey %></strong></p>
    <p>Sau khi quét, hãy nhập mã OTP từ ứng dụng để kích hoạt:</p>
    <form action="changePassword" method="post">
        <div class="form-group">
            <label for="otpCode">Mã OTP</label>
            <input type="text" id="otpCode" name="otpCode" class="form-control" placeholder="Nhập mã OTP" required>
        </div>
        <button type="submit" class="btn btn-primary">Kích hoạt</button>
    </form>
</div>
</body>
</html>