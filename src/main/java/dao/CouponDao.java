package dao;

import dao.impl.CouponDaoImpl;
import model.Coupon;
import java.util.List;

public interface CouponDao {
    /**
     * Lấy danh sách tất cả coupon từ cơ sở dữ liệu.
     * @return List<Coupon>
     */
    List<Coupon> getAllCoupons();
}
