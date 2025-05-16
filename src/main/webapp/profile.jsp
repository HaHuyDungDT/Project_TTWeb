<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.time.LocalDate" %>
<%
    int currentYear = LocalDate.now().getYear();
    request.setAttribute("currentYear", currentYear);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" href="./img/logo.png" type="image/x-icon"/>
    <title>Hồ Sơ Của Tôi</title>
    <!-- Google font -->
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">
    <!-- Bootstrap -->
    <link type="text/css" rel="stylesheet" href="css/bootstrap.min.css"/>
    <!-- Slick -->
    <link type="text/css" rel="stylesheet" href="css/slick.css"/>
    <link type="text/css" rel="stylesheet" href="css/slick-theme.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
          integrity="sha512-papN8Auqwsb5Jnu3hU0MGLuedlitO+lQ9B+8R4zbmlF+M8sN+IN0KjhWtmjSel6BxGR+N4e244MQ7vq6QQP2mw=="
          crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link type="text/css" rel="stylesheet" href="css/nouislider.min.css"/>
    <!-- Font Awesome Icon -->
    <link rel="stylesheet" href="css/font-awesome.min.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <!-- stlylesheet -->
    <link type="text/css" rel="stylesheet" href="css/style.css"/>
    <link rel="icon" href="./img/logo.png" type="image/x-icon"/>
    <link rel="stylesheet" href="css/font-awesome.min.css"/>
    <!-- jQuery Plugins -->
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/slick.min.js"></script>
    <script src="js/nouislider.min.js"></script>
    <script src="js/jquery.zoom.min.js"></script>
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
    <link rel="stylesheet" href="css/font-awesome.min.css"/>
    <style>
        /* Các style CSS dành riêng cho trang Profile */
        .profile-container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            margin: 20px auto;
            max-width: 1200px;
            padding: 20px;
        }
        .profile-container .sidebar {
            flex: 0 0 250px;
            background-color: #ffffff;
            padding: 20px;
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            transition: transform 0.3s ease;
        }
        .profile-container .sidebar:hover {
            transform: translateY(-3px);
        }
        .profile-container .sidebar .section-title {
            font-size: 16px;
            font-weight: bold;
            margin-bottom: 10px;
            color: #333;
            border-bottom: 1px solid #f0f0f0;
            padding-bottom: 5px;
            display: flex;
            align-items: center;
        }
        .profile-container .sidebar .section-title i {
            font-size: 1.2em;
            margin-right: 8px;
            color: #ff5722;
        }
        .profile-container .sidebar ul {
            list-style: none;
            padding: 0;
            margin: 0 0 20px;
        }
        .profile-container .sidebar li {
            margin-bottom: 10px;
        }
        .profile-container .sidebar a {
            display: flex;
            align-items: center;
            padding: 10px;
            color: #333;
            font-weight: bold;
            border-radius: 4px;
            text-decoration: none;
            transition: background-color 0.3s;
        }
        .profile-container .sidebar a i {
            font-size: 1em;
            margin-right: 8px;
            color: #555;
        }
        .profile-container .sidebar a:hover {
            background-color: #f7f7f7;
        }
        .profile-container .sidebar a.active {
            background-color: #ff5722;
            color: #fff;
        }
        .profile-container .sidebar a.active i {
            color: #fff;
        }
        .profile-container .content {
            flex: 1;
            background-color: #fff;
            padding: 30px;
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            transition: box-shadow 0.3s ease;
        }
        .profile-container .content:hover {
            box-shadow: 0 4px 12px rgba(0,0,0,0.2);
        }
        .profile-container .profile-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            border-bottom: 1px solid #f0f0f0;
            padding-bottom: 10px;
        }
        .profile-container .profile-info .profile-title {
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 5px;
            color: #333;
        }
        .profile-container .profile-info .profile-subtitle {
            font-size: 14px;
            color: #666;
        }
        .profile-container .form-group {
            margin-bottom: 20px;
        }
        .profile-container .form-label {
            font-weight: bold;
            font-size: 14px;
            margin-bottom: 5px;
            color: #555;
            display: block;
        }
        .profile-container input[type="text"],
        .profile-container input[type="email"],
        .profile-container select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
            box-sizing: border-box;
        }
        .profile-container .save-button {
            background-color: #ff5722;
            color: #fff;
            border: none;
            padding: 12px 20px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
        }
        .profile-container .save-button:hover {
            background-color: #e64a19;
        }
        .profile-container .avatar-upload {
            margin-top: 20px;
            text-align: center;
        }
        .profile-container .avatar-upload button {
            background-color: #6a5acd;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
        }
        .profile-container .avatar-upload button:hover {
            background-color: #5b4886;
        }
        @media (max-width: 768px) {
            .profile-container {
                flex-direction: column;
            }
            .profile-container .sidebar {
                width: 100%;
            }
        }
        .profile-avatar {
            width: 100px;
            height: 100px;
            overflow: hidden;
            border-radius: 50%;
        }
        .avatar-img {
            width: 100px;
            height: 100px;
            object-fit: cover;
            border-radius: 50%;
            display: block;
            margin: 0 auto;
        }

        #uploadBtn {
            margin-top: 10px;
            background: linear-gradient(45deg, #ff5722, #ff5722);
            color: #fff;
            border: none;
            padding: 8px 16px;
            border-radius: 50px;
            font-size: 14px;
            font-weight: bold;
            cursor: pointer;
            box-shadow: 0px 4px 8px rgba(0,0,0,0.1);
            transition: background 0.3s, transform 0.2s, box-shadow 0.2s;
        }

        #uploadBtn:hover {
            background: linear-gradient(45deg, #ff5722, #ff5722);
            transform: scale(1.05);
            box-shadow: 0px 6px 12px rgba(0,0,0,0.15);
        }

        #uploadBtn:active {
            transform: scale(0.98);
        }
    </style>
