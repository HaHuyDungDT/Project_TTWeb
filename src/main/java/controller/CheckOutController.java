package controller;

import dao.ICouponDAO;
import dao.impl.CouponImpl;
import model.CartResponse;
import model.Coupon;
import model.Product;
import model.User;
import model.cart.Cart;
import model.cart.CartItem;
import service.ICartService;
import service.IProductService;
import service.impl.CartServiceImpl;
import service.impl.ProductServiceImpl;
import utils.SessionUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet(urlPatterns = "/check-out")
public class CheckOutController extends HttpServlet {
    private ICartService cartService = new CartServiceImpl();
    private IProductService productService = new ProductServiceImpl();
    private ICouponDAO couponImpl = new CouponImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        User user = (User) SessionUtil.getInstance().getKey(req, "user");
        Integer userId = user.getId();
        Cart cart = cartService.findByUserId(userId);
        String[] selectedProductIds = req.getParameterValues("selectedProductIds");
        List<CartResponse> selectedProductsList = new ArrayList<>();
        for (CartResponse cartResponse : selectedProductsList){
            System.out.println(cartResponse);
        }
        if (selectedProductIds != null && selectedProductIds.length > 0) {
            List<Integer> couponIds = new ArrayList<>();
            for (String productId : selectedProductIds) {
                Integer id = Integer.parseInt(productId);
                CartItem item = cartService.getCartItemByCartId(id, cart.getId());
                String quantity = req.getParameter("quantity" + id);
                Integer quantityProduct = quantity == null ? 1 : Integer.parseInt(quantity);
                Product product = productService.findProductById(item.getProductId());
                if ("selling".equals(product.getStatus())) {
                    Integer couponId = product.getCouponId();
                    if (couponId != null) {
                        couponIds.add(couponId);
                    }
                }
                CartResponse cartResponse = new CartResponse();
                cartResponse.setQuantity(quantityProduct);
                cartResponse.setProduct(product);
                selectedProductsList.add(cartResponse);
            }
            couponIds = couponIds.stream().distinct().collect(Collectors.toList());
            List<Coupon> coupons = couponIds.stream()
                    .map(couponId -> couponImpl.getCouponById(couponId))
                    .collect(Collectors.toList());
            for (Coupon coupon : coupons) {
                int discount = coupon.getPercent_discount();
                req.getSession().setAttribute("discount", discount);
            }
            req.getSession().setAttribute("coupons", coupons);
        }
        req.getSession().setAttribute("selectedProductsList", selectedProductsList);
        req.getRequestDispatcher("thanhtoan.jsp").forward(req, resp);
    }
}