    package service.impl;

    import dao.CouponDao;
    import dao.impl.CouponDaoImpl;
    import model.Coupon;
    import service.CouponService;

    import java.util.List;

    public class CouponServiceImpl implements CouponService {
        private CouponDao couponDao;

        public CouponServiceImpl() {
            // Khởi tạo DAO; trong dự án thực tế, bạn có thể áp dụng Dependency Injection (DI)
            couponDao = new CouponDaoImpl();
        }

        @Override
        public List<Coupon> getAllCoupons() {
            List<Coupon> list = couponDao.getAllCoupons();
            System.out.println("CouponServiceImpl: Số coupon được lấy: " + list.size());
            return list;
        }

    }