</head>
<body>

<!-- HEADER -->
<jsp:include page="header.jsp"/>
<!-- /HEADER -->

<!-- MENU -->
<jsp:include page="menu.jsp"/>
<!-- /MENU -->

<div class="profile-container">
    <div class="sidebar">
        <div class="section-title"><i class="fas fa-address-card"></i> Tài Khoản</div>
        <ul>
            <li><a href="#" class="active"><i class="fas fa-user-circle"></i> Hồ Sơ</a></li>
            <li><a href="#"><i class="fas fa-university"></i> Ngân Hàng</a></li>
            <li><a href="#"><i class="fas fa-map-marker-alt"></i> Địa Chỉ</a></li>
            <li><a href="changePassword"><i class="fas fa-key"></i> Đổi Mật Khẩu</a></li>
            <li><a href="#"><i class="fas fa-bell"></i> Cài Đặt Thông Báo</a></li>
            <li><a href="#"><i class="fas fa-cog"></i> Những Thiết Lập Riêng Tư</a></li>
        </ul>
        <div class="section-title"><i class="fas fa-shopping-cart"></i> Đơn Hàng</div>
        <ul>
            <li><a href="#"><i class="fas fa-file-alt"></i> Đơn Mua</a></li>
            <li><a href="#"><i class="fas fa-gift"></i> Kho Voucher</a></li>
            <li><a href="#"><i class="fas fa-coins"></i> Phukienphone Xu</a></li>
            <li><a href="#"><i class="fas fa-star"></i> Siêu Hội Freeship</a></li>
        </ul>
        <div class="section-title"><i class="fas fa-ellipsis-h"></i> Khác</div>
        <ul>
            <li><a href="#"><i class="fas fa-question-circle"></i> Trợ Giúp</a></li>
            <li><a href="#"><i class="fas fa-sign-out-alt"></i> Đăng Xuất</a></li>
        </ul>
    </div>

    <div class="content">
        <h2 class="profile-title">Hồ Sơ Của Tôi</h2>
        <c:choose>
            <c:when test="${user.twoFaEnabled}">
                <p class="text-success" style="font-size:16px;">Xác thực hai lớp (2FA) đã được bật.</p>
            </c:when>
            <c:otherwise>
                <p class="text-warning" style="font-size:16px;">
                    Bạn chưa bật xác thực hai lớp (2FA). Vui lòng nhấn vào
                    <a href="changePassword" style="color:#ff5722; font-weight:bold;">Đổi Mật Khẩu</a> để kích hoạt.
                </p>
            </c:otherwise>
        </c:choose>
        <p class="profile-subtitle">Quản lý thông tin hồ sơ để bảo mật tài khoản</p>

        <div class="row">
            <div class="col-md-8">
                <form id="profileForm"
                      action="${pageContext.request.contextPath}/api/profile/update"
                      method="post"
                      enctype="multipart/form-data"
                      accept-charset="UTF-8">
                    <div class="form-group">
                        <label class="form-label">OAuth User ID</label>
                        <input type="text" name="id" value="${user.oauthUid}" readonly />
                    </div>
                    <div class="form-group">
                        <label class="form-label">Tên đăng nhập</label>
                        <input type="text" name="username" value="${user.username}" readonly />
                        <small>Tên đăng nhập chỉ có thể thay đổi một lần.</small>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Tên</label>
                        <input id="nameInput"
                               type="text"
                               name="name"
                               placeholder="Nhập tên của bạn"
                               value="${user.name}"
                               class="form-control" />
                    </div>
                    <div class="form-group">
                        <label class="form-label">Email</label>
                        <input id="emailInput" type="email" name="email" value="${user.email}" readonly />
                        <button id="changeEmailBtn" type="button" style="color: blue; background:none; border:none; cursor:pointer;">Thay Đổi</button>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Số điện thoại</label>
                        <input id="phoneInput"
                               type="text"
                               name="phone"
                               class="form-control"
                               value="${user.phone}" />
                    </div>
                    <div class="form-group">
                        <label class="form-label">Giới tính</label>
                        <div>
                            <label>
                                <input type="radio" name="gender" value="Nam"
                                       <c:if test="${user.gender == 'Nam'}">checked</c:if> /> Nam
                            </label>
                            <label style="margin-left:20px">
                                <input type="radio" name="gender" value="Nữ"
                                       <c:if test="${user.gender == 'Nữ'}">checked</c:if> /> Nữ
                            </label>
                        </div>
                    </div>
                    <!-- ... -->
                    <button type="submit" class="save-button">Lưu</button>
                </form>
            </div>
            <div class="col-md-4">
                <div class="text-center">
                    <c:choose>
                        <c:when test="${not empty user.picture}">
                            <img src="${user.picture}" alt="Avatar" class="avatar-img">
                        </c:when>
                        <c:otherwise>
                            <div style="width:100px; height:100px; border-radius:50%; background-color:#ccc;
                                    display:flex; align-items:center; justify-content:center;
                                    font-size:36px; color:#fff; margin:0 auto;">
                                    ${fn:substring(user.name, 0, 1)}
                            </div>
                        </c:otherwise>
                    </c:choose>
                    <form id="uploadForm" enctype="multipart/form-data" method="post" action="api/avatar/upload">
                        <input type="file" name="avatar" id="avatarInput" accept="image/jpeg, image/png" style="display: none">
                        <button type="button" id="uploadBtn">⬆ Chọn Ảnh</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- FOOTER -->
