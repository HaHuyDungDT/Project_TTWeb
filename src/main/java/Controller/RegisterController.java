package Controller;

import model.User;
import service.IUserService;
import service.impl.userServiceImpl;
import utils.MailUtil;
import utils.SessionUtil;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.Random;

@WebServlet(value = "/register")
public class RegisterController extends HttpServlet {
    private IUserService userService = new userServiceImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String username = req.getParameter("username");
        String email = req.getParameter("email");
        String name = req.getParameter("name");
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("confirmPassword");

        req.setAttribute("username", username);
        req.setAttribute("email", email);
        req.setAttribute("name", name);

        if (password.equals(confirmPassword)) {
            if (userService.isUsernameExists(username)) {
                req.setAttribute("error", "Tên người dùng đã tồn tại!");
                req.getRequestDispatcher("dangky.jsp").forward(req, resp);
            } else {
                User user = new User();
                user.setUsername(username);
                user.setPassword(password);
                user.setName(name);
                user.setEmail(email);
                user.setOauthProvider(null);
                user.setOauthUid(null);
                user.setOauthToken(null);
                user.setRoleId(2); // Role mặc định: user thông thường (ví dụ roleId=2)
                user.setCreatedAt(LocalDateTime.now());
                user.setUpdatedAt(LocalDateTime.now());
                user.setStatus(1); // trạng thái kích hoạt

                SessionUtil.getInstance().putKey(req, "userObj", user);

                // Tạo mã xác thực
                Random random = new Random();
                String code = String.format("%06d", random.nextInt(999999));

                // Gửi mail chứa mã xác thực
                MailUtil.getInstance().sendMail("Mã code của bạn: " + code, "Mã xác thực tài khoản", email);

                SessionUtil.getInstance().putKey(req, "codes", code);

                resp.sendRedirect("entercode");
            }
        } else {
            req.setAttribute("error", "Mật khẩu và nhập lại mật khẩu không giống nhau");
            RequestDispatcher dispatcher = req.getRequestDispatcher("dangky.jsp");
            dispatcher.forward(req, resp);
        }
    }
}