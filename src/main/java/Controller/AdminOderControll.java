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
import java.util.concurrent.atomic.AtomicLong;

@WebServlet(name = "AdminOderControll", value = "/oderadmin")
public class AdminOderControll extends HttpServlet {
    private static final AtomicLong counter = new AtomicLong(System.currentTimeMillis());
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");
        OrderDAO orderDAO = new OrderDAO();

        Order o = new Order();

        String id = String.valueOf(counter.getAndIncrement());
        String userId = request.getParameter("userId");
        String address = request.getParameter("address");
        String oderStatus =  request.getParameter("status");
        String payment = request.getParameter("payment");
        Date oderDate = Date.valueOf(request.getParameter("dateOder"));
        Date deliveryDate = Date.valueOf(request.getParameter("doneDate"));

        o.setId(id);
        o.setUser(new UserDAO().getById(userId));
        o.setAddress(address);
        o.setStatus(oderStatus);
        o.setPayMent(payment);
        o.setOrderDate(oderDate);
        o.setDeliveryDate(deliveryDate);

        orderDAO.insert(o);
        response.sendRedirect("success.jsp");
    }
}

