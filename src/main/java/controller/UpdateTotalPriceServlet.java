package controller;

import dao.impl.CouponImpl;
import dao.impl.ProductDAOImpl;
import model.Coupon;
import model.Product;
import model.User;
import model.cart.Cart;
import model.cart.CartItem;
import service.ICartService;
import service.impl.CartServiceImpl;
import utils.SessionUtil;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/update-total-price")
public class UpdateTotalPriceServlet extends HttpServlet {
    ICartService cartService = new CartServiceImpl();
    ProductDAOImpl productDao = new ProductDAOImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String couponIdStr = request.getParameter("couponId");
        String shippingFeeStr = request.getParameter("shippingFee");

        User user = (User) SessionUtil.getInstance().getKey(request, "user");

        int shippingFee = 0;
        try {
            shippingFee = Integer.parseInt(shippingFeeStr);
        } catch (NumberFormatException e) {
            shippingFee = 0;
        }

        Cart cart = cartService.findByUserId(user.getId());
        double total = 0;

        Coupon coupon = null;
        if (couponIdStr != null && !couponIdStr.isEmpty()) {
            try {
                int couponId = Integer.parseInt(couponIdStr);
                coupon = new CouponImpl().getCouponById(couponId);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        if (cart != null && cart.getCartItems() != null) {
            for (CartItem item : cart.getCartItems()) {
                int productId = item.getProductId();
                Product product = productDao.findById(productId);
                double price = product.getPrice();
                int quantity = item.getQuantity();

                if (coupon != null && product.getCouponId() == coupon.getId()) {
                    price = price * (1 - coupon.getPercent_discount() / 100.0);
                }

                total += price * quantity;
            }
        }

        total += shippingFee;

        response.getWriter().write("{\"totalPrice\":" + (int) total + "}");
    }
}