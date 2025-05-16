package service.impl;

import dao.ICartDAO;
import dao.ICartItemDAO;
import dao.IImageDAO;
import dao.IProductDAO;
import dao.impl.CartDAOImpl;
import dao.impl.CartItemDAOImpl;
import dao.impl.ImageDAOImpl;
import dao.impl.ProductDAOImpl;
import db.JDBIConnector;
import model.CartResponse;
import model.Image;
import model.Product;
import model.cart.Cart;
import model.cart.CartItem;
import service.ICartService;

import java.util.List;
import java.util.stream.Collectors;

public class CartServiceImpl implements ICartService {
    private ICartDAO cartDAO = new CartDAOImpl();
    private ICartItemDAO cartItemDAO = new CartItemDAOImpl();
    private IProductDAO productDAO = new ProductDAOImpl();
    private IImageDAO imageDAO = new ImageDAOImpl();

    @Override
    public CartItem getCartItemByCartId(Integer productId, Integer cartId) {
        return cartItemDAO.findByProductId(productId, cartId);
    }

    @Override
    public boolean addCartItem(CartItem cartItem) {
        CartItem cartItem1 = cartItemDAO.findByProductId(cartItem.getProductId(), cartItem.getCartId());
        if (cartItem1 != null) {
            cartItem1.setQuantity(cartItem1.getQuantity() + cartItem.getQuantity());
            return cartItemDAO.updateCartItem(cartItem1.getId(), cartItem1.getQuantity());
        } else {
            return cartItemDAO.addCartItem(cartItem);
        }
    }

    @Override
    public boolean updateCartItem(CartItem cartItem) {
        CartItem cartItem1 = cartItemDAO.findByProductId(cartItem.getProductId(), cartItem.getCartId());
        if (cartItem1 != null) {
            return cartItemDAO.updateCartItem(cartItem1.getId(), cartItem.getQuantity());
        } else {
            return false;
        }
    }


    @Override
    public boolean createCart(Integer userId) {
        return cartDAO.createCart(userId);
    }

    @Override
    public Cart findByUserId(Integer userId) {
        return cartDAO.findByUserId(userId);
    }

    @Override
    public Integer getTotalCartItem(Integer cartId) {
        return cartDAO.getTotalCartItem(cartId);
    }

    @Override
    public List<CartResponse> getCartItemByCartId(Integer cartId) {
        List<CartItem> cartItems = cartDAO.findAllCartItemByCartId(cartId);
        List<CartResponse> cartResponses = cartItems.stream()
                .map(cartItem -> {
                    CartResponse cartResponse = new CartResponse();
                    Product product = productDAO.findById(cartItem.getProductId());
                    List<Image> images = imageDAO.findByProductId(product.getId());
                    product.setImages(images);
                    cartResponse.setProduct(product);
                    cartResponse.setQuantity(cartItem.getQuantity());
                    return cartResponse;
                })
                .collect(Collectors.toList());
        return cartResponses;
    }

    @Override
    public boolean removeCartItem(Integer productId, Integer cartId) {
        return  cartItemDAO.removeCartItem(productId, cartId);
    }

    @Override
    public int createCartForUser(int userId) {
        // insert vào bảng carts(user_id) và trả về id auto-generated
        return JDBIConnector.getConnect().withHandle(h ->
                h.createUpdate("INSERT INTO carts(user_id) VALUES(:u)")
                        .bind("u", userId)
                        .executeAndReturnGeneratedKeys("id")
                        .mapTo(int.class)
                        .one()
        );
    }
}
