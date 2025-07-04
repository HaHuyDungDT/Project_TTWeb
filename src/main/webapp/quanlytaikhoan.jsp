<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="utils.SessionUtil" %>
<%@ page import="model.User" %>
<%@ page import="dao.impl.UserDaoImpl" %>
<%
    // Kiểm tra đăng nhập & phân quyền
    User user = (User) SessionUtil.getInstance()
            .getKey((javax.servlet.http.HttpServletRequest) request, "user");
    if (user == null || (user.getRoleId() != 1 ) && (user.getRoleId() != 2)) {
        response.sendRedirect("dangnhap.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head lang="en">
    <title>Admin</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport"
          content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="icon" type="image/png" href="./img/logo.png"/>

    <!-- Import lib -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.css">
    <link rel="stylesheet" type="text/css" href="./css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet">
    <link type="text/css" rel="stylesheet" href="css/style.css"/>
    <!-- End import lib -->
    <link rel="stylesheet" type="text/css" href="css/styleAdmin.css">
</head>

<body class="overlay-scrollbar">
<!-- navbar -->
<div class="navbar">
    <!-- nav left -->
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link">
                <i class="fa-solid fa-bars" onclick="collapseSidebar()"></i>
            </a>
        </li>
        <li class="nav-item">
            <img src="./img/logo.png" alt="logo" class="logo logo-light">
        </li>
    </ul>
    <!-- end nav left -->

    <!-- nav right -->
    <ul class="navbar-nav nav-right">
        <li class="nav-item dropdown">
            <a class="nav-link">
                <i class="fas fa-bell dropdown-toggle" data-toggle="notification-menu"></i>
                <span class="navbar-badge">1</span>
            </a>
            <ul id="notification-menu" class="dropdown-menu notification-menu">
                <div class="dropdown-menu-header">
						<span>
							Thông báo
						</span>
                </div>
                <div class="dropdown-menu-content overlay-scrollbar scrollbar-hover">
                    <li class="dropdown-menu-item">
                        <a href="#" class="dropdown-menu-link">
                            <div>
                                <i class="fas fa-gift"></i>
                            </div>
                            <span>
                Thông báo kết thúc khuyến mãi
                <br>
                <span>
                  15/07/2020
                </span>
              </span>
                        </a>
                    </li>
                </div>
                <div class="dropdown-menu-footer">
						<span>
						</span>
                </div>
            </ul>
        </li>

        <li class="nav-item avt-wrapper">
            <div class="avt dropdown">
                <img src="./img/admin1.jpg" alt="User image" class="dropdown-toggle" data-toggle="user-menu">
                <ul id="user-menu" class="dropdown-menu">
                    <li class="dropdown-menu-item">
                        <a class="dropdown-menu-link">
                            <div>
                                <i class="fas fa-user-tie"></i>
                            </div>
                            <span>Thông tin cá nhân</span>
                        </a>
                    </li>
                    <li class="dropdown-menu-item">
                        <a href="#" class="dropdown-menu-link">
                            <div>
                                <i class="fas fa-sign-out-alt"></i>
                            </div>
                            <span>Đăng xuất</span>
                        </a>
                    </li>
                </ul>
            </div>
        </li>
    </ul>
    <!-- end nav right -->
</div>
<br>
<!-- end navbar -->
<!-- sidebar -->
<div class="sidebar">
    <ul class="sidebar-nav">
        <li class="sidebar-nav-item">
            <a href="/admin" class="sidebar-nav-link">
                <div>
                    <i class="fa fa-user"></i>
                </div>
                <span>Dashboard</span>
            </a>
        </li>
        <li class="sidebar-nav-item">
            <a href="/thongke" class="sidebar-nav-link" >
                <div><i class="fa-solid fa-signal"></i></div>
                <span>Thông số bán hàng</span>
            </a>
        </li>
        <li class="sidebar-nav-item">
            <a href="/quanlysanpham" class="sidebar-nav-link">
                <div><i class="fa fa-mobile"></i></div>
                <span>Quản lý sản phẩm</span>
            </a>
        </li>
        <li class="sidebar-nav-item">
            <a href="/quanlydanhmuc.jsp" class="sidebar-nav-link">
                <div><i class="fas fa-list-alt"></i></div>
                <span>Quản lý danh mục sản phẩm</span>
            </a>
        </li>
        <li class="sidebar-nav-item">
            <a href="/quanlydonhang" class="sidebar-nav-link">
                <div>
                    <i class="fa-solid fa-layer-group"></i>
                </div>
                <span>Quản lý đơn hàng</span>
            </a>
        </li>
        <li class="sidebar-nav-item">
            <a href="/quanlytaikhoan" class="sidebar-nav-link">
                <div>
                    <i class="fa-solid fa-circle-user"></i>
                </div>
                <span>Quản lý tài khoản</span>
            </a>
        </li>
        <li class="sidebar-nav-item">
            <a href="/quanlytonkho" class="sidebar-nav-link">
                <div>
                    <i class="fa-solid fa-boxes-stacked"></i>
                </div>
                <span>Quản lý tồn kho</span>
            </a>
        </li>
        <li class="sidebar-nav-item">
            <a href="/quanlylog.jsp" class="sidebar-nav-link ">
                <div>
                    <i class="fa-solid fa-clipboard-list"></i>
                </div>
                <span>Quản lý log</span>
            </a>
        </li>
    </ul>
</div>


<!-- end sidebar -->
<!-- main content -->
<div class="wrapper">
    <div class="row">
        <div class="col-8 col-m-12 col-sm-12">

            <div class="card">
                <div class="card-header" style="display: flex">
                    <h3>
                        Quản lý tài khoản
                    </h3>
                    <a href="#addEmployeeModal" class="btn btn-success" data-toggle="modal" style="margin-left: auto">
                        <span>Thêm tài khoản mới</span></a>
                </div>
                <div class="card-content">
                    <table class="table table-striped">
                        <thead>
                        <tr>
                            <th>#</th>
                            <th>Họ tên</th>
                            <th>Số điện thoại</th>
                            <th>Ngày Sinh</th>
                            <th>Giới tính</th>
                            <th>Địa chỉ</th>
                            <th>Email</th>
                            <th>Username</th>
                            <th>Password</th>
                            <th>Quyền</th>
                            <th>Hành động</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="item" items="${users}">
                            <tr>
                                <td>${item.id}</td>
                                <td>${item.name}</td>
                                <td>${item.phone}</td>
                                <td>${item.birth}</td>
                                <td>${item.gender}</td>
                                <td>${item.address}</td>
                                <td>${item.email}</td>
                                <td>${item.username}</td>
                                <td>${item.password}</td>
                                <td>
                                    <select class="form-control role-select" data-user-id="${item.id}" ${user.roleId != 1 ? 'disabled' : ''}>
                                        <option value="${item.roleId}" selected>${item.roleId == 1 ? 'Admin' : item.roleId == 2 ? 'Mod' : 'User'}</option>
                                        <c:if test="${item.roleId != 1}"><option value="1">Admin</option></c:if>
                                        <c:if test="${item.roleId != 2}"><option value="2">Mod</option></c:if>
                                        <c:if test="${item.roleId != 3}"><option value="3">User</option></c:if>
                                    </select>
                                </td>
                                <td>
                                    <a href="#"
                                       data-id="${item.id}"
                                       data-name="${item.name}"
                                       data-phone_number="${item.phone}"
                                       data-birth="${item.birth}"
                                       data-gender="${item.gender}"
                                       data-address="${item.address}"
                                       data-email="${item.email}"
                                       data-user_name="${item.username}"
                                       data-password="${item.password}"
                                       class="edit"
                                       data-toggle="modal">
                                        <i class="material-icons" data-toggle="tooltip" title="Edit">&#xE254;</i>
                                    </a>
                                    <a href="#" data-id="${item.id}" class="delete" data-toggle="modal">
                                        <i class="material-icons" data-toggle="tooltip" title="Delete">&#xE872;</i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Edit-->
<div id="editEmployeeModal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action ="/quanlytaikhoan/account-edit" id="edit" method="post">
                <div class="modal-header">
                    <h4 class="modal-title">Thay đổi thông tin</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                </div>
                <div class="modal-body">
                    <input type="text" hidden class="form-control" required name="id" id="editId">
                    <div class="form-group">
                        <label>Họ tên</label>
                        <input type="text" class="form-control" required name="name" id="editName">
                    </div>
                    <div class="form-group">
                        <label>Số điện thoại</label>
                        <input type="tel" class="form-control" required name="phone" id="editPhone">
                    </div>
                    <div class="form-group">
                        <label>Địa chỉ</label>
                        <textarea class="form-control" required name="address" id="editAddress"></textarea>
                    </div>
                    <div class="form-group">
                        <label>Ngày sinh</label>
                        <input type="date" class="form-control" required name="date" id="editDate">
                    </div>
                    <div class="form-group">
                        <label>Giới tính</label>
                        <select class="form-control" required name="gender" id="editGender">
                            <option value="Nam">Nam</option>
                            <option value="Nữ">Nữ</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Email</label>
                        <input type="email" class="form-control" required name="email" id="editEmail">
                    </div>
                    <div class="form-group">
                        <label>User</label>
                        <input type="text" class="form-control" required name="user" id="editUser">
                    </div>
                    <div class="form-group">
                        <label>Password</label>
                        <input type="password" class="form-control" name="password" id="editPassword">
                    </div>
                    <div class="form-group">
                        <label>Quyền</label>
                        <select class="form-control" required name="role" id="editRole">
                            <option value="1">Admin</option>
                            <option value="2">User</option>
                            <option value="3">Mod</option>
                        </select>
                    </div>
                </div>
                <div class="modal-footer">
                    <input type="button" class="btn btn-default" data-dismiss="modal" value="Hủy">
                    <button type="submit" class="btn btn-info">Lưu</button>
                </div>
            </form>
        </div>
    </div>
</div>
<!--/ Edit-->

<!-- Delete-->

<div id="deleteEmployeeModal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="/quanlytaikhoan/account-delete"  id="deleteForm" method="post">
                <div class="modal-header">
                    <h4 class="modal-title">Xóa tài khoản này</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                </div>
                <div class="modal-body">
                    <p>Bạn có chắc chắn muốn xóa tài khoản này?</p>
                    <p class="text-warning"><small>Hành động này sẽ không thể hoàn lại.</small></p>
                </div>
                <input type="text" hidden name="id" id="idDel">
                <div class="modal-footer">
                    <input type="button" class="btn btn-default" data-dismiss="modal" value="Hủy">
                    <button type="submit" id="btnDel" class="btn btn-danger">Xóa</button> <!-- Sửa nút submit -->
                </div>
            </form>
        </div>
    </div>
</div>
<!--/ Delete-->
<!--/ Add -->
<div id="addEmployeeModal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="/quanlytaikhoan/account-add" method="post" id="add">

                <div class="modal-header">
                    <h4 class="modal-title">Thêm tài khoản mới</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label>Họ tên</label>
                        <input type="text" class="form-control" required name="name" id="addName">
                    </div>
                    <div class="form-group">
                        <label>Số điện thoại</label>
                        <input type="tel" class="form-control" required name="phone" id="addPhone">
                    </div>
                    <div class="form-group">
                        <label>Ngày sinh</label>
                        <input type="date" class="form-control" required name="birth" id="addDate">
                    </div>
                    <div class="form-group">
                        <label>Giới tính</label>
                        <select class="form-control" required name="gender" id="addGender">
                            <option value="Nam">Nam</option>
                            <option value="Nữ">Nữ</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Quyền</label>
                        <select class="form-control" required name="role" id="addRole">
                            <option value="1">Admin</option>
                            <option value="2">Mod</option>
                            <option value="3">User</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Địa chỉ</label>
                        <textarea class="form-control" required name="address" id="addAddress"></textarea>
                    </div>
                    <div class="form-group">
                        <label>Email</label>
                        <input type="email" class="form-control" required name="email" id="addEmail">
                    </div>
                    <div class="form-group">
                        <label>User</label>
                        <input type="text" class="form-control" required name="user" id="addUser">
                    </div>
                    <div class="form-group">
                        <label>Password</label>
                        <input type="password" class="form-control" required name="password" id="addPassword">
                    </div>
                </div>

                <div class="modal-footer">
                    <input type="button" class="btn btn-default" data-dismiss="modal" value="Hủy">
                    <button type="submit" class="btn btn-success">Thêm</button>
                </div>
            </form>
        </div>
    </div>
</div>


</div>
<!-- Modal Thêm thành công -->
<div class="modal fade" id="addSuccessModal" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content bg-white rounded">
            <div class="modal-header">
                <h5 class="modal-title">Thêm thành công</h5>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body text-center">
                Tài khoản đã được thêm thành công!
            </div>
        </div>
    </div>
</div>

<!-- Modal Sửa thành công -->
<div class="modal fade" id="editSuccessModal" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content bg-white rounded">
            <div class="modal-header">
                <h5 class="modal-title">Sửa thành công</h5>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body text-center">
                Thông tin tài khoản đã được cập nhật thành công!
            </div>
        </div>
    </div>
</div>

<!-- Modal Xóa thành công -->
<div class="modal fade" id="deleteSuccessModal" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content bg-white rounded">
            <div class="modal-header">
                <h5 class="modal-title">Xóa thành công</h5>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body text-center">
                Tài khoản đã được xóa thành công!
            </div>
        </div>
    </div>
</div>


<!-- end main content -->

<!-- import script -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js"></script>
<script src="js/admin.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>

<!-- end import script -->
<script>
$(document).ready(function() {
    // Xử lý khi click vào nút edit
    $('.edit').on('click', function(e) {
        e.preventDefault();
        const btn = $(this);
        const id = btn.data('id');
        
        // Gọi API để lấy dữ liệu user
        $.ajax({
            url: "/quanlytaikhoan/account-edit?id=" + id,
            method: "GET",
            dataType: "json",
            success: function(user) {
                if (user) {
                    $('#editId').val(user.id);
                    $('#editName').val(user.name);
                    $('#editPhone').val(user.phone);
                    $('#editAddress').val(user.address);
                    
                    // Xử lý ngày sinh
                    if (user.birth) {
                        const dateObj = new Date(user.birth);
                        const formattedDate = dateObj.toISOString().split('T')[0];
                        $('#editDate').val(formattedDate);
                    } else {
                        $('#editDate').val('');
                    }
                    
                    $('#editGender').val(user.gender);
                    $('#editEmail').val(user.email);
                    $('#editUser').val(user.username);
                    $('#editPassword').val("");
                    $('#editRole').val(user.roleId);
                    $('#editEmployeeModal').modal('show');
                } else {
                    alert("Không thể lấy thông tin người dùng");
                }
            },
            error: function(xhr, status, error) {
                console.error("Error:", error);
                alert("Không thể lấy thông tin người dùng");
            }
        });
    });

    // Xử lý form edit
    $('#edit').on('submit', function(e) {
        e.preventDefault();
        const formData = {
            id: $('#editId').val(),
            name: $('#editName').val(),
            phone: $('#editPhone').val(),
            address: $('#editAddress').val(),
            date: $('#editDate').val(),
            gender: $('#editGender').val(),
            email: $('#editEmail').val(),
            user: $('#editUser').val(),
            password: $('#editPassword').val(),
            role: $('#editRole').val()
        };

        $.ajax({
            url: "/quanlytaikhoan/account-edit",
            method: "POST",
            data: formData,
            success: function(response) {
                $('#editEmployeeModal').modal('hide');
                window.location.reload();
            },
            error: function(xhr, status, error) {
                console.error("Error:", error);
                alert("Có lỗi xảy ra khi cập nhật thông tin");
            }
        });
    });

    // Xử lý cập nhật quyền
    $('.role-select').on('change', function() {
        const userId = $(this).data('user-id');
        const newRoleId = $(this).val();
        const select = $(this);
        
        if(confirm('Bạn có chắc chắn muốn thay đổi quyền của người dùng này?')) {
            $.ajax({
                url: '/quanlytaikhoan/update-role',
                method: 'POST',
                data: {
                    userId: userId,
                    roleId: newRoleId
                },
                success: function(response) {
                    try {
                        const result = typeof response === 'string' ? JSON.parse(response) : response;
                        if(result.success) {
                            alert('Cập nhật quyền thành công!');
                            window.location.reload();
                        } else {
                            alert(result.message || 'Có lỗi xảy ra khi cập nhật quyền!');
                            select.val(select.find('option:selected').val()); // Reset về giá trị cũ
                        }
                    } catch(e) {
                        console.error("Error parsing response:", e);
                        alert('Có lỗi xảy ra khi cập nhật quyền!');
                        select.val(select.find('option:selected').val()); // Reset về giá trị cũ
                    }
                },
                error: function(xhr, status, error) {
                    console.error("Error:", error);
                    alert('Có lỗi xảy ra khi cập nhật quyền!');
                    select.val(select.find('option:selected').val()); // Reset về giá trị cũ
                }
            });
        } else {
            // Reset về giá trị cũ nếu người dùng hủy
            select.val(select.find('option:selected').val());
        }
    });

    // Sự kiện xóa tài khoản
    $('.delete').on('click', function (e) {
        e.preventDefault();
        var btn = $(this);
        var id = btn.data('id');
        $('#idDel').val(id);  // Lưu ID vào input hidden
        $('#deleteEmployeeModal').modal('show'); // Hiển thị modal xác nhận

        // Xử lý xóa tài khoản khi nhấn nút Xóa trong modal
        $('#btnDel').on('click', function () {
            $.ajax({
                url: "/quanlytaikhoan/account-delete",  // Đường dẫn xóa tài khoản
                method: "POST",
                data: { id: id },
                success: function (response) {
                    location.reload();  // Reload lại trang
                },
                error: function () {
                    alert('Đã có lỗi xảy ra khi xóa tài khoản');
                }
            });
        });
    });

    // xử lý form add user
    $('#add').on('submit', function(e) {
        e.preventDefault(); // Ngăn form gửi mặc định

        let form = $(this);
        let name = $('#addName').val();
        let address = $('#addAddress').val();
        let date = $('#addDate').val();
        let phone = $('#addPhone').val();
        let email = $('#addEmail').val();
        let user = $('#addUser').val();
        let password = $('#addPassword').val();
        let gender = $('#addGender').val();
        let role = $('#addRole').val();

        if (!name || !address || !date || !phone || !email || !user || !password) {
            alert('Hãy nhập đầy đủ thông tin!');
            return;
        }

        var regexEmail = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/i;
        var regexPhone = /^0(3|5|7|8|9)[0-9]{8}$/i;

        if (!regexEmail.test(removeAscent(email))) {
            alert('Sai định dạng Email!');
            return;
        }

        if (!regexPhone.test(removeAscent(phone))) {
            alert('Sai định dạng số điện thoại!');
            return;
        }

        // Kiểm tra email
        $.ajax({
            url: "/quanlytaikhoan/account-add?email=" + email,
            dataType: "json",
            method: "GET",
            success: (emailOK) => {
                if (emailOK) {
                    // Kiểm tra user
                    $.ajax({
                        url: "/quanlytaikhoan/account-add?user=" + user,
                        dataType: "json",
                        method: "PUT",
                        success: (userOK) => {
                            if (userOK) {
                                // Submit lại thật sự bằng JavaScript
                                form.unbind('submit').submit();
                            } else {
                                alert("Username đã tồn tại!");
                            }
                        }
                    });
                } else {
                    alert("Email đã tồn tại!");
                }
            }
        });
    });
});

// Hàm xử lý dấu tiếng Việt
function removeAscent(str) {
    if (str === null || str === undefined) return '';
    str = str.toLowerCase();
    str = str.normalize("NFD").replace(/[\u0300-\u036f]/g, ""); // bỏ dấu tiếng Việt
    str = str.replace(/đ/g, "d").replace(/Đ/g, "D");
    return str;
}

// Thông báo Thêm
$(document).ready(function () {
    <% Boolean addSuccess = (Boolean) session.getAttribute("addAccountSuccess"); %>
    <% if (addSuccess != null && addSuccess) { %>
    $('#addSuccessModal').modal('show');
    <% session.removeAttribute("addAccountSuccess"); %>
    <% } %>
});

// Thông báo Sửa
$(document).ready(function () {
    <% Boolean editSuccess = (Boolean) session.getAttribute("editAccountSuccess"); %>
    <% if (editSuccess != null && editSuccess) { %>
    $('#editSuccessModal').modal('show');
    <% session.removeAttribute("editAccountSuccess"); %>
    <% } %>
});

// Thông báo Xóa
$(document).ready(function () {
    <% Boolean deleteSuccess = (Boolean) session.getAttribute("deleteAccountSuccess"); %>
    <% if (deleteSuccess != null && deleteSuccess) { %>
    $('#deleteSuccessModal').modal('show');
    <% session.removeAttribute("deleteAccountSuccess"); %>
    <% } %>
});
</script>
</body>
</html>