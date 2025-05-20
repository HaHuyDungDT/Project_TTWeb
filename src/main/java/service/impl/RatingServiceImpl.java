package service.impl;

import dao.IRatingDAO;
import dao.impl.OrderDAOImpl;
import dao.impl.OrderDetailDAOImpl;
import dao.impl.RatingDAOImpl;
import model.Order;
import model.OrderDetails;
import model.Rate;
import service.IRatingService;

import java.util.List;

public class RatingServiceImpl implements IRatingService {
    private IRatingDAO ratingDAO = new RatingDAOImpl();
    private OrderDAOImpl orderDAO = new OrderDAOImpl();
    private OrderDetailDAOImpl orderDetailDAO = new OrderDetailDAOImpl();

    @Override
    public List<Rate> findByProductId(int productId) {
        return ratingDAO.findByProductId(productId);
    }

    @Override
    public double getAverageRating(int productId) {
        return ratingDAO.getAverageRating(productId);
    }

    @Override
    public int getRatingCount(int productId) {
        return ratingDAO.getRatingCount(productId);
    }

    @Override
    public int getRatingCountByStar(int productId, int star) {
        return ratingDAO.getRatingCountByStar(productId, star);
    }

    @Override
    public void save(Rate rate) {
        ratingDAO.save(rate);
    }

    @Override
    public boolean hasUserPurchasedProduct(int userId, int productId) {
        List<Order> userOrders = orderDAO.findByIdUser(userId);

        for (Order order : userOrders) {
            List<OrderDetails> orderDetails = orderDetailDAO.findByIdOrder(order.getId());
            for (OrderDetails detail : orderDetails) {
                if (detail.getProduct().getId() == productId) {
                    if ("Đã giao hàng".equals(order.getStatus())) {
                        return true;
                    }
                }
            }
        }
        return false;
    }

    @Override
    public boolean hasUserRated(int userId, int productId) {
        return ratingDAO.hasUserRated(userId, productId);
    }
} 