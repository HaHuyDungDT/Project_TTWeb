<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập</title>
    <link rel="stylesheet" href="css/register.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"/>
    <link type="text/css" rel="stylesheet" href="css/bootstrap.min.css"/>
    <style>
        .social-login {
            margin-top: 20px;
            display: flex;
            justify-content: center; /* Căn giữa theo chiều ngang */
        }

        .social-buttons {
            display: flex;
            gap: 8px; /* Giảm khoảng cách giữa hai nút */
            width: 100%;
            justify-content: center; /* Căn giữa các nút */
        }

        .social-buttons button {
            flex: 1; /* Các nút sẽ tự động giãn đều */
            padding: 6px 10px; /* Giảm padding thêm nữa */
            border: none;
            color: white;
            font-size: 13px; /* Giảm kích thước font chữ thêm nữa */
            cursor: pointer;
            text-align: center;
            display: flex;
            align-items: center; /* Căn giữa nội dung theo chiều dọc */
            justify-content: center; /* Căn giữa nội dung theo chiều ngang */
            border-radius: 4px; /* Bo góc nhẹ để trông đẹp hơn */
            height: 36px; /* Chiều cao cố định để đảm bảo cân đối */
        }

        .social-buttons button i {
            margin-right: 6px; /* Giảm khoảng cách giữa icon và văn bản */
            font-size: 14px; /* Điều chỉnh kích thước icon */
        }

        .social-buttons .facebook-btn {
            background-color: #3b5998;
        }

        .social-buttons .google-btn {
            background-color: #db4437;
        }
    </style>
</head>
<body>
<div class="wrapper">
    <h1>Đăng nhập</h1>
    <c:if test="${error != null}">
        <p class="alert alert-danger">${error}</p>
    </c:if>
    <form action="login" method="post">
        <input type="text" placeholder="Tên đăng nhập" name="username" required value="${username}">
        <input type="password" placeholder="Mật khẩu" name="password" required value="${password}">
        <div class="recover">
            <a href="quenmatkhau">Quên mật khẩu?</a>
        </div>
        <button style="border: none"> Đăng nhập</button>
    </form>
    <div class="social-login">
        <div class="social-buttons">
            <button type="button" class="facebook-btn" onclick="window.location.href='/your-app/facebook-login'">
                <i class="fab fa-facebook-f"></i> Đăng nhập với Facebook
            </button>

            <button type="button" class="google-btn" onclick="window.location.href='/Project_Web_war/google-login'">
                <i class="fab fa-google"></i> Đăng nhập với Google
            </button>

        </div>
    </div>
    <div class="member">
        Chưa có tài khoản ? <a href="dangky.jsp">
        Đăng ký ngay
    </a>
    </div>
</div>

<script src="https://apis.google.com/js/platform.js" async defer></script>
<script>
    function signIn() {
        // Gọi hàm onSignIn khi đăng nhập thành công
        gapi.load('auth2', function() {
            gapi.auth2.init().then(function() {
                var auth2 = gapi.auth2.getAuthInstance();
                auth2.signIn().then(onSignIn);
            });
        });
    }

    function onSignIn(googleUser) {
        var id_token = googleUser.getAuthResponse().id_token;
        var xhr = new XMLHttpRequest();
        xhr.open('POST', '/Project_Web_war/google-login', true);
        xhr.setRequestHeader('Content-Type', 'application/json');
        xhr.onload = function() {
            if (xhr.status === 200) {
                window.location.href = 'index.jsp'; // Redirect to home page after login success
            } else {
                console.error('Đăng nhập thất bại:', xhr.responseText);
            }
        };
        xhr.send(JSON.stringify({idtoken: id_token}));
    }
</script>

<c:if test="${success != null}">
    <script>
        alert("Đăng nhập thành công");
        document.location.href = "index.jsp";
    </script>
</c:if>


</body>
</html>

