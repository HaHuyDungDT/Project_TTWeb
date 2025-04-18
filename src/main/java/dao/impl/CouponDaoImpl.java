package dao.impl;

import dao.CouponDao;
import model.Coupon;
import db.JDBIConnector;
import org.jdbi.v3.core.Jdbi;
import java.util.List;

public class CouponDaoImpl implements CouponDao {
    private Jdbi jdbi = JDBIConnector.getConnect();

    @Override
    public List<Coupon> getAllCoupons() {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT id, code, discount_type, discount_value, order_minimum, total_usage_limit, per_customer_limit, date_start, date_end FROM coupon")
                        .mapToBean(Coupon.class)
                        .list()
        );
    }
}