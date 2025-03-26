package Controller;

import model.User;
import service.IUserService;
import service.impl.userServiceImpl;
import com.fasterxml.jackson.databind.ObjectMapper;
import model.User;
import service.IUserService;
import service.impl.userServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;

import java.io.IOException;
import java.time.LocalDateTime;

@WebServlet(value = "/account/edit")
public class EditAccountController extends HttpServlet {
    private IUserService userService = new userServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json");
        ObjectMapper objectMapper = new ObjectMapper();
        Integer id = Integer.parseInt(req.getParameter("id"));
        User user = userService.getById(id);
        objectMapper.writeValue(resp.getOutputStream(), user);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        try {
            Integer id = Integer.parseInt(req.getParameter("id"));

            User existingUser = userService.getById(id);

            existingUser.setName(req.getParameter("name"));
            existingUser.setEmail(req.getParameter("email"));
            existingUser.setUsername(req.getParameter("user"));
            existingUser.setPassword(req.getParameter("password"));

            // Các trường OAuth (nếu không đổi thì có thể giữ nguyên giá trị cũ)
            existingUser.setOauthProvider(existingUser.getOauthProvider());
            existingUser.setOauthUid(existingUser.getOauthUid());
            existingUser.setOauthToken(existingUser.getOauthToken());

            // roleId và status có thể set giá trị mặc định hoặc giữ nguyên giá trị hiện tại
            existingUser.setRoleId(existingUser.getRoleId());
            existingUser.setStatus(existingUser.getStatus());

            // Cập nhật lại ngày chỉnh sửa
            existingUser.setUpdatedAt(LocalDateTime.now());

            userService.update(existingUser);

            resp.sendRedirect("/quanlytaikhoan");
        } catch (Exception e){
            e.printStackTrace();
        }
    }
}
