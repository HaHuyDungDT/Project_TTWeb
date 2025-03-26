package Controller;

import Cart.Cart;
import Cart.CartProduct;
import dao.IUserDao;
import dao.OrderDAO;
import dao.OrderDetailsDAO;
import dao.UserDAO;
import dao.impl.userDaoImpl;
import model.OrderDetails;
import model.User;
import service.IUserService;
import service.UserService;
import service.impl.userServiceImpl;
import utils.MailUtil;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.List;

@WebServlet(name = "OrderController", value = "/order")
public class OrderController extends HttpServlet {
    private OrderDAO orderDAO = new OrderDAO();
    private OrderDetailsDAO orderDetailsDAO = new OrderDetailsDAO();

    private UserDAO userDAO = new UserDAO();

    private IUserService userService = new userServiceImpl();
    private static int countIdOrder = 0;
    private static int countIdOrderDetail = 0;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");

        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");

        if (cart != null) {

            Date order_date = new Date(System.currentTimeMillis() + 3600000);
            long sevenDaysInMillis = 3 * 24 * 60 * 60 * 1000;
            Date delivery_date = new Date(order_date.getTime() + sevenDaysInMillis);

            String id_order = "or_" + generateUniqueOrderId();

            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String address = request.getParameter("delivery_address");
            String phone = request.getParameter("phone_number");
            String payment_method = request.getParameter("payment");
            double total_price = 0;
            if (request.getParameter("total_price") != null) {
                total_price = Double.parseDouble(request.getParameter("total_price"));
            }
            System.out.println("Total Price: " + total_price);


            if (email != null && !email.isEmpty()) {
                User user = userDAO.getUserByEmail(email);
                user.setId(userDAO.getUserByEmail(email).getId());

                Order order = new Order(id_order, user, address, "Chưa xác thực", payment_method, order_date, delivery_date, total_price);
                orderDAO.insert(order);

                List<CartProduct> cartProducts = cart.getCartProducts();

                for (CartProduct cartProduct : cartProducts) {

                    String id_orderDetail = "od_" + generateUniqueOrderDetailId();

                    OrderDetails orderDetails = new OrderDetails();

                    double amount = cartProduct.getProduct().getPrice() * cartProduct.getQuantity();

                    orderDetails.setId(id_orderDetail);
                    orderDetails.setOrder(order);
                    orderDetails.setProduct(cartProduct.getProduct());
                    orderDetails.setQuantity(cartProduct.getQuantity());
                    orderDetails.setPrice(cartProduct.getProduct().getPrice());
                    orderDetails.setDiscount(0);
                    orderDetails.setAmount(amount);

                    orderDetailsDAO.insert(orderDetails);
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

                session.removeAttribute("cart");
                response.sendRedirect("thongtinchitiet.jsp?id=" + userService.getIdByUsername(user.getUser_name()));
            }else {
                request.setAttribute("error", "Tên người dùng hoặc email hoặc số điện thoại không chính xác!");
                RequestDispatcher dispatcher = request.getRequestDispatcher("thanhtoan.jsp");
                dispatcher.forward(request, response);
            }
        }
        session.setAttribute("OrderSuccess", true);



    }

    private synchronized String generateUniqueOrderId() {
        countIdOrder++;
        return String.valueOf(countIdOrder);
    }

    private synchronized String generateUniqueOrderDetailId() {
        countIdOrderDetail++;
        return String.valueOf(countIdOrderDetail);
    }
}