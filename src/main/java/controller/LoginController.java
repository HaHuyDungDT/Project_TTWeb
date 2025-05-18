package controller;

import model.User;
import service.IUserService;
import service.impl.UserServiceImpl;
import utils.CaptchaUtil;
import utils.SessionUtil;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.time.Instant;

@WebServlet(name = "LoginController", value = "/login")
public class LoginController extends HttpServlet {
    private IUserService userService = new UserServiceImpl();

    // Ví dụ đơn giản: kiểm tra hành vi bất thường dựa trên số lần gửi request trong khoảng thời gian ngắn
    private boolean isAbnormal(HttpServletRequest req) {
        // Giả sử ta lưu thời điểm request vào session mỗi lần đăng nhập
        HttpSession session = req.getSession();
        Long lastAttempt = (Long) session.getAttribute("lastAttempt");
        Integer rapidAttempts = (Integer) session.getAttribute("rapidAttempts");

        long now = Instant.now().toEpochMilli();
        if (lastAttempt == null) {
            session.setAttribute("lastAttempt", now);
            session.setAttribute("rapidAttempts", 1);
            return false;
        }
        long diff = now - lastAttempt;
        if (diff < 30000) { // nếu có hơn 1 request trong vòng 30 giây
            rapidAttempts = (rapidAttempts == null ? 1 : rapidAttempts + 1);
            session.setAttribute("rapidAttempts", rapidAttempts);
        } else {
            rapidAttempts = 1;
            session.setAttribute("rapidAttempts", rapidAttempts);
        }
        session.setAttribute("lastAttempt", now);
        // Ví dụ: nếu có hơn 5 request trong vòng 30 giây, coi là hành vi bất thường
        return rapidAttempts > 5;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Ban đầu, CAPTCHA không được hiển thị
        req.setAttribute("showCaptcha", false);
        RequestDispatcher dispatcher = req.getRequestDispatcher("dangnhap.jsp");
        dispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        Integer failures = (Integer) session.getAttribute("loginFailures");
        if (failures == null) {
            failures = 0;
        }

        // Xác định xem có nên bắt buộc CAPTCHA:
        // Nếu số lần đăng nhập thất bại >= 3 hoặc hệ thống phát hiện hành vi bất thường.
        boolean requireCaptcha = (failures >= 3) || isAbnormal(req);
        if (requireCaptcha) {
            String captchaResponse = req.getParameter("g-recaptcha-response");
            if (captchaResponse == null || captchaResponse.trim().isEmpty() || !CaptchaUtil.verifyCaptcha(captchaResponse)) {
                req.setAttribute("error", "Vui lòng hoàn thành CAPTCHA!");
                req.setAttribute("showCaptcha", true);
                req.setAttribute("username", username);
                req.setAttribute("password", "");
                req.getRequestDispatcher("dangnhap.jsp").forward(req, resp);
                return;
            }
        }

        // CAPTCHA đã được xác thực hoặc không cần thiết => ẩn CAPTCHA
        req.setAttribute("showCaptcha", false);
        req.setAttribute("username", username);
        req.setAttribute("password", "");

        if (userService.login(username, password)) {
            User loggedInUser = userService.getByUsername(username);
            if (loggedInUser != null) {
                session.setAttribute("user", loggedInUser);
                // Reset số lần thất bại và các chỉ số liên quan đến hành vi bất thường
                session.setAttribute("loginFailures", 0);
                session.removeAttribute("rapidAttempts");
                session.removeAttribute("lastAttempt");
                if (loggedInUser.getRoleId() == 1 || loggedInUser.getRoleId() == 2) {
                    resp.sendRedirect("admin.jsp");
                } else {
                    resp.sendRedirect("index.jsp");
                }
            } else {
                req.setAttribute("error", "Không tìm thấy thông tin người dùng!");
                req.getRequestDispatcher("dangnhap.jsp").forward(req, resp);
            }
        } else {
            // Tăng số lần đăng nhập thất bại
            session.setAttribute("loginFailures", failures + 1);
            req.setAttribute("error", "Tên người dùng hoặc mật khẩu không chính xác!");
            // Nếu sau lần lỗi hiện tại, hệ thống thấy phải bắt CAPTCHA thì hiển thị nó
            if ((failures + 1) >= 3 || isAbnormal(req)) {
                req.setAttribute("showCaptcha", true);
            } else {
                req.setAttribute("showCaptcha", false);
            }
            req.getRequestDispatcher("dangnhap.jsp").forward(req, resp);
        }
    }
}