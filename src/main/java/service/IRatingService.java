package service;

import model.Rate;
import java.util.List;

public interface IRatingService {
    List<Rate> findByProductId(int productId);
    double getAverageRating(int productId);
    int getRatingCount(int productId);
    int getRatingCountByStar(int productId, int star);
    void save(Rate rate);
    boolean hasUserPurchasedProduct(int userId, int productId);
    boolean hasUserRated(int userId, int productId);
} 