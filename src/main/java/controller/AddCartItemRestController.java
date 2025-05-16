package controller;

import com.google.gson.JsonObject;
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
import java.util.UUID;

@WebServlet(name = "AddCartController", value = "/add-cart")
public class AddCartItemRestController extends HttpServlet {
    private ICartService cartService = new CartServiceImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");

        // 1) Kiểm tra login
        User user = (User) SessionUtil.getInstance().getKey(request, "user");
        if (user == null) {
            response.setStatus(401);
            JsonObject err = new JsonObject();
            err.addProperty("error", "Vui lòng đăng nhập trước khi thêm sản phẩm vào giỏ hàng!");
            response.getWriter().print(err.toString());
            return;
        }

        int userId = user.getId();
        int productId = Integer.parseInt(request.getParameter("productId"));

        // 2) Lấy hoặc tạo Cart cho user
        Cart cart = cartService.findByUserId(userId);
        if (cart == null) {
            // tạo mới và lấy id
            int newCartId = cartService.createCartForUser(userId);
            cart = new Cart();
            cart.setId(newCartId);
            cart.setUserId(userId);
            // lưu vào session để tái sử dụng
            HttpSession session = request.getSession();
            session.setAttribute("cart", cart);
        }

        // 3) Thêm CartItem
        CartItem item = new CartItem();
        item.setId(UUID.randomUUID().toString());
        item.setCartId(cart.getId());
        item.setProductId(productId);
        item.setQuantity(1);
        cartService.addCartItem(item);

        // 4) Trả về tổng số items trong giỏ
        int totalItem = cartService.getTotalCartItem(cart.getId());
        JsonObject resp = new JsonObject();
        resp.addProperty("status", "Thêm vào giỏ hàng thành công");
        resp.addProperty("totalItems", totalItem);

        response.setStatus(200);
        response.getWriter().print(resp.toString());
    }
}