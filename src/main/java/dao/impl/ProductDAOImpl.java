package dao.impl;

import dao.IProductDAO;
import db.JDBIConnector;
import model.Product;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

public class ProductDAOImpl implements IProductDAO {
    private static final String BASE_QUERY = "SELECT id, name, price, product_type_id, producer_id, quantity, status, coupon_id, detail, import_date FROM products WHERE active = 1 ";

    public static Product getById(String id) {
        try {
            return JDBIConnector.getConnect()
                    .withHandle(handle ->
                            handle.createQuery("SELECT id, name, price, product_type_id as productTypeID, producer_id as producerID, quantity, status, coupon_id as couponId, detail, import_date FROM products WHERE id = :id AND active = 1")
                                    .bind("id", Integer.parseInt(id))
                                    .mapToBean(Product.class)
                                    .findOne()
                                    .orElse(null)
                    );
        } catch (NumberFormatException ex) {
            ex.printStackTrace();
            return null;
        }
    }

//    @Override
//    public boolean addProduct(Product product) {
//        String sql = "INSERT INTO products (name, price, quantity, detail, product_type_id, producer_id, status, import_date, coupon_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
//        return JDBIConnector.getConnect().withHandle(handle -> {
//            return handle.createUpdate(sql)
//                    .bind(0, product.getName())            // Tên sản phẩm
//                    .bind(1, product.getPrice())           // Giá sản phẩm
//                    .bind(2, product.getQuantity())        // Số lượng sản phẩm
//                    .bind(3, product.getDetail())          // Chi tiết sản phẩm
//                    .bind(4, product.getProductTypeID())   // ID loại sản phẩm
//                    .bind(5, product.getProducerID())      // ID nhà sản xuất
//                    .bind(6, product.getStatus())          // Trạng thái sản phẩm
//                    .bind(7, product.getImport_date())     // Ngày nhập hàng
//                    .bind(8, product.getCouponId())        // ID mã giảm giá (nếu có)
//                    .execute() > 0;
//        });
//    }
@Override
public boolean addProduct(Product product) {
    String sql = "INSERT INTO products (name, price, quantity, detail, product_type_id, producer_id, status, import_date, coupon_id) " +
            "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

    // Chèn sản phẩm vào cơ sở dữ liệu và lấy ID tự động
    return JDBIConnector.getConnect().withHandle(handle -> {
        int rowsAffected = handle.createUpdate(sql)
                .bind(0, product.getName())
                .bind(1, product.getPrice())
                .bind(2, product.getQuantity())
                .bind(3, product.getDetail())
                .bind(4, product.getProductTypeID())
                .bind(5, product.getProducerID())
                .bind(6, product.getStatus())
                .bind(7, product.getImport_date())
                .bind(8, product.getCouponId())
                .execute();

        // Lấy ID của sản phẩm vừa thêm (ID tự động tăng)
        if (rowsAffected > 0) {
            product.setId(handle.createQuery("SELECT LAST_INSERT_ID()")
                    .mapTo(Integer.class)
                    .findOnly());
            return true;
        }
        return false;
    });
}


    @Override
    public boolean updateProduct(Product product) {
//        int rowsAffected = JDBIConnector.getConnect().withHandle(handle ->
//                handle.createUpdate("UPDATE products SET name = :name, price = :price, product_type_id = :productTypeId, producer_id = :producerId, detail = :detail WHERE id = :productId")
//                        .bind("name", product.getName())
//                        .bind("price", product.getPrice())
//                        .bind("productTypeId", product.getProductType().getId())
//                        .bind("producerId", product.getProducer().getId())
//                        .bind("detail", product.getDetail())
//                        .bind("productId", product.getId())
//                        .execute()
//        );
//        return rowsAffected > 0;
        String sql = "UPDATE products SET name = ?, price = ?, quantity = ?, detail = ?, product_type_id = ?, producer_id = ?, status = ?, import_date = ?, coupon_id = ? WHERE id = ?";
        return JDBIConnector.getConnect().withHandle(handle -> {
            return handle.createUpdate(sql)
                    .bind(0, product.getName())            // Tên sản phẩm
                    .bind(1, product.getPrice())           // Giá sản phẩm
                    .bind(2, product.getQuantity())        // Số lượng sản phẩm
                    .bind(3, product.getDetail())          // Chi tiết sản phẩm
                    .bind(4, product.getProductTypeID())   // ID loại sản phẩm
                    .bind(5, product.getProducerID())      // ID nhà sản xuất
                    .bind(6, product.getStatus())          // Trạng thái sản phẩm
                    .bind(7, product.getImport_date())     // Ngày nhập hàng
                    .bind(8, product.getCouponId())        // ID mã giảm giá (nếu có)
                    .bind(9, product.getId())              // ID sản phẩm cần cập nhật
                    .execute() > 0;
        });

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
        if (product != null) {
            System.out.println("Product found in DB: " + product);
        } else {
            System.out.println("No product found with ID: " + id);
        }
        return product;
    }



    @Override
    public List<Product> findByName(String name) {
        String sql = BASE_QUERY + " AND name LIKE :searchPattern";
        String pattern = "%" + name + "%";
        List<Product> products = JDBIConnector.getConnect().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("searchPattern", pattern)
                        .mapToBean(Product.class)
                        .list()
        );
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
