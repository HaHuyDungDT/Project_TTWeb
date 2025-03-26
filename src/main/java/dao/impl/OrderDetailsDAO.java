package dao.impl;

public class OrderDetailsDAO {
//
//    @Override
//    public List<OrderDetails> selectAll() {
//        List<OrderDetails> orderDetails = JDBIConnector.getConnect().withHandle((handle ->
//                handle.createQuery("SELECT id, order_id, product_id, quantity, price, discount, amount FROM order_details")
//                        .mapToBean(OrderDetails.class).stream().collect(Collectors.toList())
//        ));
//        return orderDetails;
//    }
//
//    @Override
//    public OrderDetails selectById(OrderDetails orderDetailsP) {
//        Optional<OrderDetails> orderDetails = JDBIConnector.getConnect().withHandle((handle ->
//                handle.createQuery("SELECT id, order_id, product_id, quantity, price, discount, amount FROM order_details WHERE id=?")
//                        .bind(0, orderDetailsP.getId())
//                        .mapToBean(OrderDetails.class).stream().findFirst()
//        ));
//        return orderDetails.isEmpty() ? null : orderDetails.get();
//    }
//
//    public List<OrderDetails> getByIdOrder(String order_id) {
//        try {
//            return JDBIConnector.getConnect().withHandle(handle -> handle.createQuery("SELECT order_details.id, order_details.order_id, product_id, order_details.quantity, order_details.price, order_details.discount, amount, products.name, products.image FROM order_details, products WHERE products.id = order_details.product_id and order_id=?")
//                    .bind(0, order_id)
//                    .map((rs, ctx) -> {
//                        String oddId = rs.getString("id");
//                        String orderId = rs.getString("order_id");
//                        String productId = rs.getString("product_id");
//                        String name = rs.getString("name");
//                        String img = rs.getString("image");
//                        int quantity = rs.getInt("quantity");
//                        double price = rs.getDouble("price");
//                        double discount = rs.getDouble("discount");
//                        double amount = rs.getDouble("amount");
//                        Order order = new Order(orderId, null, null, null, null, null, null);
//                        Product product = new Product(productId, name, 0, null, 0, null, img);
//                        return new OrderDetails(oddId, order, product, quantity, price, discount, amount);
//                    })
//                    .list()
//            );
//        } catch (Exception e) {
//            e.printStackTrace(); // In ra lỗi để debug
//            return null;
//        }
//    }
//
//
//    @Override
//    public int insert(OrderDetails orderDetails) {
//        int ketQua = JDBIConnector.getConnect().withHandle(handle -> {
//            return handle.createUpdate("INSERT INTO order_details (id, order_id, product_id, quantity, price, discount, amount) VALUES (:id, :order_id, :product_id, :quantity, :price, :discount, :amount)")
//                    .bindBean(orderDetails)
//                    .execute();
//        });
//        return ketQua;
//    }
//
//    @Override
//    public int delete(OrderDetails orderDetails) {
//        int ketQua = JDBIConnector.getConnect().withHandle(handle ->{
//            return handle.createUpdate("DELETE FROM order_details WHERE id = :id")
//                    .bind("id", orderDetails.getId())
//                    .execute();
//        });
//        return ketQua;
//    }
//
//    @Override
//    public int update(OrderDetails orderDetails) {
//
//        int ketQua = JDBIConnector.getConnect().withHandle(handle -> {
//            return handle.createUpdate("UPDATE order_details SET order_id = :order_id, product_id = :product_id, quantity = :quantity, price = :price, discount = :discount, amount = :amount WHERE id = :id")
//                    .bindBean(orderDetails)
//                    .execute();
//        });
//        return ketQua;
//    }
//
//    public int countSoldProductsInThisMonth() {
//        int count = JDBIConnector.getConnect().withHandle(handle ->
//                    handle.createQuery("SELECT SUM(order_details.quantity) as product_count " +
//                                    "FROM order_details " +
//                                    "JOIN orders ON order_details.order_id = orders.id " +
//                                    "WHERE MONTH(orders.order_date) = MONTH(CURRENT_DATE()) " +
//                                    "AND YEAR(orders.order_date) = YEAR(CURRENT_DATE())")
//                            .mapTo(Integer.class)
//                            .one()
//            );
//        return count;
//    }
//
//    public double calculateRevenueInThisMonth() {
//        double revenue =  JDBIConnector.getConnect().withHandle(handle ->
//                    handle.createQuery("SELECT SUM(order_details.amount) as total_revenue " +
//                                    "FROM order_details " +
//                                    "JOIN orders ON order_details.order_id = orders.id " +
//                                    "WHERE MONTH(orders.order_date) = MONTH(CURRENT_DATE()) " +
//                                    "AND YEAR(orders.order_date) = YEAR(CURRENT_DATE())")
//                            .mapTo(Double.class)
//                            .one()
//            );
//        return revenue;
//    }
//
//    public static void main(String[] args) {
//        OrderDetailsDAO odd = new OrderDetailsDAO();
//        List<OrderDetails> o = odd.getByIdOrder("or_1711955239956");
//        System.out.println(o);
//
//    }
}