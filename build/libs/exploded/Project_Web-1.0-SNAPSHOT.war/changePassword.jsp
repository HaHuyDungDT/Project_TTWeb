<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đổi Mật Khẩu</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/register.css">
    <style>
        body { background-color: #f7f7f7; }
        .change-pass-container {
            max-width: 700px;
            margin: 80px auto;
            background: #ffffff;
            padding: 50px;
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
        }
        .change-pass-container h2 {
            margin-bottom: 30px;
            text-align: center;
            color: #333;
            font-size: 28px;
        }
        .form-group label { font-weight: bold; font-size: 18px; }
        .form-control { font-size: 18px; padding: 15px; border-radius: 4px; }
        .btn-change {
            width: 100%;
            background-color: #ff5722;
            color: #fff;
            border: none;
            padding: 15px;
            font-size: 18px;
            border-radius: 4px;
            margin-top: 20px;
        }
        .btn-change:hover { background-color: #e64a19; }
        .login-link {
            display: block;
            text-align: center;
            margin-top: 25px;
            font-size: 18px;
            color: #007bff;
            text-decoration: none;
            font-weight: bold;
        }
        .login-link:hover { text-decoration: underline; }
    </style>
</head>
<body>
<div class="change-pass-container">
    <h2>Đổi Mật Khẩu</h2>
    <c:if test="${not empty error}">
        <div class="alert alert-danger" role="alert">${error}</div>
    </c:if>
    <c:if test="${not empty success}">
        <div class="alert alert-success" role="alert" id="msgSuccess">
                ${success}
        </div>
    </c:if>
    <form action="changePassword" method="post">
        <div class="form-group">
            <label for="currentPassword">Mật khẩu hiện tại</label>
            <input type="password" id="currentPassword" name="currentPassword" class="form-control" placeholder="Nhập mật khẩu hiện tại" required>
        </div>
        <div class="form-group">
            <label for="newPassword">Mật khẩu mới</label>
            <input type="password" id="newPassword" name="newPassword" class="form-control" placeholder="Nhập mật khẩu mới" required>
        </div>
        <div class="form-group">
            <label for="confirmPassword">Xác nhận mật khẩu mới</label>
            <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" placeholder="Xác nhận mật khẩu mới" required>
        </div>
        <!-- Xóa trường nhập mã OTP -->
        <button type="submit" class="btn-change">Đổi mật khẩu</button>
    </form>
    <c:if test="${not empty success}">
        <a href="dangnhap.jsp" class="login-link">Đăng nhập ngay</a>
    </c:if>
</div>
<script>
    setTimeout(function() {
        var msg = document.getElementById("msgSuccess");
        if (msg) {
            msg.style.display = "none";
        }
    }, 1000);
</script>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>