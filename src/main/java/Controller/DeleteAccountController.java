package Controller;

import service.IUserService;
import service.impl.userServiceImpl;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletException;
import java.io.IOException;
import service.IUserService;
import service.impl.userServiceImpl;
import java.io.IOException;

@WebServlet(value = "/account/delete")
public class DeleteAccountController extends HttpServlet {
    private IUserService userService = new userServiceImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idParam = req.getParameter("id");

        try {
            Integer id = Integer.parseInt(idParam);
            userService.deleteById(id);
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        resp.sendRedirect("/quanlytaikhoan");
    }
}
