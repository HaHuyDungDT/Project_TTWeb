package dao.impl;

import dao.IProductDAO;
import db.JDBIConnector;
import model.Product;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;

public class ProductDAOImpl implements IProductDAO {
    private static final String BASE_QUERY = "SELECT id, name, price, product_type_id, producer_id, quantity, status, coupon_id, detail, import_date FROM products WHERE active = 1 ";

    @Override
    public boolean addProduct(Product product) {

        return false;
    }

    @Override
    public boolean updateProduct(Product product) {
        int rowsAffected = JDBIConnector.getConnect().withHandle(handle ->
                handle.createUpdate("UPDATE products SET name = :name, price = :price, product_type_id = :productTypeId, producer_id = :producerId, detail = :detail WHERE id = :productId")
                        .bind("name", product.getName())
                        .bind("price", product.getPrice())
                        .bind("productTypeId", product.getProductType().getId())
                        .bind("producerId", product.getProducer().getId())
                        .bind("detail", product.getDetail())
                        .bind("productId", product.getId())
                        .execute()
        );
        return rowsAffected > 0;
    }

    @Override
    public boolean deleteById(Integer productId) {
        int rowsAffected = JDBIConnector.getConnect().withHandle(handle ->
                handle.createUpdate("UPDATE products SET active = 0 WHERE id = :productId")
                        .bind("productId", productId)
                        .execute()
        );
        return rowsAffected > 0;
    }

    @Override
    public List<Product> findAll() {
        List<Product> products = JDBIConnector.getConnect().withHandle(handle -> {
            return handle.createQuery(BASE_QUERY)
                    .mapToBean(Product.class)
                    .list();
        });
        return products;
    }

    @Override
    public Product findById(Integer id) {
        Product product = JDBIConnector.getConnect().withHandle(handle -> {
            return handle.createQuery(BASE_QUERY + " AND id = :id")
                    .bind("id", id)
                    .mapToBean(Product.class)
                    .findFirst()
                    .orElse(null);
        });
        return product;
    }

    @Override
    public List<Product> findByName(String name) {
        List<Product> products = JDBIConnector.getConnect().withHandle(handle -> {
            return handle.createQuery(BASE_QUERY + " AND (name LIKE '" + name + "%'" + " OR name LIKE '%" + name + "%'" + " OR name LIKE '%" + name + "')")
                    .mapToBean(Product.class)
                    .list();
        });
        return products;
    }

    @Override
    public List<Product> findByCategory(Integer categoryId) {
        List<Product> products = JDBIConnector.getConnect().withHandle(handle -> {
            return handle.createQuery(BASE_QUERY + " AND product_type_id = :productTypeId")
                    .bind("productTypeId", categoryId)
                    .mapToBean(Product.class)
                    .list();
        });
        return products;
    }

    @Override
    public List<Product> findByProducer(Integer producerId) {
        List<Product> products = JDBIConnector.getConnect().withHandle(handle -> {
            return handle.createQuery(BASE_QUERY + " AND producer_id = :producerId")
                    .bind("producerId", producerId)
                    .mapToBean(Product.class)
                    .list();
        });
        return products;
    }

    @Override
    public List<Product> findNewProduct() {
        List<Product> products = JDBIConnector.getConnect().withHandle(handle -> {
            return handle.createQuery(BASE_QUERY + " AND import_date >= :date")
                    .bind("date", LocalDate.now().minusDays(10).format(DateTimeFormatter.ISO_DATE))
                    .mapToBean(Product.class)
                    .list();
        });
        return products;
    }

    @Override
    public List<Product> findSaleProduct() {
        List<Product> products = JDBIConnector.getConnect().withHandle(handle -> {
            return handle.createQuery(BASE_QUERY + " AND status = 'sale'")
                    .mapToBean(Product.class)
                    .list();
        });
        return products;
    }

    @Override
    public List<Product> findProductIsSelling() {
        List<Product> products = JDBIConnector.getConnect().withHandle(handle -> {
            return handle.createQuery(BASE_QUERY + " AND status = 'selling'")
                    .mapToBean(Product.class)
                    .list();
        });
        return products;
    }

    @Override
    public List<Product> getPaging(int index) {
        int pageSize = 20;
        int offset = (index - 1) * pageSize;
        List<Product> result = JDBIConnector.getConnect().withHandle(handle ->
                handle.createQuery("SELECT id, name, price, product_type_id, quantity, producer_id " +
                                "FROM products ORDER BY id LIMIT :pageSize OFFSET :offset")
                        .bind("pageSize", pageSize)
                        .bind("offset", offset)
                        .mapToBean(Product.class)
                        .list()
        );
        return result;
    }

    @Override
    public List<Product> findProductToImport() {
        List<Product> products = JDBIConnector.getConnect().withHandle(handle -> {
            return handle.createQuery(BASE_QUERY + " AND quantity < 20")
                    .mapToBean(Product.class)
                    .list();
        });
        return products;
    }

    @Override
    public List<Product> findBestSeller() {
        List<Product> products = JDBIConnector.getConnect().withHandle(handle -> {
            return handle.createQuery("SELECT p.id, p.name, p.price, p.product_type_id, p.producer_id, p.quantity, p.status, p.coupon_id, p.detail, p.import_date, SUM(od.quantity) as total_quantity " +
                            "FROM products p " +
                            "JOIN order_details od ON p.id = od.product_id " +
                            "JOIN orders o ON od.order_id = o.id " +
                            "WHERE active = 1 AND o.order_date >= :lastMonth " +
                            "GROUP BY p.id " +
                            "HAVING SUM(od.quantity) >= 30 " +
                            "ORDER BY total_quantity DESC " +
                            "LIMIT 10")
                    .bind("lastMonth", LocalDate.now().minusMonths(1).format(DateTimeFormatter.ISO_DATE))
                    .mapToBean(Product.class)
                    .list();
        });
        return products;
    }

    @Override
    public List<Product> findProductInStock() {
        List<Product> products = JDBIConnector.getConnect().withHandle(handle -> {
            return handle.createQuery("SELECT p.id, p.name, p.price, p.product_type_id, p.producer_id, p.quantity, p.status, p.coupon_id, p.detail, p.import_date " +
                            "FROM products p " +
                            "LEFT JOIN order_details od ON p.id = od.product_id " +
                            "LEFT JOIN orders o ON od.order_id = o.id " +
                            "WHERE p.active = 1 " +
                            "AND (o.order_date >= :threeMonthsAgo OR o.order_date IS NULL) " +
                            "GROUP BY p.id " +
                            "HAVING COUNT(o.id) < 10")
                    .bind("threeMonthsAgo", LocalDate.now().minusMonths(3).format(DateTimeFormatter.ISO_DATE))
                    .mapToBean(Product.class)
                    .list();
        });
        return products;
    }
}