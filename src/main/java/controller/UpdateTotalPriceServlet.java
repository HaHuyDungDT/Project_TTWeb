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

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/update-total-price")
public class UpdateTotalPriceServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String couponId = request.getParameter("couponId");
        String shippingFeeStr = request.getParameter("shippingFee");
        int shippingFee = Integer.parseInt(shippingFeeStr != null ? shippingFeeStr : "0");

        // Lấy danh sách sản phẩm từ session
        List<Product> products = (List<Product>) request.getSession().getAttribute("selectedProductsList");
        double totalPrice = 0;

        // Tính tổng giá sản phẩm
        for (Product item : products) {
            totalPrice += item.getPrice() * item.getQuantity();
        }

        // Cộng phí vận chuyển
        totalPrice += shippingFee;

        // Trả về JSON
        response.setContentType("application/json");
        response.getWriter().write("{\"totalPrice\": " + totalPrice + "}");
    }
}