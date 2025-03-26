package Controller;

import model.User;
import model.User;
import service.IUserService;
import service.impl.userServiceImpl;
import utils.SessionUtil;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(value = "/entercode")
public class EnterCodeController extends HttpServlet {
    private IUserService userService = new userServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        RequestDispatcher dispatcher = req.getRequestDispatcher("enterCode.jsp");
        dispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if(SessionUtil.getInstance().getKey(req, "email") != null){
            String code = SessionUtil.getInstance().getKey(req, "codes").toString();
            if(code.equals(req.getParameter("code"))){
                SessionUtil.getInstance().delKey(req, "code");
                resp.sendRedirect("resetpassword");
                return;
            }
            req.setAttribute("error", "Mã code không chính xác");
            RequestDispatcher dispatcher = req.getRequestDispatcher("enterCode.jsp");
            dispatcher.forward(req, resp);
            return;
        }else{
            if(SessionUtil.getInstance().getKey(req, "codes") != null){
                String code = SessionUtil.getInstance().getKey(req, "codes").toString();
                if(code.equals(req.getParameter("code"))){
                    if(SessionUtil.getInstance().getKey(req, "userObj") != null){
                        User user = (User) SessionUtil.getInstance().getKey(req, "userObj");
                        String rsRegister = userService.register(user);
                        if(rsRegister == null){
                            req.setAttribute("error", "Đăng ký thất bại!");
                            RequestDispatcher dispatcher = req.getRequestDispatcher("enterCode.jsp");
                            dispatcher.forward(req, resp);
                        }else{
                            req.setAttribute("success", "Đăng ký thành công!");
                            SessionUtil.getInstance().delKey(req, "code");
                            SessionUtil.getInstance().delKey(req, "userObj");
                            SessionUtil.getInstance().putKey(req, "user", rsRegister);
                            RequestDispatcher dispatcher = req.getRequestDispatcher("enterCode.jsp");
                            dispatcher.forward(req, resp);
                        }
                    }else{
                        resp.sendRedirect("dangnhap.jsp");
                    }
                }else{
                    req.setAttribute("error", "Mã code không chính xác");
                }
                RequestDispatcher dispatcher = req.getRequestDispatcher("enterCode.jsp");
                dispatcher.forward(req, resp);
            }else{
                resp.sendRedirect("dangnhap.jsp");
            }
        }
    }
}
