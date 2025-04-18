    package service;

    import model.Coupon;
    import service.impl.CouponServiceImpl;

    import java.util.List;

    public interface CouponService {
        /**
         * Lấy danh sách tất cả coupon.
         * @return List<Coupon>
         */
        List<Coupon> getAllCoupons();


    }

