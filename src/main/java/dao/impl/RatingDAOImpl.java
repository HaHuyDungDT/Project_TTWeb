package dao.impl;

import dao.IRatingDAO;
import db.JDBIConnector;
import model.Rate;

import java.util.List;

public class RatingDAOImpl implements IRatingDAO {
    private static final String SELECT_RATE = "SELECT id, star, comment, product_id, user_id FROM rates";
    
    @Override
    public List<Rate> findAll() {
        List<Rate> rates = JDBIConnector.getConnect().withHandle(handle -> {
            return handle.createQuery(SELECT_RATE)
                    .mapToBean(Rate.class)
                    .list();
        });
        return rates;
    }

    @Override
    public Rate findById(int id) {
        Rate rate = JDBIConnector.getConnect().withHandle(handle -> {
            return handle.createQuery(SELECT_RATE + " WHERE id = :id")
                    .bind("id", id)
                    .mapToBean(Rate.class)
                    .findFirst()
                    .orElse(null);
        });
        return rate;
    }

    @Override
    public List<Rate> findByProductId(int productId) {
        List<Rate> rates = JDBIConnector.getConnect().withHandle(handle -> {
            return handle.createQuery(SELECT_RATE + " WHERE product_id = :productId ORDER BY id DESC")
                    .bind("productId", productId)
                    .mapToBean(Rate.class)
                    .list();
        });
        return rates;
    }

    @Override
    public double getAverageRating(int productId) {
        Double avgRating = JDBIConnector.getConnect().withHandle(handle -> {
            return handle.createQuery("SELECT AVG(star) FROM rates WHERE product_id = :productId")
                    .bind("productId", productId)
                    .mapTo(Double.class)
                    .findFirst()
                    .orElse(0.0);
        });
        return avgRating;
    }

    @Override
    public int getRatingCount(int productId) {
        Integer count = JDBIConnector.getConnect().withHandle(handle -> {
            return handle.createQuery("SELECT COUNT(*) FROM rates WHERE product_id = :productId")
                    .bind("productId", productId)
                    .mapTo(Integer.class)
                    .findFirst()
                    .orElse(0);
        });
        return count;
    }

    @Override
    public int getRatingCountByStar(int productId, int star) {
        Integer count = JDBIConnector.getConnect().withHandle(handle -> {
            return handle.createQuery("SELECT COUNT(*) FROM rates WHERE product_id = :productId AND star = :star")
                    .bind("productId", productId)
                    .bind("star", star)
                    .mapTo(Integer.class)
                    .findFirst()
                    .orElse(0);
        });
        return count;
    }

    @Override
    public void save(Rate rate) {
        JDBIConnector.getConnect().withHandle(handle -> {
            return handle.createUpdate("INSERT INTO rates (star, comment, product_id, user_id) VALUES (:star, :comment, :productId, :userId)")
                    .bindBean(rate)
                    .execute();
        });
    }

    @Override
    public boolean hasUserRated(int userId, int productId) {
        Integer count = JDBIConnector.getConnect().withHandle(handle -> {
            return handle.createQuery("SELECT COUNT(*) FROM rates WHERE user_id = :userId AND product_id = :productId")
                    .bind("userId", userId)
                    .bind("productId", productId)
                    .mapTo(Integer.class)
                    .findFirst()
                    .orElse(0);
        });
        return count > 0;
    }
}
