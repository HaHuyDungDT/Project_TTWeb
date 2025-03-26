package Controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import model.User;
import service.IUserService;
import service.impl.userServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;

@WebServlet(value = "/account/add")
public class AddAccountController extends HttpServlet {
    private IUserService userService = new userServiceImpl();

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
        ObjectMapper mapper = new ObjectMapper();
        mapper.findAndRegisterModules(); // Hỗ trợ LocalDate, LocalDateTime

        try {
            // Chuyển đổi request parameter sang User model
            User user = mapper.readValue(req.getInputStream(), User.class);

            // Set thêm thông tin mặc định (nếu cần)
            user.setRoleId(Integer.parseInt(req.getParameter("role")));
            user.setStatus(1); // trạng thái mặc định kích hoạt
            user.setCreatedAt(LocalDateTime.now());
            user.setUpdatedAt(LocalDateTime.now());

            userService.add(user, req.getParameter("role"));
            resp.sendRedirect("/quanlytaikhoan");
        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        }
    }

}