<jsp:include page="footer.jsp"/>
<!-- /FOOTER -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $('#profileForm').on('submit', function(e) {
        e.preventDefault();
        var form = this, data = new FormData(form);
        $.ajax({
            url: $(form).attr('action'),
            method: 'POST',
            data: data,
            processData: false,
            contentType: false,
            headers: {'X-Requested-With':'XMLHttpRequest'},
            success: function(res) {
                if (res.ok) {
                    // cập nhật Name, Phone, Gender
                    $('#nameInput').val(res.name);
                    $('#phoneInput').val(res.phone);
                    $('input[name=gender][value="' + res.gender + '"]').prop('checked', true);
                    Toastify({ text: "Cập nhật thành công", className: "success" }).showToast();
                } else {
                    Toastify({ text: "Cập nhật thất bại", className: "error" }).showToast();
                }
            },
            error: function() {
                Toastify({ text: "Lỗi server", className: "error" }).showToast();
            }
        });
    });
</script>
<script>
    // Khi nhấn nút Upload Profile thì mở hộp chọn file
    document.getElementById("uploadBtn").addEventListener("click", function(){
        document.getElementById("avatarInput").click();
    });

    // Khi chọn file, tự động submit form
    document.getElementById("avatarInput").addEventListener("change", function(){
        if(this.files.length > 0) {
            document.getElementById("uploadForm").submit();
        }
    });

</script>
<script src="js/main.js"></script>
</body>
</html>
