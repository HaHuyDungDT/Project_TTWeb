package dao.impl;

import dao.IStatisticDAO;
import db.JDBIConnector;
import model.Product;

import java.util.List;

public class StatisticDAOImpl implements IStatisticDAO {

    // ========== THÁNG NÀY ==========
    @Override
    public int countOrdersThisMonth() {
        String sql = "SELECT COUNT(*) FROM orders WHERE MONTH(order_date) = MONTH(CURDATE()) AND YEAR(order_date) = YEAR(CURDATE())";
        return queryInt(sql);
    }

    @Override
    public int countCustomersThisMonth() {
        String sql = "SELECT COUNT(DISTINCT user_id) FROM orders WHERE MONTH(order_date) = MONTH(CURDATE()) AND YEAR(order_date) = YEAR(CURDATE())";
        return queryInt(sql);
    }

    @Override
    public double calculateRevenueThisMonth() {
        String sql = "SELECT SUM(total_price) FROM orders WHERE MONTH(order_date) = MONTH(CURDATE()) AND YEAR(order_date) = YEAR(CURDATE())";
        return queryDouble(sql);
    }

    @Override
    public int countSoldProductsThisMonth() {
        String sql = "SELECT SUM(od.quantity) FROM order_details od JOIN orders o ON od.order_id = o.id WHERE MONTH(o.order_date) = MONTH(CURDATE()) AND YEAR(o.order_date) = YEAR(CURDATE())";
        return queryInt(sql);
    }

    // ========== 3 THÁNG GẦN NHẤT ==========
    @Override
    public int countOrdersInRecent3Months() {
        String sql = "SELECT COUNT(*) FROM orders WHERE order_date BETWEEN DATE_SUB(NOW(), INTERVAL 3 MONTH) AND NOW()";
        return queryInt(sql);
    }

    @Override
    public int countCustomersWithOrdersInRecent3Months() {
        String sql = "SELECT COUNT(DISTINCT user_id) FROM orders WHERE order_date BETWEEN DATE_SUB(NOW(), INTERVAL 3 MONTH) AND NOW()";
        return queryInt(sql);
    }

    @Override
    public double calculateRevenueInRecent3Months() {
        String sql = "SELECT SUM(total_price) FROM orders WHERE order_date BETWEEN DATE_SUB(NOW(), INTERVAL 3 MONTH) AND NOW()";
        return queryDouble(sql);
    }

    @Override
    public int countSoldProductsInRecent3Months() {
        String sql = "SELECT SUM(od.quantity) FROM order_details od JOIN orders o ON od.order_id = o.id WHERE o.order_date BETWEEN DATE_SUB(NOW(), INTERVAL 3 MONTH) AND NOW()";
        return queryInt(sql);
    }

    // ========== TOÀN BỘ ==========
    @Override
    public int countOrdersAll() {
        return queryInt("SELECT COUNT(*) FROM orders");
    }

    @Override
    public int countCustomersAll() {
        return queryInt("SELECT COUNT(DISTINCT user_id) FROM orders");
    }

    @Override
    public double calculateRevenueAll() {
        return queryDouble("SELECT SUM(total_price) FROM orders");
    }

    @Override
    public int countSoldProductsAll() {
        return queryInt("SELECT SUM(quantity) FROM order_details");
    }

    // ========== HÀM DÙNG CHUNG ==========
    private int queryInt(String sql) {
        return JDBIConnector.getConnect().withHandle(handle ->
                handle.createQuery(sql).mapTo(Integer.class).findOne().orElse(0)
        );
    }

    private double queryDouble(String sql) {
        return JDBIConnector.getConnect().withHandle(handle ->
                handle.createQuery(sql).mapTo(Double.class).findOne().orElse(0.0)
        );
    }

    @Override
    public int countOrdersByMonth(int month, int year) {
        String sql = "SELECT COUNT(*) FROM orders WHERE MONTH(order_date) = :month AND YEAR(order_date) = :year";
        return queryInt(sql, month, year);
    }

    @Override
    public int countCustomersByMonth(int month, int year) {
        String sql = "SELECT COUNT(DISTINCT user_id) FROM orders WHERE MONTH(order_date) = :month AND YEAR(order_date) = :year";
        return queryInt(sql, month, year);
    }

