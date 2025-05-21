package dao;

import model.Rate;

import java.util.List;

public interface IRatingDAO {
    List<Rate> findAll();
    Rate findById(int id);
    List<Rate> findByProductId(int productId);
    double getAverageRating(int productId);
    int getRatingCount(int productId);
    int getRatingCountByStar(int productId, int star);
    void save(Rate rate);
    boolean hasUserRated(int userId, int productId);
}
