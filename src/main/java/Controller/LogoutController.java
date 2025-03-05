package Controller;

import utils.SessionUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "LogoutController", value = "/logout")
public class LogoutController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        SessionUtil.getInstance().delKey(req, "user");
        SessionUtil.getInstance().delKey(req, "userEmail");
        SessionUtil.getInstance().delKey(req, "userName");
        SessionUtil.getInstance().delKey(req, "userPicture");
        resp.sendRedirect("index.jsp");
    }
}

