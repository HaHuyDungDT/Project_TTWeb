package controller;

import dao.IOrderDAO;
import dao.IUserDao;
import dao.impl.OrderDAOImpl;
import dao.impl.UserDaoImpl;
import model.Order;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;

@WebServlet("/order-add")
public class AddOrderController extends HttpServlet {
    IOrderDAO orderDao = new OrderDAOImpl();
    IUserDao userDao = new UserDaoImpl();



    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try{
            req.getRequestDispatcher("quanlydonhang.jsp").forward(req, resp);

        }catch(Exception e){
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error fetching order");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        try {
            Integer id = Integer.parseInt(req.getParameter("userid"));
            System.out.println(id);
            String address = req.getParameter("address");System.out.println(address);
            String phone = req.getParameter("phone_number");System.out.println(phone);
            String status = req.getParameter("status");System.out.println(status);
            String note = req.getParameter("note");System.out.println(note);
            String payment = req.getParameter("payment");System.out.println(payment);
            Double total = Double.parseDouble(req.getParameter("totalPrice"));System.out.println(total);
            Order order = new Order();
            order.setUser(userDao.getUserByUserId(id));
            order.setAddress(address);
            order.setPhone_number(phone);
            order.setStatus(status);
            order.setNote(note);
            order.setPayment_method(payment);
            order.setOrderDate(LocalDate.parse(req.getParameter("dateOrder")).atStartOfDay());
            order.setDeliveryDate(LocalDate.parse(req.getParameter("doneDate")).atStartOfDay());
            order.setTotalPrice(total);
            System.out.println(order);
           if (orderDao.addOrder(order) > 0 ) {
               resp.sendRedirect("/quanlydonhang?success=addOrderSuccess");
               req.getSession().setAttribute("addOrderSuccess", true);
               System.out.println("Add order successfully");

           } else {
               resp.sendRedirect("/quanlydonhang?error=addOrderFailed");
               req.getSession().setAttribute("addOrderSuccess", false);
               System.out.println("Add order failed");
           }

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error adding order");
        }
    }
}
