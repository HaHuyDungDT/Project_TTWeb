package controller;

import service.impl.CouponServiceImpl;
import model.Coupon;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(  name = "CouponServlet" , value = "/coupon")
public class CouponServlet extends HttpServlet {

    private CouponServiceImpl couponService;

    @Override
    public void init() throws ServletException {
        // Khởi tạo lớp Service để lấy dữ liệu coupon
        couponService = new CouponServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Coupon> coupons = couponService.getAllCoupons();
        System.out.println("CouponServlet: Số coupon truyền lên JSP: " + coupons.size());
        request.setAttribute("coupons", coupons);
        // Sử dụng đường dẫn tuyệt đối đến coupon.jsp
        RequestDispatcher dispatcher = request.getRequestDispatcher("/coupon.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}