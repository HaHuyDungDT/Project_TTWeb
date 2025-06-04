package controller;

import model.User;
import org.mindrot.jbcrypt.BCrypt;
import com.fasterxml.jackson.databind.ObjectMapper;
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
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import com.fasterxml.jackson.databind.SerializationFeature;

@WebServlet(value = "/quanlytaikhoan/account-edit")
public class EditAccountController extends HttpServlet {
    private IUserService userService = new UserServiceImpl();
    private LogServiceImpl logService = new LogServiceImpl();
    private ObjectMapper objectMapper = new ObjectMapper();

    public EditAccountController() {
        objectMapper.registerModule(new JavaTimeModule());
        objectMapper.disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        String id = request.getParameter("id");
        if (id != null) {
            try {
                User user = userService.getById(Integer.parseInt(id));
                if (user != null) {
                    String jsonResponse = objectMapper.writeValueAsString(user);
                    response.getWriter().write(jsonResponse);
                } else {
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    response.getWriter().write("{\"error\":\"Không tìm thấy người dùng\"}");
                }
            } catch (NumberFormatException e) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"error\":\"ID không hợp lệ\"}");
            }
        } else {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\":\"Thiếu tham số ID\"}");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        try {
            // Get current admin user
            User adminUser = (User) SessionUtil.getInstance().getKey(request, "user");
            String adminUsername = adminUser != null ? adminUser.getUsername() : "Unknown";

            // Lấy thông tin từ form
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String dateStr = request.getParameter("date");
            String gender = request.getParameter("gender");
            String email = request.getParameter("email");
            String username = request.getParameter("user");
            String password = request.getParameter("password");
            int roleId = Integer.parseInt(request.getParameter("role"));

            // Lấy user hiện tại
            User currentUser = userService.getById(id);
            if (currentUser == null) {
                request.setAttribute("errorMessage", "Không tìm thấy người dùng!");
                request.getRequestDispatcher("/quanlytaikhoan").forward(request, response);
                return;
            }

            // Cập nhật thông tin
            currentUser.setName(name);
            currentUser.setPhone(phone);
            currentUser.setAddress(address);
            if (dateStr != null && !dateStr.isEmpty()) {
                currentUser.setBirth(LocalDate.parse(dateStr));
            }
            currentUser.setGender(gender);
            currentUser.setEmail(email);
            currentUser.setUsername(username);
            if (password != null && !password.isEmpty()) {
                // Mã hóa mật khẩu trước khi cập nhật
                String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
                currentUser.setPassword(hashedPassword);
            }
            currentUser.setRoleId(roleId);
            currentUser.setUpdatedAt(LocalDateTime.now());

            // Kiểm tra xem có thay đổi quyền không
            boolean roleChanged = currentUser.getRoleId() != roleId;

            // Cập nhật user
            boolean success = userService.update(currentUser);
            
            if (success) {
                // Log warning for account update
                logService.warning(String.format("Admin %s cập nhật tài khoản: %s (Role changed: %b, New role: %d)", 
                    adminUsername, 
                    currentUser.getUsername(), 
                    roleChanged,
                    roleId));

                // Nếu thay đổi quyền, hủy session của user đó
                if (roleChanged) {
                    HttpSession userSession = SessionUtil.getInstance().getSessionByUserId(id);
                    if (userSession != null) {
                        userSession.invalidate();
                    }
                }
                
                HttpSession session = request.getSession();
                session.setAttribute("editAccountSuccess", true);
                response.sendRedirect("/quanlytaikhoan");
            } else {
                request.setAttribute("errorMessage", "Cập nhật thông tin thất bại!");
                request.getRequestDispatcher("/quanlytaikhoan").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Lỗi: " + e.getMessage());
            request.getRequestDispatcher("/quanlytaikhoan").forward(request, response);
        }
    }
}