package dao;

import Model.cart.Cart;
import Model.cart.CartItem;
import model.cart.Cart;
import model.cart.CartItem;

import java.util.List;
import java.util.Map;

public interface ICartDAO {
    Cart findByUserId(Integer userId);
    boolean createCart(Integer userId);
    Integer getTotalCartItem(Integer cartId);
    Map<Integer, List<CartItem>> getProductInCart(Integer idUser);
    List<CartItem> findAllCartItemByCartId(Integer cartId);
}
