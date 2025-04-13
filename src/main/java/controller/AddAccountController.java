package controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import model.User;
import service.IUserService;
import service.impl.UserServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import javax.servlet.RequestDispatcher;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@WebServlet(value = "/account/add")
public class AddAccountController extends HttpServlet {
    private IUserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json");
        ObjectMapper objectMapper = new ObjectMapper();
        if(userService.isEmailExists(req.getParameter("email"))){
            objectMapper.writeValue(resp.getOutputStream(), false);
            return;
        }
        objectMapper.writeValue(resp.getOutputStream(), true);
    }

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json");
        ObjectMapper objectMapper = new ObjectMapper();
        System.out.println(req.getParameter("user"));
        if(userService.isUsernameExists(req.getParameter("user"))){
            objectMapper.writeValue(resp.getOutputStream(), false);
            return;
        }
        objectMapper.writeValue(resp.getOutputStream(), true);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json");
        ObjectMapper mapper = new ObjectMapper();
        mapper.findAndRegisterModules(); // Hỗ trợ LocalDate, LocalDateTime

        try {
            // Chuyển đổi request parameter sang User model
            User user = new User();

            user.setUsername(req.getParameter("user"));
            user.setPassword(req.getParameter("password"));
            user.setName(req.getParameter("name"));
            user.setEmail(req.getParameter("email"));
            user.setPhone(req.getParameter("phone")); // Lấy số điện thoại
            String birthDateStr = req.getParameter("birth");
            if (birthDateStr != null && !birthDateStr.isEmpty()) {
                user.setBirth(LocalDate.parse(birthDateStr, DateTimeFormatter.ISO_DATE)); // Lấy và parse ngày sinh
            }
            user.setGender(req.getParameter("gender")); // Lấy giới tính
            user.setAddress(req.getParameter("address")); // Lấy địa chỉ
//            user.setCreatedAt(LocalDateTime.now());
            user.setRoleId(Integer.parseInt(req.getParameter("role"))); // Giả sử "role" là ID của role
            user.setStatus(1); // Trạng thái mặc định là kích hoạt
            // Kiểm tra sự tồn tại của email và username
            if (userService.isEmailExists(user.getEmail()) || userService.isUsernameExists(user.getUsername())) {
                resp.getWriter().write("Email hoặc username đã tồn tại.");
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                return;
            }
            // Thêm người dùng vào cơ sở dữ liệu
            userService.add(user, req.getParameter("role"));
            resp.sendRedirect("");
        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        }
    }
}


