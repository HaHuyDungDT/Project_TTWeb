package controller;

import model.User;
import service.IUserService;
import service.impl.UserServiceImpl;
import service.impl.LogServiceImpl;
import utils.SessionUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(value = "/quanlytaikhoan/account-delete")
public class DeleteAccountController extends HttpServlet {
    private IUserService userService = new UserServiceImpl();
    private LogServiceImpl logService = new LogServiceImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        try {
            // Get current admin user
            User adminUser = (User) SessionUtil.getInstance().getKey(request, "user");
            String adminUsername = adminUser != null ? adminUser.getUsername() : "Unknown";

            int id = Integer.parseInt(request.getParameter("id"));
            
            // Get user info before deletion for logging
            User userToDelete = userService.getById(id);
            if (userToDelete == null) {
                request.setAttribute("errorMessage", "Không tìm thấy người dùng!");
                request.getRequestDispatcher("/quanlytaikhoan").forward(request, response);
                return;
            }

            try {
                userService.deleteById(id);
                // Log warning for account deletion
                logService.warning(String.format("Admin %s xóa tài khoản: %s (Role: %d)", 
                    adminUsername, 
                    userToDelete.getUsername(),
                    userToDelete.getRoleId()));

                // Hủy session của user bị xóa nếu đang online
                HttpSession userSession = SessionUtil.getInstance().getSessionByUserId(id);
                if (userSession != null) {
                    userSession.invalidate();
                }

                HttpSession session = request.getSession();
                session.setAttribute("deleteAccountSuccess", true);
                response.sendRedirect("/quanlytaikhoan");
            } catch (Exception e) {
                request.setAttribute("errorMessage", "Xóa tài khoản thất bại!");
                request.getRequestDispatcher("/quanlytaikhoan").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Lỗi: " + e.getMessage());
            request.getRequestDispatcher("/quanlytaikhoan").forward(request, response);
        }
    }
}