package controller;

import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import dao.IOrderDAO;
import dao.IUserDao;
import dao.impl.OrderDAOImpl;
import dao.impl.UserDaoImpl;
import model.Order;
import com.fasterxml.jackson.databind.ObjectMapper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import com.fasterxml.jackson.databind.SerializationFeature;
import model.User;

@WebServlet("/order-edit")
public class EditOrderController extends HttpServlet {
    private IOrderDAO orderDAO = new OrderDAOImpl();
    private IUserDao userDao = new UserDaoImpl();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");

        String orderId = request.getParameter("orderId");
        if(orderId == null || orderId.isEmpty()){
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "order id is missing");
        return;
        }
        Integer orderInteger  = Integer.parseInt(orderId);
        Order order = orderDAO.findById(orderInteger);
        System.out.println(order);


        if(order == null){
            System.out.println("order not found with id: " + orderInteger);
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;

        }
        ObjectMapper objectMapper = new ObjectMapper();
        objectMapper.registerModule(new JavaTimeModule());
        objectMapper.disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS);
        objectMapper.writeValue(response.getOutputStream(), order);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");
        try {
            Integer id = Integer.parseInt(request.getParameter("id"));
            Integer userId  = Integer.parseInt(request.getParameter("userid"));
           Order orderEdit = orderDAO.findById(id);

            orderEdit.setUser(userDao.getUserByUserId(userId));
            orderEdit.setAddress(request.getParameter("address"));
            orderEdit.setPhone_number(request.getParameter("phone_number"));
            orderEdit.setStatus(request.getParameter("status"));
            orderEdit.setNote(request.getParameter("note"));
            orderEdit.setPayment_method(request.getParameter("payment"));
            String dateOrder = request.getParameter("dateOrder");
            if(dateOrder != null && !dateOrder.isEmpty()){
                System.out.println("dateOrder: " + dateOrder);
                orderEdit.setOrderDate(LocalDate.parse(dateOrder).atStartOfDay());
            }
            String doneDate = request.getParameter("doneDate");
            if(doneDate != null && !doneDate.isEmpty()) {
                System.out.println("doneDate: " + doneDate);
                orderEdit.setDeliveryDate(LocalDate.parse(doneDate).atStartOfDay());
            }
            orderEdit.setTotalPrice(Double.parseDouble(request.getParameter("totalPrice")));
            if(orderDAO.updateOrder(orderEdit)) {
                request.getSession().setAttribute("editOrderSuccess", true);
                System.out.println("update order success");

            } else {
                request.getSession().setAttribute("editOrderSuccess", false);
                System.out.println("update order failed");
            }

        } catch (Exception e) {
            System.out.println("error: " + e.getMessage());
            e.printStackTrace();
            request.getSession().setAttribute("editOrderSuccess", false);
        }
        response.sendRedirect("/quanlydonhang?success=editOrderSuccess");
    }
}