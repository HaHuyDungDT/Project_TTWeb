package controller;

import dao.IOrderDAO;
import dao.impl.OrderDAOImpl;
import model.Order;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/quanlydonhang")
public class OrderMgmController extends HttpServlet {
    private IOrderDAO orderDAO = new OrderDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Order> orders = orderDAO.findAll();
        req.setAttribute("orders", orders);
        HttpSession session = req.getSession();
        String successMessage = (String) session.getAttribute("successMessage");
        if(successMessage!= null) {
            req.setAttribute("successMessage", successMessage);
            session.removeAttribute("successMessage");

        }
        String errorMessage = (String) session.getAttribute("errorMessage");
        if(errorMessage!= null) {
            req.setAttribute("errorMessage", errorMessage);
            session.removeAttribute("errorMessage");

        }
        req.getRequestDispatcher("quanlydonhang.jsp").forward(req, resp);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
