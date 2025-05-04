package controller;

import dao.IOrderDAO;
import dao.IOrderDetailDAO;
import dao.IUserDao;
import dao.impl.OrderDAOImpl;
import dao.impl.OrderDetailDAOImpl;
import dao.impl.UserDaoImpl;
import model.*;
import service.ICartService;
import service.ILogService;
import service.impl.CartServiceImpl;
import service.impl.LogServiceImpl;
import utils.LevelLog;
import utils.MailUtil;
import utils.SessionUtil;


import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;


@WebServlet(name = "OrderController", value = "/order")
public class OrderController extends HttpServlet {
    private ILogService logService = new LogServiceImpl();
    private IOrderDAO orderDAO = new OrderDAOImpl();
    private IOrderDetailDAO orderDetailsDAO = new OrderDetailDAOImpl();

    private IUserDao userDAO = new UserDaoImpl();
    private ICartService cartService = new CartServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");

        HttpSession session = request.getSession();

        List<CartResponse> selectedProductsList = (List<CartResponse>) session.getAttribute("selectedProductsList");

        if (!selectedProductsList.isEmpty()) {

            LocalDateTime orderDate = LocalDateTime.now();
            LocalDateTime deliverDate = orderDate.plusDays(3);

            String province = request.getParameter("selectedProvince");
            String district = request.getParameter("selectedDistrict");
            String ward = request.getParameter("selectedWard");

            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String address = province + "_" + district + "_" + ward;
            String phone = request.getParameter("phone_number");
            String paymentMethod = request.getParameter("payment");
            String note = request.getParameter("note");
            double totalPrice = Double.parseDouble(request.getParameter("totalPrice"));

            if (email != null && !email.isEmpty()) {
                User user = (User) SessionUtil.getInstance().getKey(request, "user");
                Integer userId = user.getId();
                user.setId(userId);
                user.setName(name);
                user.setEmail(email);

                String status = "Chờ xác nhận đơn hàng";
                Order order = new Order();
                order.setUser(user);
                order.setAddress(address);
                order.setPhone_number(phone);
                order.setStatus(status);
                order.setNote(note);
                order.setPayment_method(paymentMethod);
                order.setOrderDate(orderDate);
                order.setDeliveryDate(deliverDate);
                order.setTotalPrice(totalPrice);

                Integer orderId = orderDAO.addOrder(order);
                order.setId(orderId);

                for (CartResponse cartItem : selectedProductsList) {
                    OrderDetails orderDetails = new OrderDetails();
                    double amount = cartItem.getProduct().getPrice();
                    orderDetails.setOrder(order);
                    orderDetails.setProduct(cartItem.getProduct());
                    orderDetails.setQuantity(cartItem.getQuantity());
                    orderDetails.setAmount(amount);

                    orderDetailsDAO.addOrderDetails(orderDetails);

                    Integer cartId = cartService.findByUserId(userId).getId();
                    Integer productId = cartItem.getProduct().getId();
                    boolean isRemoved = false;
                    if (productId != null && userId != null && cartId != null) {
                        isRemoved = cartService.removeCartItem(productId, cartId);
                    }
                }
                String emailContent = "Chào bạn,\n" +
                        "Đơn hàng của bạn đã được đặt thành công. Chúng tôi sẽ xác nhận đơn hàng và liên hệ với bạn sớm nhất có thể\n" +
                        "Cảm ơn bạn đã mua sắm tại cửa hàng của chúng tôi!\n" +
                        "Địa chỉ: Phone Accessories - Linh Trung - Thủ Đức - Hồ Chí Minh\n" +
                        "Email: support@phoneaccessories.com | Điện thoại: (0973) 206 403";

                // Gửi email thông báo cho người dùng
                MailUtil.getInstance().sendMail(emailContent,
                        "Thông báo thanh toán thành công",
                        user.getEmail());
            } else {
                request.setAttribute("error", "Tên người dùng hoặc email hoặc số điện thoại không chính xác!");
                RequestDispatcher dispatcher = request.getRequestDispatcher("check-out.jsp");
                dispatcher.forward(request, response);
            }
            session.setAttribute("OrderSuccess", true);
            response.sendRedirect("index.jsp");
        } else {
            request.setAttribute("error", "Không có sản phẩm nào cả!");
            RequestDispatcher dispatcher = request.getRequestDispatcher("check-out.jsp");
            dispatcher.forward(request, response);
        }
    }
}