package Controller;

import service.IUserService;
import service.impl.userServiceImpl;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(value = "/quanlytaikhoan")
public class AccountMgmController extends HttpServlet {
    private IUserService userService = new userServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("users", userService.findAll());
        RequestDispatcher dispatcher = req.getRequestDispatcher("quanlytaikhoan.jsp");
        dispatcher.forward(req, resp);
    }
}
