package controller;

import service.IUserService;
import service.impl.UserServiceImpl;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/quanlytaikhoan")
public class AccountMgmController extends HttpServlet {
    private IUserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("users", userService.findAll());
        HttpSession session = req.getSession();
        String successMessage = (String) session.getAttribute("successMessage");
        if (successMessage != null) {
            req.setAttribute("successMessage", successMessage);
            session.removeAttribute("successMessage");
        }

        req.getRequestDispatcher("quanlytaikhoan.jsp").forward(req, resp);
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp); // Chuyển hướng POST thành GET logic
    }
}
