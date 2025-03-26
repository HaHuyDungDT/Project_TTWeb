package Controller;

import dao.OrderDAO;
import dao.UserDAO;
import model.Order;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.util.List;
import java.util.Objects;

@WebServlet(name = "EditOrderControll", value = "/oderedit")
public class EditOrderControll extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");
        OrderDAO orderDAO = new OrderDAO();

        String id = request.getParameter("id");
        String userId = request.getParameter("userId");
        String address = request.getParameter("address");
        String orderStatus = request.getParameter("status");
        String payment = request.getParameter("payment");
        Date orderDate = Date.valueOf(request.getParameter("dateOder"));
        Date deliveryDate = Date.valueOf(request.getParameter("doneDate"));

        List<Order> list = orderDAO.selectAll();
        boolean idExists = false;

        for (Order od : list) {
            if (Objects.equals(id, od.getId())) {
                idExists = true;
                break;
            }
        }

        if (idExists) {
            response.sendRedirect("error.jsp");
        } else {
            Order o = new Order();
            o.setId(id);
            o.setUser(new UserDAO().getById(Integer.valueOf(userId)));
            o.setAddress(address);
            o.setStatus(orderStatus);
            o.setPayment_method(payment);
            o.setOrderDate(orderDate);
            o.setDeliveryDate(deliveryDate);

            orderDAO.insert(o);
            response.sendRedirect("success.jsp");
        }
    }
}