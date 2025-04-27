package dao.impl;

import dao.ICouponDAO;
import db.JDBIConnector;
import model.Coupon;
import model.Order;

public class CouponImpl implements ICouponDAO {
    private static final String BASE_QUERY = "SELECT id, code, percent_discount, date_start, date_end FROM coupon";

    @Override
    public Coupon getCouponById(Integer couponId) {
        Coupon coupon = JDBIConnector.getConnect().withHandle(handle -> {
            return handle.createQuery(BASE_QUERY + " WHERE id = :id")
                    .bind("id", couponId)
                    .mapToBean(Coupon.class)
                    .findFirst()
                    .orElse(null);
        });
        return coupon;
    }

    @Override
    public double getCouponSale(Integer couponId) {
        return JDBIConnector.getConnect().withHandle(handle -> {
            return handle.createQuery(BASE_QUERY + " WHERE id = :id")
                    .bind("id", couponId)
                    .mapTo(Double.class)
                    .findFirst()
                    .orElse(0.0);
        });
    }
}
