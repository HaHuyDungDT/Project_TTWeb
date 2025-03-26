package dao.impl;

import dao.ICartDAO;
import db.JDBIConnector;
import model.cart.Cart;
import model.cart.CartItem;
import model.Product;

import java.util.List;
import java.util.Map;

public class CartDAOImpl implements ICartDAO {

    @Override
    public Cart findByUserId(Integer userId) {
        Cart cart = JDBIConnector.getConnect().withHandle(handle -> {
            return handle.select("SELECT id, user_id FROM carts WHERE user_id = :user_id")
                    .bind("user_id", userId)
                    .mapToBean(Cart.class)
                    .findFirst()
                    .orElse(null);
        });
        return cart;
    }

    @Override
    public boolean createCart(Integer userId) {
        int rowsrAffected = JDBIConnector.getConnect().withHandle(handle -> {
            return handle.createUpdate("INSERT INTO carts(user_id) VALUES (?)")
                    .bind(0, userId)
                    .execute();
        });
        return rowsrAffected > 0;
    }

    @Override
    public Integer getTotalCartItem(Integer cartId) {
        return JDBIConnector.getConnect().withHandle(handle ->
                handle.select("SELECT COUNT(*) FROM cart_items WHERE cart_id = :cart_id")
                        .bind("cart_id", cartId)
                        .mapTo(Integer.class)
                        .one()
        );
    }

    @Override
    public Map<Integer, List<CartItem>> getProductInCart(Integer userId) {
        return Map.of();
    }

    @Override
    public List<CartItem> findAllCartItemByCartId(Integer cartId) {
        return JDBIConnector.getConnect().withHandle(handle -> {
            return handle.select("SELECT id, cart_id, product_id, quantity FROM cart_items WHERE cart_id = :cart_id")
                    .bind("cart_id", cartId)
                    .mapToBean(CartItem.class)
                    .list();
        });
    }
}
