package controller;

import model.User;
import org.mindrot.jbcrypt.BCrypt;
import com.fasterxml.jackson.databind.ObjectMapper;
import service.IUserService;
import service.impl.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import com.fasterxml.jackson.databind.SerializationFeature;

@WebServlet(value = "/quanlytaikhoan/account-edit")
public class EditAccountController extends HttpServlet {
    private IUserService userService = new UserServiceImpl();


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        String idParam = req.getParameter("id");

        if (idParam == null || idParam.isEmpty()) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            resp.getWriter().write("{\"error\": \"Missing user ID\"}");
            return;
        }

        Integer id;
        try {
            id = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            resp.getWriter().write("{\"error\": \"Invalid user ID format\"}");
            return;
        }

        User user = userService.getById(id);
        if (user == null) {
            System.out.println("⚠️ Không tìm thấy user với ID = " + id); // ✅ thêm dòng này
            resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
            resp.getWriter().write("{\"error\": \"User not found\"}");
            return;
        }

        ObjectMapper objectMapper = new ObjectMapper();
        objectMapper.registerModule(new JavaTimeModule()); // 👈 bắt buộc có
        objectMapper.disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS); // 👈 format ISO chuẩn
        objectMapper.writeValue(resp.getOutputStream(), user);
//            objectMapper.findAndRegisterModules(); // ✅ hỗ trợ LocalDate/LocalDateTime
//            objectMapper.writeValue(resp.getOutputStream(), user);
    }




    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        Integer id;
        try {
            id = Integer.parseInt(req.getParameter("id"));
        } catch (NumberFormatException e) {
            resp.sendRedirect("/quanlytaikhoan?error=invalid-id");
            return;
        }

        User existingUser = userService.getById(id);
        if (existingUser == null) {
            resp.sendRedirect("/quanlytaikhoan?error=user-not-found");
            return;
        }

        existingUser.setName(req.getParameter("name"));
        existingUser.setEmail(req.getParameter("email"));
        existingUser.setUsername(req.getParameter("user"));
        existingUser.setPhone(req.getParameter("phone"));
        existingUser.setAddress(req.getParameter("address"));
        existingUser.setGender(req.getParameter("gender"));

        String dateStr = req.getParameter("date");
        if (dateStr != null && !dateStr.isEmpty()) {
            existingUser.setBirth(LocalDate.parse(dateStr, DateTimeFormatter.ISO_DATE));
        }

        String newPassword = req.getParameter("password");
        if (newPassword != null && !newPassword.isEmpty()) {
            String hashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());
            existingUser.setPassword(hashedPassword);
        }

        existingUser.setUpdatedAt(LocalDateTime.now());
        userService.update(existingUser);

        resp.sendRedirect("/quanlytaikhoan?success=edit");
    }

}