package service;

import model.CartResponse;
import model.cart.Cart;
import model.cart.CartItem;

import java.util.List;
import java.util.Map;

public interface ICartService {
    CartItem getCartItemByCartId(Integer cartId, Integer productId);
    boolean addCartItem(CartItem cartItem);
    boolean updateCartItem(CartItem cartItem);
    boolean createCart(Integer userId);
    Cart findByUserId(Integer userId);
    Integer getTotalCartItem(Integer cartId);
    List<CartResponse> getCartItemByCartId(Integer cartId);
    boolean removeCartItem(Integer productId, Integer cartId);

    int createCartForUser(int userId);
}
