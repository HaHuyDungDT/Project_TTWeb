package dao.impl;

import dao.DashboardDAO;
import db.JDBIConnector;

import java.util.Map;
import java.util.stream.Collectors;

public class DashboardDAOImpl implements DashboardDAO {

    @Override
    public int getTotalRevenue() {
        return JDBIConnector.getConnect().withHandle(handle ->
                handle.createQuery("SELECT SUM(total_price) FROM orders WHERE status = 'Hoàn tất'")
                        .mapTo(Integer.class)
                        .findOne()
                        .orElse(0));
    }

    @Override
    public int getTotalSoldProducts() {
        return JDBIConnector.getConnect().withHandle(handle ->
                handle.createQuery("SELECT SUM(quantity) FROM order_details " +
                                "WHERE order_id IN (SELECT id FROM orders WHERE status = 'Hoàn tất')")
                        .mapTo(Integer.class)
                        .findOne()
                        .orElse(0));
    }

    @Override
    public int getTotalAccounts() {
        return JDBIConnector.getConnect().withHandle(handle ->
                handle.createQuery("SELECT COUNT(*) FROM users")
                        .mapTo(Integer.class)
                        .one());
    }

//    @Override
//    public int getTotalAvailableProducts() {
//        return JDBIConnector.getConnect().withHandle(handle ->
//                handle.createQuery("SELECT COUNT(*) FROM products WHERE quantity > 0 AND status = 1 AND active = 1")
//                        .mapTo(Integer.class)
//                        .one());
//    }

    @Override
    public Map<Integer, Double> getMonthlyRevenue(int year) {
        return JDBIConnector.getConnect().withHandle(handle ->
                handle.createQuery("SELECT MONTH(order_date) as month, SUM(total_price) as revenue " +
                                "FROM orders WHERE YEAR(order_date) = :year AND status = 'Hoàn tất' " +
                                "GROUP BY MONTH(order_date)")
                        .bind("year", year)
                        .mapToMap()
                        .collect(Collectors.toMap(
                                m -> Integer.parseInt(m.get("month").toString()),
                                m -> Double.parseDouble(m.get("revenue").toString())
                        )));
    }
    @Override
    public int getTotalOrders() {
        return JDBIConnector.getConnect().withHandle(handle ->
                handle.createQuery("SELECT COUNT(*) FROM orders")
                        .mapTo(Integer.class)
                        .findOne()
                        .orElse(0));
    }

}
