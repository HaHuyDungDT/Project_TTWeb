package controller;

import dao.IStatisticDAO;
import dao.impl.StatisticDAOImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/thongke")
public class StatisticController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        IStatisticDAO dao = new StatisticDAOImpl();

        // Biến cho tháng hiện tại
        int orderCurr = dao.countOrdersThisMonth();
        int customerCurr = dao.countCustomersThisMonth();
        int productCurr = dao.countSoldProductsThisMonth();
        double revenueCurr = dao.calculateRevenueThisMonth();

        request.setAttribute("orderThisMonth", orderCurr);
        request.setAttribute("customerThisMonth", customerCurr);
        request.setAttribute("productThisMonth", productCurr);
        request.setAttribute("revenueThisMonth", revenueCurr);

        // Biến cho tháng trước
        LocalDate now = LocalDate.now();
        int currentMonth = now.getMonthValue();
        int currentYear = now.getYear();

        int lastMonth = (currentMonth == 1) ? 12 : currentMonth - 1;
        int lastYear = (currentMonth == 1) ? currentYear - 1 : currentYear;

        int orderLast = dao.countOrdersByMonth(lastMonth, lastYear);
        int customerLast = dao.countCustomersByMonth(lastMonth, lastYear);
        int productLast = dao.countSoldProductsByMonth(lastMonth, lastYear);
        double revenueLast = dao.calculateRevenueByMonth(lastMonth, lastYear);

        request.setAttribute("orderCurr", (double) orderCurr);
        request.setAttribute("orderLast", (double) orderLast);
        request.setAttribute("customerCurr", (double) customerCurr);
        request.setAttribute("customerLast", (double) customerLast);
        request.setAttribute("productCurr", (double) productCurr);
        request.setAttribute("productLast", (double) productLast);
        request.setAttribute("revenueCurr", revenueCurr);
        request.setAttribute("revenueLast", revenueLast);

        // 3 tháng gần nhất
        request.setAttribute("order3Months", dao.countOrdersInRecent3Months());
        request.setAttribute("customer3Months", dao.countCustomersWithOrdersInRecent3Months());
        request.setAttribute("product3Months", dao.countSoldProductsInRecent3Months());
        request.setAttribute("revenue3Months", dao.calculateRevenueInRecent3Months());

        // Tất cả
        request.setAttribute("orderAll", dao.countOrdersAll());
        request.setAttribute("customerAll", dao.countCustomersAll());
        request.setAttribute("productAll", dao.countSoldProductsAll());
        request.setAttribute("revenueAll", dao.calculateRevenueAll());

        // Top 5 bán chạy
        request.setAttribute("topProducts", dao.getTop5BestSellingProducts());

// Sản phẩm bán được
        request.setAttribute("sold3Months", dao.getProductsSoldInLastMonths(3));
        request.setAttribute("sold6Months", dao.getProductsSoldInLastMonths(6));

// Không bán được
        request.setAttribute("unsold3Months", dao.getProductsNotSoldInLastMonths(3));
        request.setAttribute("unsold6Months", dao.getProductsNotSoldInLastMonths(6));

// Cần nhập kho
        request.setAttribute("lowStock", dao.getLowStockProducts(10));

// Nên nhập kho (bán chạy nhưng tồn kho thấp)
        request.setAttribute("shouldRestock", dao.getShouldRestockProducts(20, 15));
        request.setAttribute("smartRestock", dao.getSmartRestockSuggestions());



        request.getRequestDispatcher("thongke.jsp").forward(request, response);
    }

}