    @Override
    public double calculateRevenueByMonth(int month, int year) {
        String sql = "SELECT SUM(total_price) FROM orders WHERE MONTH(order_date) = :month AND YEAR(order_date) = :year";
        return queryDouble(sql, month, year);
    }

    @Override
    public int countSoldProductsByMonth(int month, int year) {
        String sql = "SELECT SUM(od.quantity) FROM order_details od JOIN orders o ON od.order_id = o.id WHERE MONTH(o.order_date) = :month AND YEAR(o.order_date) = :year";
        return queryInt(sql, month, year);
    }

    // helper overloads
    private int queryInt(String sql, int month, int year) {
        return JDBIConnector.getConnect().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("month", month)
                        .bind("year", year)
                        .mapTo(Integer.class)
                        .findOne()
                        .orElse(0)
        );
    }

    private double queryDouble(String sql, int month, int year) {
        return JDBIConnector.getConnect().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("month", month)
                        .bind("year", year)
                        .mapTo(Double.class)
                        .findOne()
                        .orElse(0.0)
        );
    }

    @Override
    public List<Product> getTop5BestSellingProducts() {
        String sql = "SELECT p.* FROM products p " +
                "JOIN order_details od ON p.id = od.product_id " +
                "GROUP BY p.id ORDER BY SUM(od.quantity) DESC LIMIT 5";
        return JDBIConnector.getConnect().withHandle(h ->
                h.createQuery(sql).mapToBean(Product.class).list()
        );
    }

    @Override
    public List<Product> getProductsSoldInLastMonths(int months) {
        String sql = "SELECT DISTINCT p.* FROM products p " +
                "JOIN order_details od ON p.id = od.product_id " +
                "JOIN orders o ON od.order_id = o.id " +
                "WHERE o.order_date >= DATE_SUB(NOW(), INTERVAL :months MONTH)";
        return JDBIConnector.getConnect().withHandle(h ->
                h.createQuery(sql)
                        .bind("months", months)
                        .mapToBean(Product.class)
                        .list()
        );
    }

    @Override
    public List<Product> getProductsNotSoldInLastMonths(int months) {
        String sql = "SELECT * FROM products " +
                "WHERE id NOT IN (" +
                "  SELECT DISTINCT od.product_id FROM order_details od " +
                "  JOIN orders o ON od.order_id = o.id " +
                "  WHERE o.order_date >= DATE_SUB(NOW(), INTERVAL :months MONTH)" +
                ")";
        return JDBIConnector.getConnect().withHandle(h ->
                h.createQuery(sql)
                        .bind("months", months)
                        .mapToBean(Product.class)
                        .list()
        );
    }

    @Override
    public List<Product> getLowStockProducts(int threshold) {
        String sql = "SELECT p.* FROM products p " +
                "JOIN inventory i ON p.id = i.product_id " +
                "WHERE i.quantity < :threshold";
        return JDBIConnector.getConnect().withHandle(h ->
                h.createQuery(sql)
                        .bind("threshold", threshold)
                        .mapToBean(Product.class)
                        .list()
        );
    }

    @Override
    public List<Product> getShouldRestockProducts(int minSoldQty, int maxStock) {
        String sql =
                "SELECT p.* FROM products p " +
                        "JOIN inventory i ON p.id = i.product_id " +
                        "JOIN order_details od ON p.id = od.product_id " +
                        "WHERE i.quantity < :maxStock " +
                        "GROUP BY p.id " +
                        "HAVING SUM(od.quantity) >= :minSold";

        return JDBIConnector.getConnect().withHandle(h ->
                h.createQuery(sql)
                        .bind("minSold", minSoldQty)
                        .bind("maxStock", maxStock)
                        .mapToBean(Product.class)
                        .list()
        );
    }
    @Override
    public List<Product> getSmartRestockSuggestions() {
        String sql =
                "SELECT p.* FROM products p " +
                        "JOIN inventory i ON p.id = i.product_id " +
                        "JOIN order_details od ON p.id = od.product_id " +
                        "JOIN orders o ON od.order_id = o.id " +
                        "WHERE i.quantity < 10 AND o.order_date >= DATE_SUB(NOW(), INTERVAL 3 MONTH) " +
                        "GROUP BY p.id ORDER BY SUM(od.quantity) DESC";

        return JDBIConnector.getConnect().withHandle(h ->
                h.createQuery(sql).mapToBean(Product.class).list()
        );
    }




}
