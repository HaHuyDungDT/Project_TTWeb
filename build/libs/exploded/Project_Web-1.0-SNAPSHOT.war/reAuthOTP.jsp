<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Xác thực OTP</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <style>
        .container { max-width: 500px; margin: 80px auto; background: #fff; padding: 30px; border-radius: 8px; box-shadow: 0 0 15px rgba(0,0,0,0.1); text-align: center; }
        .form-control { font-size: 18px; padding: 15px; border-radius: 4px; }
        .btn-submit { width: 100%; background-color: #ff5722; color: #fff; border: none; padding: 15px; font-size: 18px; border-radius: 4px; margin-top: 20px; }
        .btn-submit:hover { background-color: #e64a19; }
    </style>
</head>
<body>
<div class="container">
    <h2>Xác thực OTP</h2>
    <form action="reAuthOTP" method="post">
        <div class="form-group">
            <label for="otpCode">Nhập mã OTP từ Google Authenticator</label>
            <input type="text" id="otpCode" name="otpCode" class="form-control" placeholder="Nhập mã OTP" required>
        </div>
        <button type="submit" class="btn-submit">Xác thực</button>
    </form>
    <c:if test="${not empty error}">
        <div class="alert alert-danger" role="alert">${error}</div>
    </c:if>
</div>
</body>
</html>