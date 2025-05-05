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
            justify-content: center;
        }
        .social-buttons {
            display: flex;
            gap: 8px;
            width: 100%;
            justify-content: center;
        }
        .social-buttons button {
            flex: 1;
            padding: 6px 10px;
            border: none;
            color: white;
            font-size: 13px;
            cursor: pointer;
            text-align: center;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 4px;
            height: 36px;
        }
        .social-buttons button i {
            margin-right: 6px;
            font-size: 14px;
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
        <p class="alert alert-danger" id="errorMessage">${error}</p>
    </c:if>
    <form action="login" method="post" onsubmit="return validateCaptcha()">
        <input type="text" placeholder="Tên đăng nhập" name="username" required value="${username}">
        <input type="password" placeholder="Mật khẩu" name="password" required value="${password}">
        <div class="g-recaptcha" data-sitekey="6LcO8S4rAAAAAAImGtcuOSXPiJ2PlG30HGpY_7lw"></div>
        <br/>
        <div class="recover">
            <a href="quenmatkhau">Quên mật khẩu?</a>
        </div>
        <button style="border: none"> Đăng nhập</button>
    </form>
    <div class="social-login">
        <div class="social-buttons">
            <!-- Cập nhật URL redirect cho Facebook sử dụng giao thức HTTPS và port 8443 -->
            <button type="button" class="facebook-btn" onclick="window.location.href='https://www.facebook.com/dialog/oauth?client_id=1675975133288218&redirect_uri=https://localhost:8443/Project_Web_war/login-facebook&scope=email'">
                <i class="fab fa-facebook-f"></i> Đăng nhập với Facebook
            </button>
            <button type="button" class="google-btn" onclick="window.location.href='https://accounts.google.com/o/oauth2/auth?scope=openid%20email%20profile&redirect_uri=http://localhost:8080/Project_Web_war/google-callback&response_type=code&client_id=676076034879-g16cni1a76vt4bcvb49vvtq0ogqrfi5b.apps.googleusercontent.com'">
                <i class="fab fa-google"></i> Đăng nhập với Google
            </button>
        </div>
    </div>
    <div class="member">
        Chưa có tài khoản ? <a href="dangky.jsp">Đăng ký ngay</a>
    </div>
</div>

<script>
    function submitForm() {
        var registrationForm = document.getElementById('registrationForm');
        if (registrationForm.checkValidity()) {
            var overlay = document.getElementById('overlay');
            overlay.style.display = 'flex';
        } else {
            alert("Vui lòng điền đầy đủ thông tin và đồng ý với các điều khoản.");
        }
    }
</script>
<script src="https://apis.google.com/js/platform.js" async defer></script>
<script>
    function signIn() {
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
                window.location.href = 'index.jsp';
            } else {
                console.error('Đăng nhập thất bại:', xhr.responseText);
            }
        };
        xhr.send(JSON.stringify({idtoken: id_token}));
    }
</script>
<div class="overlay" id="overlay">
    <div class="success-message">
        <p> Đăng nhập thành công!</p>
        <br><a href="index.jsp">Tiếp tục mua hàng</a>
    </div>
</div>

<c:if test="${success != null}">
    <script>
        alert("Đăng nhập thành công");
        document.location.href = "index.jsp";
    </script>
</c:if>

<script>
    setTimeout(function() {
        var errorMsg = document.getElementById("errorMessage");
        if(errorMsg){
            errorMsg.style.display = "none";
        }
    }, 2000);

    function validateCaptcha() {
        var captchaResponse = grecaptcha.getResponse();
        if (captchaResponse.length === 0) {
            alert("Vui lòng hoàn thành CAPTCHA!");
            return false; // Ngừng gửi form nếu CAPTCHA chưa được hoàn thành
        }
        return true; // Cho phép gửi form nếu CAPTCHA đã được hoàn thành
    }

</script>
<script src="https://www.google.com/recaptcha/api.js" async defer></script>
</body>
</html>
