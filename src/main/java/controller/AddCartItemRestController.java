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
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.UUID;

@WebServlet(name = "AddCartController", value = "/add-cart")
public class AddCartItemRestController extends HttpServlet {
    private ICartService cartService = new CartServiceImpl();


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        String id = request.getParameter("productId");
        Integer productId = Integer.parseInt(request.getParameter("productId"));
        User user = (User) SessionUtil.getInstance().getKey(request, "user");


        if(user == null) {
            response.setStatus(400);
            response.getWriter().print("Vui lòng đăng nhập trước khi thêm sản phẩm vào giỏ hàng!");
            return;
        }

        Integer userId = user.getId();
        Cart cartId = cartService.findByUserId(userId);

        if (userId != null && cartId != null) {
            CartItem cartItem = new CartItem();
            cartItem.setId(UUID.randomUUID().toString());
            cartItem.setCartId(cartId.getId());
            cartItem.setProductId(productId);
            cartItem.setQuantity(1);
            cartService.addCartItem(cartItem);
        }

        assert cartId != null;
        Integer totalItem = cartService.getTotalCartItem(cartId.getId());
        JsonObject jsonObject = new JsonObject();
        jsonObject.addProperty("status", "Thêm vào giỏ hàng thành công");
        jsonObject.addProperty("code", 202);
        jsonObject.addProperty("message", totalItem);
        response.setStatus(202);
        response.getWriter().print(jsonObject);
    }
}

