package dao.impl;

import dao.ICartItemDAO;
import db.JDBIConnector;
import model.cart.CartItem;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

public class CartItemDAOImpl implements ICartItemDAO {
    private static final String SELECT_CARTITEM = "SELECT id, cart_id, product_id, quantity FROM cart_items";
    @Override
    public List<CartItem> findAll() {
        List<CartItem> cartItems = JDBIConnector.getConnect().withHandle(handle -> {
            return handle.createQuery(SELECT_CARTITEM)
                    .mapToBean(CartItem.class)
                    .list();
        });
        return cartItems;
    }

    @Override
    public boolean addCartItem(CartItem cartItem) {
        int rowsAffected = JDBIConnector.getConnect().withHandle(handle -> {
            return handle.createUpdate("INSERT INTO cart_items (id, cart_id, product_id, quantity) VALUES (?, ?, ?, ?)")
                    .bind(0, UUID.randomUUID().toString())
                    .bind(1, cartItem.getCartId())
                    .bind(2, cartItem.getProductId())
                    .bind(3, cartItem.getQuantity())
                    .execute();
        });
        return rowsAffected > 0;
    }

    @Override
    public CartItem findByProductId(Integer productId, Integer cartId) {
        CartItem cartItem = JDBIConnector.getConnect().withHandle(handle -> {
            return handle.createQuery(SELECT_CARTITEM + " WHERE product_id = :productId AND cart_id = :cartId")
                    .bind("productId", productId)
                    .bind("cartId", cartId)
                    .mapToBean(CartItem.class)
                    .findFirst()
                    .orElse(null);
        });
        return cartItem;
    }

    public static void main(String[] args) {
        ICartItemDAO cartItemDAO = new CartItemDAOImpl();
        boolean isAdd = cartItemDAO.addCartItem(new CartItem(UUID.randomUUID().toString(), 1, 1, 1));
        System.out.println(isAdd);
    }

    @Override
    public boolean updateCartItem(String cartItemId, Integer newQuantity) {
        int rowsAffected = JDBIConnector.getConnect().withHandle(handle -> {
            return handle.createUpdate("UPDATE cart_items SET quantity = ? WHERE id = ?")
                    .bind(0, newQuantity)
                    .bind(1, cartItemId)
                    .execute();
        });
        return rowsAffected > 0;
    }

    @Override
    public boolean removeCartItem(Integer productId, Integer cartId) {
        int rowsAffected = JDBIConnector.getConnect().withHandle(handle -> {
            return handle.createUpdate("DELETE FROM cart_items WHERE product_id = :productId AND cart_id = :cartId")
                    .bind("productId", productId)
                    .bind("cartId", cartId)
                    .execute();
        });
        return rowsAffected > 0;
    }
}
