package controller;

import model.GoogleAccount;
import model.User;
import service.impl.UserServiceImpl;
import utils.GoogleUtils;
import utils.SessionUtil;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Timestamp;

@WebServlet("/google-callback")
public class LoginGoogleServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserServiceImpl userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String code = request.getParameter("code");
        if (code == null || code.isEmpty()) {
            RequestDispatcher dispatcher = request.getRequestDispatcher("accessDenied.jsp");
            dispatcher.forward(request, response);
            return;
        }

        // Lấy access token và thông tin người dùng từ Google
        String accessToken = GoogleUtils.getToken(code);
        GoogleAccount googlePojo = GoogleUtils.getUserInfo(accessToken);

        // Kiểm tra xem người dùng này đã tồn tại trong DB hay chưa theo oauth_uid
        User existingUser = userService.getByOAuthUser(googlePojo.getId());
        if (existingUser == null) {
            // Nếu chưa tồn tại, ánh xạ thông tin từ GooglePojo sang đối tượng User
            User newUser = new User();
            newUser.setUsername(googlePojo.getEmail()); // Sử dụng email làm username
            newUser.setPassword(""); // Không cần mật khẩu với OAuth
            newUser.setOauthProvider("google");
            newUser.setOauthUid(googlePojo.getId());
            newUser.setOauthToken(accessToken);
            newUser.setName(googlePojo.getName());
            newUser.setEmail(googlePojo.getEmail());
            newUser.setPicture(googlePojo.getPicture());
            newUser.setRoleId(3); // Mã role cho người dùng thông thường (có thể điều chỉnh theo hệ thống của bạn)
            Timestamp now = new Timestamp(System.currentTimeMillis());
            newUser.setCreatedAt(now.toLocalDateTime());
            newUser.setUpdatedAt(now.toLocalDateTime());
            newUser.setStatus(1);
            // secretKey và twoFaEnabled sử dụng giá trị mặc định

            // Lưu dữ liệu mới vào DB
            boolean saved = userService.addGoogleUser(newUser);
            if (!saved) {
                response.sendRedirect("error.jsp");
                return;
            }

            // Lấy lại User từ DB để đảm bảo có ID (dựa theo oauth_uid)
            User createdUser = userService.getByOAuthUser(googlePojo.getId());
            SessionUtil.getInstance().putKey(request, "user", createdUser);
        } else {
            // Nếu người dùng đã tồn tại, cập nhật (nếu cần) và lưu vào session
            // Bạn có thể cập nhật access token hoặc các thông tin khác nếu cần
            SessionUtil.getInstance().putKey(request, "user", existingUser);
        }

        // Chuyển hướng người dùng về trang profile hoặc trang chủ
        response.sendRedirect("index.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}