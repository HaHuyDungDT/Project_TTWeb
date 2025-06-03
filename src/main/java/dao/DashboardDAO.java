package dao;

import java.util.Map;

public interface DashboardDAO {
    int getTotalRevenue(); // đơn hoàn tất
    int getTotalSoldProducts();
    int getTotalAccounts();
    public Map<Integer, Double> getMonthlyRevenue(int year);
    int getTotalOrders();

}
