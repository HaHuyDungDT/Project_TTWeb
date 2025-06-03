package controller;

import model.Log;
import model.User;
import service.ILogService;
import service.IUserService;
import service.impl.LogServiceImpl;
import service.impl.UserServiceImpl;
import utils.CaptchaUtil;
import utils.LevelLog;
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
    private ILogService logService = new LogServiceImpl();

    // Kiểm tra hành vi bất thường dựa trên số lần gửi request trong khoảng thời gian ngắn
    private boolean isAbnormal(HttpServletRequest req) {
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
        if (diff < 30000) { // Nếu có hơn 1 request trong vòng 30 giây
            rapidAttempts = (rapidAttempts == null ? 1 : rapidAttempts + 1);
            session.setAttribute("rapidAttempts", rapidAttempts);
        } else {
            rapidAttempts = 1;
            session.setAttribute("rapidAttempts", rapidAttempts);
        }
        session.setAttribute("lastAttempt", now);
        return rapidAttempts > 5;
    }

    private void logLoginAttempt(String username, String ipAddress, boolean success, String message, LevelLog level) {
        Log log = new Log();
        log.setLevel(level);
        log.setAction("Cố gắng đăng nhập - " + (success ? "Thành công" : "Thất bại") + " - " + message);
        log.setAddressIP(ipAddress);
        log.setUserId(null); // Chưa có userId vì chưa đăng nhập thành công
        logService.save(log);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("showCaptcha", false);
        RequestDispatcher dispatcher = req.getRequestDispatcher("dangnhap.jsp");
        dispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String ipAddress = req.getRemoteAddr();

        Integer failures = (Integer) session.getAttribute("loginFailures");
        if (failures == null) {
            failures = 0;
        }

        boolean requireCaptcha = (failures >= 3) || isAbnormal(req);
        if (requireCaptcha) {
            String captchaResponse = req.getParameter("g-recaptcha-response");
            if (captchaResponse == null || captchaResponse.trim().isEmpty() || !CaptchaUtil.verifyCaptcha(captchaResponse)) {
                logLoginAttempt(username, ipAddress, false, "Xác minh CAPTCHA thất bại", LevelLog.WARNING);
                req.setAttribute("error", "Vui lòng hoàn thành CAPTCHA!");
                req.setAttribute("showCaptcha", true);
                req.setAttribute("username", username);
                req.setAttribute("password", "");
                req.getRequestDispatcher("dangnhap.jsp").forward(req, resp);
                return;
            }
        }

        req.setAttribute("showCaptcha", false);
        req.setAttribute("username", username);
        req.setAttribute("password", "");

        if (userService.login(username, password)) {
            User loggedInUser = userService.getByUsername(username);
            if (loggedInUser != null) {
                SessionUtil.getInstance().putKey(req, "user", loggedInUser);
                session.setAttribute("loginFailures", 0);
                session.removeAttribute("rapidAttempts");
                session.removeAttribute("lastAttempt");

                logLoginAttempt(username, ipAddress, true, "Người dùng đã đăng nhập thành công", LevelLog.INFO);

                if (loggedInUser.getRoleId() == 1 || loggedInUser.getRoleId() == 2) {
                    resp.sendRedirect("admin.jsp");
                } else {
                    resp.sendRedirect("index.jsp");
                }
            } else {
                logLoginAttempt(username, ipAddress, false, "Không tìm thấy người dùng sau khi xác thực thành công", LevelLog.DANGER);
                req.setAttribute("error", "Không tìm thấy thông tin người dùng!");
                req.getRequestDispatcher("dangnhap.jsp").forward(req, resp);
            }
        } else {
            failures++;
            session.setAttribute("loginFailures", failures);

            if (failures >= 5) {
                logLoginAttempt(username, ipAddress, false,
                        "Nhiều lần đăng nhập thất bại (" + failures + " lần) - Có thể là tấn công brute force", LevelLog.DANGER);
            } else if (failures >= 3) {
                logLoginAttempt(username, ipAddress, false,
                        "Nhiều lần đăng nhập thất bại (" + failures + " lần)", LevelLog.DANGER);
            } else {
                logLoginAttempt(username, ipAddress, false,
                        "Một lần đăng nhập thất bại", LevelLog.INFO);
            }

            req.setAttribute("error", "Tên người dùng hoặc mật khẩu không chính xác!");
            req.setAttribute("showCaptcha", (failures >= 3 || isAbnormal(req)));
            req.getRequestDispatcher("dangnhap.jsp").forward(req, resp);
        }
    }
}
