package controller;

import dao.DashboardDAO;
import dao.impl.DashboardDAOImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.Console;
import java.io.IOException;
import java.time.LocalDate;
import java.util.Map;

@WebServlet("/admin")
public class DashboardController extends HttpServlet {
    private final DashboardDAO dashboardDAO = new DashboardDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int currentYear = LocalDate.now().getYear();
        req.setAttribute("currentYear", currentYear);
        System.out.println(dashboardDAO.getTotalRevenue());
        req.setAttribute("totalOrders", dashboardDAO.getTotalOrders());

        req.setAttribute("totalRevenue", dashboardDAO.getTotalRevenue());
        req.setAttribute("totalSoldProducts", dashboardDAO.getTotalSoldProducts());
        req.setAttribute("totalAccounts", dashboardDAO.getTotalAccounts());
//        req.setAttribute("totalAvailableProducts", dashboardDAO.getTotalAvailableProducts());

        Map<Integer, Double> monthlyRevenue = dashboardDAO.getMonthlyRevenue(currentYear);
        req.setAttribute("monthlyRevenue", monthlyRevenue);

        req.getRequestDispatcher("/admin.jsp").forward(req, resp);
    }
}