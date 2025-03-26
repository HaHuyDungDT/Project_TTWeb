package dao;

import model.cart.CartItem;

import java.util.List;

public interface ICartItemDAO {

    List<CartItem> findAll();
    boolean addCartItem(CartItem cartItem);
    CartItem findByProductId(Integer productId, Integer cartId);
    boolean updateCartItem(String cartItemId, Integer newQuantity);
    boolean removeCartItem(Integer productid, Integer cartId);
}
