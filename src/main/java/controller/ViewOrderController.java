package controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import dao.IOrderDAO;
import dao.IOrderDetailDAO;
import dao.impl.OrderDAOImpl;
import dao.impl.OrderDetailDAOImpl;
import model.Order;
import model.OrderDetails;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/order-view")
public class ViewOrderController extends HttpServlet {
    private IOrderDAO orderDAO = new OrderDAOImpl();
    private IOrderDetailDAO orderDetailsDAO = new OrderDetailDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Integer orderId = Integer.parseInt(req.getParameter("id"));
        Order order = orderDAO.findById(orderId);
        List<OrderDetails> details = orderDetailsDAO.findByOrderId(orderId);

        Map<String, Object> responseMap = new HashMap<>();
        responseMap.put("order", order);
        responseMap.put("details", details);

        ObjectMapper objectMapper = new ObjectMapper();
        objectMapper.registerModule(new JavaTimeModule());
        objectMapper.disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS);
        resp.setContentType("application/json");
        objectMapper.writeValue(resp.getOutputStream(), responseMap);
    }
}

