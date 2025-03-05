package Controller;

import Model.User;
import com.fasterxml.jackson.databind.ObjectMapper;
import service.IUserService;
import service.impl.userServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;

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
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        try {
            User user = new User(
                    req.getParameter("name"),
                    req.getParameter("gender"),
                    req.getParameter("address"),
                    new java.sql.Date(dateFormat.parse(req.getParameter("date")).getTime()),
                    req.getParameter("phone"),
                    req.getParameter("email"),
                    req.getParameter("user"),
                    req.getParameter("password")
            );
            userService.add(user, req.getParameter("role"));
            resp.sendRedirect("/quanlytaikhoan");
        }catch (Exception e){
            e.printStackTrace();
        }

    }
}

