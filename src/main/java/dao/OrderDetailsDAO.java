package dao;

import model.*;
import db.JDBIConector;

import java.sql.*;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

public class OrderDetailsDAO implements DAOInterface<OrderDetails>{
    @Override
    public List<OrderDetails> selectAll() {
        List<OrderDetails> orderDetails = JDBIConector.me().withHandle((handle ->
                handle.createQuery("SELECT id, order_id, product_id, quantity, price, discount, amount FROM order_details")
                        .mapToBean(OrderDetails.class).stream().collect(Collectors.toList())
        ));
        return orderDetails;
    }
    @Override
    public OrderDetails selectById(OrderDetails orderDetailsP) {
        Optional<OrderDetails> orderDetails = JDBIConector.me().withHandle((handle ->
                handle.createQuery("SELECT id, order_id, product_id, quantity, price, discount, amount FROM order_details WHERE id=?")
                        .bind(0, orderDetailsP.getId())
                        .mapToBean(OrderDetails.class).stream().findFirst()
        ));
        return orderDetails.isEmpty() ? null : orderDetails.get();
    }


    @Override
    public int insert(OrderDetails orderDetails) {
        int ketQua = 0;
        try {
            // Bước 1: tạo kết nối đến CSDL
            Connection con = JDBCUtil.getConnection();

            // **Bước 1.1: Lấy ID lớn nhất hiện tại**
            String getMaxIdSql = "SELECT id FROM order_details ORDER BY id DESC LIMIT 1";
            PreparedStatement getMaxIdStmt = con.prepareStatement(getMaxIdSql);
            ResultSet rs = getMaxIdStmt.executeQuery();

            String newId = "od_1"; // Giá trị mặc định nếu chưa có bản ghi nào
            if (rs.next()) {
                String lastId = rs.getString("id");
                int numericPart = Integer.parseInt(lastId.split("_")[1]); // Tách phần số từ ID
                newId = "od_" + (numericPart + 1); // Tăng giá trị phần số lên 1
            }

            // **Bước 2: tạo câu lệnh INSERT**
            String sql = "INSERT INTO order_details (id, order_id, product_id, quantity, price, discount, amount) " +
                    "VALUES (?,?,?,?,?,?,?)";

            PreparedStatement st = con.prepareStatement(sql);
            st.setString(1, newId); // Sử dụng ID mới
            if (orderDetails.getOrder() != null) {
                st.setString(2, orderDetails.getOrder().getId());
            } else {
                st.setNull(2, Types.VARCHAR);
            }
            st.setString(3, orderDetails.getProduct().getId());
            st.setInt(4, orderDetails.getQuantity());
            st.setDouble(5, orderDetails.getPrice());
            st.setDouble(6, orderDetails.getDiscount());
            st.setDouble(7, orderDetails.getAmount());

            // **Bước 3: thực thi câu lệnh SQL**
            ketQua = st.executeUpdate();

            // **Bước 4: In kết quả**
            System.out.println("Bạn đã thực thi: " + sql);
            System.out.println("Có " + ketQua + " dòng bị thay đổi!");
            System.out.println("ID mới của order_details: " + newId);

            // **Bước 5: đóng kết nối**
            JDBCUtil.closeConnection(con);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return ketQua;
    }

    @Override
    public int delete(OrderDetails orderDetails) {

        int ketQua = 0;
        try {
            // Bước 1: tạo kết nối đến CSDL
            Connection con = JDBCUtil.getConnection();

            // Bước 2: tạo ra đối tượng statement
            String sql = "DELETE from order_details "+
                    " WHERE id=?";

            PreparedStatement st = con.prepareStatement(sql);
            st.setString(1, orderDetails.getId());

            // Bước 3: thực thi câu lệnh SQL
            System.out.println(sql);
            ketQua = st.executeUpdate();

            // Bước 4:
            System.out.println("Bạn đã thực thi: "+ sql);
            System.out.println("Có "+ ketQua+" dòng bị thay đổi!");

            // Bước 5:
            JDBCUtil.closeConnection(con);
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return ketQua;
    }

    @Override
    public int update(OrderDetails orderDetails) {

        int ketQua = 0;
        try {
            // Bước 1: tạo kết nối đến CSDL
            Connection con = JDBCUtil.getConnection();

            // Bước 2: tạo ra đối tượng statement
            String sql = "UPDATE orders "+
                    " SET " +
                    " order_id=?"+
                    " product_id=?"+
                    " quantity=?"+
                    " price=?"+
                    " discount=?"+
                    " amount=?"+
                    " WHERE id=?";
            PreparedStatement st = con.prepareStatement(sql);

            st.setString(1, orderDetails.getOrder().getId());
            st.setString(2, orderDetails.getProduct().getId());
            st.setInt(3, orderDetails.getQuantity());
            st.setDouble(4, orderDetails.getPrice());
            st.setDouble(5, orderDetails.getDiscount());
            st.setDouble(6, orderDetails.getAmount());
            st.setString(7, orderDetails.getId());


            // Bước 3: thực thi câu lệnh SQL

            System.out.println(sql);
            ketQua = st.executeUpdate();

            // Bước 4:
            System.out.println("Bạn đã thực thi: "+ sql);
            System.out.println("Có "+ ketQua+" dòng bị thay đổi!");

            // Bước 5:
            JDBCUtil.closeConnection(con);
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return ketQua;
    }
    public int countSoldProductsInThisMonth() {
        int count = 0;
        try {
            // Bước 1: tạo kết nối đến CSDL
            Connection con = JDBCUtil.getConnection();

            // Bước 2: tạo ra đối tượng statement
            String sql = "SELECT SUM(order_details.quantity) as product_count " +
                    "FROM order_details " +
                    "JOIN orders ON order_details.order_id = orders.id " +
                    "WHERE MONTH(orders.order_date) = MONTH(CURRENT_DATE()) " +
                    "AND YEAR(orders.order_date) = YEAR(CURRENT_DATE())";

            PreparedStatement st = con.prepareStatement(sql);

            // Bước 3: thực thi câu lệnh SQL và lấy kết quả
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                count = rs.getInt("product_count");
            }

            // Bước 4: Đóng kết nối
            JDBCUtil.closeConnection(con);
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return count;
    }

    public double calculateRevenueInThisMonth() {
        double revenue = 0.0;
        try {
            // Bước 1: tạo kết nối đến CSDL
            Connection con = JDBCUtil.getConnection();

            // Bước 2: tạo ra đối tượng statement
            String sql = "SELECT SUM(amount) as total_revenue " +
                    "FROM order_details " +
                    "JOIN orders ON order_details.order_id = orders.id " +
                    "WHERE MONTH(orders.order_date) = MONTH(CURRENT_DATE()) " +
                    "AND YEAR(orders.order_date) = YEAR(CURRENT_DATE())";

            PreparedStatement st = con.prepareStatement(sql);

            // Bước 3: thực thi câu lệnh SQL và lấy kết quả
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                revenue = rs.getDouble("total_revenue");
            }

            // Bước 4: Đóng kết nối
            JDBCUtil.closeConnection(con);
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return revenue;
    }

    public static double calculateAmount(String orderId) {
        double amount = 0;
        try {
            // Bước 1: tạo kết nối đến CSDL
            Connection con = JDBCUtil.getConnection();

            // Bước 2: tạo ra câu lệnh SQL
            String sql = "SELECT SUM(quantity * price) AS total_amount FROM order_details WHERE order_id = ?";
            PreparedStatement st = con.prepareStatement(sql);
            st.setString(1, orderId);

            // Bước 3: thực thi câu lệnh SQL
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                amount = rs.getDouble("total_amount");
            }

            // Bước 4: đóng kết nối
            JDBCUtil.closeConnection(con);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return amount;
    }

    public static void main(String[] args) {
        OrderDetailsDAO odd = new OrderDetailsDAO();
        System.out.println(odd.selectByIdOrder("or_1"));

    }

    public List<OrderDetails> selectByIdOrder(String orderId) {
        return JDBIConector.me().withHandle(handle ->
                handle.createQuery("SELECT od.id, od.order_id, od.product_id, od.quantity, od.price, od.discount, od.amount, " +
                                "p.name AS product_name, p.price AS product_price, p.product_type_id, p.quantity AS product_quantity, " +
                                "p.producer_id, p.image AS product_image, " +
                                "o.user_id, o.delivery_address, o.order_status, o.payment_method, o.order_date, o.delivery_date, o.amount AS order_amount " +
                                "FROM order_details od " +
                                "JOIN products p ON od.product_id = p.id " +
                                "JOIN orders o ON od.order_id = o.id " +
                                "WHERE od.order_id = :orderId")
                        .bind("orderId", orderId)
                        .map((rs, ctx) -> {
                            // Mapping OrderDetails fields


                            // Mapping Product fields
                            ProductType productType = new ProductType();
                            productType.setId(rs.getString("product_type_id"));

                            Producer producer = new Producer();
                            producer.setId(rs.getString("producer_id"));

                            Product product = new Product();
                            product.setId(rs.getString("product_id"));
                            product.setName(rs.getString("product_name"));
                            product.setPrice(rs.getDouble("product_price"));
                            product.setProductType(productType);
                            product.setQuantity(rs.getInt("product_quantity"));
                            product.setProducer(producer);
                            product.setImg(rs.getString("product_image"));



                            // Mapping Order fields
                            User user = new dao.UserDAO().selectById(new User(rs.getString("user_id"), null, null, null, null, null, null, null, null, null));

                            Order order = new Order();
                            order.setId(rs.getString("order_id"));
                            order.setUser(user);
                            order.setAddress(rs.getString("delivery_address"));
                            order.setStatus(rs.getString("order_status"));
                            order.setPayMent(rs.getString("payment_method"));
                            order.setOrderDate(rs.getDate("order_date"));
                            order.setDeliveryDate(rs.getDate("delivery_date"));
                            order.setAmount(rs.getDouble("order_amount"));

                            OrderDetails orderDetails = new OrderDetails();
                            orderDetails.setId(rs.getString("id"));
                            orderDetails.setOrder(order);
                            orderDetails.setQuantity(rs.getInt("quantity"));
                            orderDetails.setPrice(rs.getDouble("price"));
                            orderDetails.setDiscount(rs.getDouble("discount"));
                            orderDetails.setAmount(rs.getDouble("amount"));
                            orderDetails.setOrder(order);

                            orderDetails.setProduct(product);
                            return orderDetails;
                        })
                        .list()
        );
    }

}