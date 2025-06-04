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
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/quanlytaikhoan/update-role")
public class UpdateRoleController extends HttpServlet {
    private IUserService userService = new UserServiceImpl();
    private LogServiceImpl logService = new LogServiceImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        Map<String, Object> result = new HashMap<>();

        try {
            // Lấy thông tin admin hiện tại
            User adminUser = (User) SessionUtil.getInstance().getKey(request, "user");
            String adminUsername = adminUser != null ? adminUser.getUsername() : "Unknown";

            // Lấy thông tin từ request
            int userId = Integer.parseInt(request.getParameter("userId"));
            int newRoleId = Integer.parseInt(request.getParameter("roleId"));

            // Lấy thông tin user bị thay đổi quyền
            User targetUser = userService.getById(userId);
            if (targetUser == null) {
                result.put("success", false);
                result.put("message", "Không tìm thấy người dùng!");
                out.print(new com.google.gson.Gson().toJson(result));
                return;
            }

            // Cập nhật quyền trong database
            boolean success = userService.updateRole(userId, newRoleId);
            
            if (success) {
                // Log warning về việc thay đổi quyền
                logService.warning(String.format("Admin %s đã thay đổi quyền của user %s từ %d sang %d", 
                    adminUsername, 
                    targetUser.getUsername(),
                    targetUser.getRoleId(),
                    newRoleId));

                // Vô hiệu hóa tất cả session của user bị thay đổi quyền
                SessionUtil.getInstance().invalidateAllUserSessions(userId);

                result.put("success", true);
                result.put("message", "Cập nhật quyền thành công!");
            } else {
                result.put("success", false);
                result.put("message", "Cập nhật quyền thất bại!");
            }
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "Lỗi: " + e.getMessage());
        }

        out.print(new com.google.gson.Gson().toJson(result));
    }
} 