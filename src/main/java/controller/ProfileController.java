package controller;

import dao.IOrderDAO;
import dao.IUserDao;
import dao.impl.OrderDAOImpl;
import dao.impl.UserDaoImpl;
import model.Order;
import model.User;
import utils.SessionUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ProfileController", value = "/profile")
public class ProfileController extends HttpServlet {
    private IUserDao userDAO = new UserDaoImpl();
    private IOrderDAO orderDAO = new OrderDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            request.setCharacterEncoding("utf-8");
            response.setCharacterEncoding("utf-8");
            response.setContentType("text/html;charset=UTF-8");

            // Lấy thông tin user từ session
            User user = (User) SessionUtil.getInstance().getKey(request, "user");
            
            if (user != null) {
                // Lấy danh sách đơn hàng của user
                List<Order> orders = orderDAO.getOrdersByUserId(user.getId());
                
                // Set các attribute cho JSP
                request.setAttribute("user", user);
                request.setAttribute("orders", orders);
                
                // Forward đến trang profile.jsp
                request.getRequestDispatcher("profile.jsp").forward(request, response);
            } else {
                // Nếu chưa đăng nhập thì chuyển về trang login
                response.sendRedirect("login");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Có lỗi xảy ra: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}