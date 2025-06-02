package dao;

import model.Product;

import java.util.List;

public interface IStatisticDAO {
    int countOrdersThisMonth();
    int countCustomersThisMonth();
    double calculateRevenueThisMonth();
    int countSoldProductsThisMonth();

    int countOrdersByMonth(int month, int year);
    int countCustomersByMonth(int month, int year);
    double calculateRevenueByMonth(int month, int year);
    int countSoldProductsByMonth(int month, int year);


    int countOrdersInRecent3Months();
    int countCustomersWithOrdersInRecent3Months();
    double calculateRevenueInRecent3Months();
    int countSoldProductsInRecent3Months();

    int countOrdersAll();
    int countCustomersAll();
    double calculateRevenueAll();
    int countSoldProductsAll();

    List<Product> getTop5BestSellingProducts();
    List<Product> getProductsSoldInLastMonths(int months);
    List<Product> getProductsNotSoldInLastMonths(int months);
    List<Product> getLowStockProducts(int threshold);
    List<Product> getShouldRestockProducts(int minSoldQty, int maxStock);

    List<Product> getSmartRestockSuggestions();  // thông minh hơn


}
