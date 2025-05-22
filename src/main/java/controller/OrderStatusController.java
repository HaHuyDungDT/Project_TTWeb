package controller;
import dao.IOrderDAO;
import dao.impl.OrderDAOImpl;
import model.Order;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/order-set-status")
public class OrderStatusController extends HttpServlet {
    private IOrderDAO orderDAO = new OrderDAOImpl();

@Override
protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
    resp.setContentType("application/json");
    resp.setCharacterEncoding("UTF-8");

    try {
        int id = Integer.parseInt(req.getParameter("id"));
        String status = req.getParameter("status");

        Order order = orderDAO.findById(id);
        if (order != null) {
            order.setStatus(status);
            boolean updated = orderDAO.updateOrder(order);

            resp.getWriter().write("{\"success\":" + updated + "}");
        } else {
            resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
            resp.getWriter().write("{\"success\":false, \"error\":\"Order not found\"}");
        }
    } catch (Exception e) {
        e.printStackTrace();
        resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        resp.getWriter().write("{\"success\":false, \"error\":\"Internal server error\"}");
    }
}
}
