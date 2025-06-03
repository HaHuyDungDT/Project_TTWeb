package controller;

import service.IUserService;
import service.impl.UserServiceImpl;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletException;
import java.io.IOException;

@WebServlet(value = "/quanlytaikhoan/account-delete")
public class DeleteAccountController extends HttpServlet {
    private IUserService userService = new UserServiceImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Integer id = Integer.parseInt(req.getParameter("id"));
            userService.deleteById(id);  // Service → DAO
            req.getSession().setAttribute("deleteAccountSuccess", true);
            resp.sendRedirect("/quanlytaikhoan?success=delete");
        } catch (Exception e) {
            e.printStackTrace();
            req.getSession().setAttribute("deleteAccountSuccess", false); // có thể dùng để thông báo lỗi nếu muốn
            resp.sendRedirect("/quanlytaikhoan?error=deleteFailed");
        }
    }
}