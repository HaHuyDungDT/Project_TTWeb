package dao.impl;

import dao.IOrderDetailDAO;
import db.JDBIConnector;
import model.Image;
import model.Order;
import model.OrderDetails;
import model.Product;
import org.jdbi.v3.core.mapper.reflect.ConstructorMapper;

import java.util.ArrayList;
import java.util.List;

public class OrderDetailDAOImpl implements IOrderDetailDAO {
    private static final String BASE_QUERY = "SELECT id, order_id, amount, product_id, quantity FROM order_details";

    private static final String ORDER_DETAILS_QUERY = "SELECT od.id, od.order_id, od.amount, od.product_id, od.quantity, p.name, i.link_image " +
            "FROM order_details od " +
            "LEFT JOIN products p ON od.product_id = p.id " +
            "LEFT JOIN images i ON p.id = i.product_id";

    @Override
    public List<OrderDetails> findAll() {
        List<OrderDetails> ordersDetails = JDBIConnector.getConnect().withHandle(handle -> {
            return handle.createQuery(BASE_QUERY)
                    .mapToBean(OrderDetails.class)
                    .list();
        });
        return ordersDetails;
    }

    @Override
    public OrderDetails findById(Integer id) {
        OrderDetails orderDetails = JDBIConnector.getConnect().withHandle(handle -> {
            return handle.createQuery(BASE_QUERY + " WHERE id = :id")
                    .bind("id", id)
                    .mapToBean(OrderDetails.class)
                    .findFirst()
                    .orElse(null);
        });
        return orderDetails;
    }
    @Override
    public List<OrderDetails> findByOrderId(Integer orderId) {
        String sql = "SELECT od.*, p.id AS p_id, p.name AS p_name, p.price AS p_price " +
                "FROM order_details od JOIN products p ON od.product_id = p.id " +
                "WHERE od.order_id = :orderId";

        return JDBIConnector.getConnect().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("orderId", orderId)
                        .map((rs, ctx) -> {
                            OrderDetails detail = new OrderDetails();
                            detail.setId(rs.getInt("id"));
                            detail.setQuantity(rs.getInt("quantity"));
                            detail.setAmount(rs.getDouble("amount"));

                            Product product = new Product();
                            product.setId(rs.getInt("p_id"));
                            product.setName(rs.getString("p_name"));
                            product.setPrice(rs.getDouble("p_price"));
                            detail.setProduct(product);

                            return detail;
                        })
                        .list()
        );

    }

//    public List<OrderDetails> findByIdOrder(Integer idOrder) {
//        List<OrderDetails> ordersDetails = JDBIConnector.getConnect().withHandle(handle -> {
//            return handle.createQuery(BASE_QUERY + " WHERE order_id = :idOrder")
//                    .bind("idOrder", idOrder)
//                    .mapToBean(OrderDetails.class)
//                    .list();
//        });
//        return ordersDetails;
//    }

    public List<OrderDetails> findByIdOrder(Integer idOrder) {
        List<OrderDetails> ordersDetails = JDBIConnector.getConnect().withHandle(handle -> {
            return handle.createQuery(ORDER_DETAILS_QUERY + " WHERE od.order_id = :idOrder")
                    .bind("idOrder", idOrder)
                    .map((rs, ctx) -> {
                        OrderDetails orderDetails = new OrderDetails();
                        orderDetails.setId(rs.getInt("od.id"));
                        orderDetails.setAmount(rs.getDouble("od.amount"));
                        orderDetails.setQuantity(rs.getInt("od.quantity"));

                        Order order = new Order();
                        order.setId(rs.getInt("od.order_id"));
                        orderDetails.setOrder(order);

                        Product product = new Product();
                        product.setId(rs.getInt("od.product_id"));
                        product.setName(rs.getString("p.name"));

                        List<Image> images = new ArrayList<>();
                        Image image = new Image();
                        image.setLinkImage(rs.getString("i.link_image"));
                        images.add(image);

                        product.setImages(images);
                        orderDetails.setProduct(product);

                        return orderDetails;
                    })
                    .list();
        });
        return ordersDetails;
    }


    @Override
    public boolean addOrderDetails(OrderDetails orderDetails) {
        int rowsAffected = JDBIConnector.getConnect().withHandle(handle -> {
            return handle.createUpdate("INSERT INTO order_details(order_id, amount, product_id, quantity) VALUES (?, ?, ?, ?)")
                    .bind(0, orderDetails.getOrder().getId())
                    .bind(1, orderDetails.getAmount())
                    .bind(2, orderDetails.getProduct().getId())
                    .bind(3, orderDetails.getQuantity())
                    .execute();

        });
        return rowsAffected > 0;
    }

    @Override
    public boolean updateOrderDetails(OrderDetails orderDetails) {
        int rowsAffected = JDBIConnector.getConnect().withHandle(handle -> {
            return handle.createUpdate("UPDATE orders " +
                            "SET order_id = :orderId, amount: amount, product_id = :productId, quantity = :quantity" +
                            "WHERE id = :id")
                    .bind("orderId", orderDetails.getOrder().getId())
                    .bindBean(orderDetails)
                    .execute();
        });
        return rowsAffected > 0;
    }

    @Override
    public boolean deleteOrder(Integer idOrderDetails) {
        int rowsAffected = JDBIConnector.getConnect().withHandle(handle ->
                handle.createUpdate("DELETE FROM order_details WHERE id = :idOrderDetails")
                        .bind("idOrderDetails", idOrderDetails)
                        .execute()
        );
        return rowsAffected > 0;
    }

    public static void main(String[] args) {
        OrderDetailDAOImpl dao = new OrderDetailDAOImpl();
        List<OrderDetails> all = dao.findByIdOrder(1);
        for (OrderDetails orderDetails : all) {
            System.out.println(orderDetails);
        }
    }
}
