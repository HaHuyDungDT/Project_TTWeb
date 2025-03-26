package dao;

import db.JDBIConector;
import model.Order;
import model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class OrderDAO {
    public List<Order> selectAll() {
        return JDBIConector.me().withHandle(handle ->
                handle.createQuery("SELECT id, user_id, address, status, note, payment_method, order_date, delivery_date, total_price FROM orders")
                        .map((rs, ctx) -> {
                            int id = rs.getInt("id");
                            int userId = rs.getInt("user_id");
                            String address = rs.getString("address");
                            String status = rs.getString("status");
                            String note = rs.getString("note");
                            String paymentMethod = rs.getString("payment_method");
                            Date orderDate = rs.getDate("order_date");
                            Date deliveryDate = rs.getDate("delivery_date");
                            Double totalPrice = rs.getDouble("total_price");

                            User user = new UserDAO().selectById(userId); // chỉ cần id, hàm DAO nhận Integer

                            return new Order(
                                    String.valueOf(id),
                                    user,
                                    address,
                                    status,
                                    note,
                                    paymentMethod,
                                    orderDate,
                                    deliveryDate,
                                    totalPrice
                            );
                        })
                        .list()
        );
    }


    public int insert(Order order) {
        int ketQua = 0;
        try {
            // Bước 1: tạo kết nối đến CSDL
            Connection con = JDBCUtil.getConnection();

            // Bước 2: tạo ra đối tượng statement
            String sql = "INSERT INTO orders (user_id, address, status, note, payment_method, order_date, delivery_date, total_price) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement st = con.prepareStatement(sql);

            if (order.getUser() != null) {
                st.setInt(1, Integer.parseInt(order.getUser().getId()));
            } else {
                st.setNull(1, Types.INTEGER);
            }

            st.setString(2, order.getAddress());
            st.setString(3, order.getStatus());
            st.setString(4, order.getNote());
            st.setString(5, order.getPayment_method());
            st.setDate(6, order.getOrderDate());
            st.setDate(7, order.getDeliveryDate());
            st.setDouble(8, order.getTotalPrice());

            // Bước 3: thực thi câu lệnh SQL
            ketQua = st.executeUpdate();

            // Bước 4:
            System.out.println("Bạn đã thực thi: " + sql);
            System.out.println("Có " + ketQua + " dòng bị thay đổi!");

            // Bước 5:
            JDBCUtil.closeConnection(con);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return ketQua;
    }

}
