
package dao;
import dao.impl.DAOInterface;
import db.JDBIConector;
import model.Producer;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

public class ProducerDAO implements DAOInterface<Producer> {
    @Override
    public List<Producer> selectAll() {
        List<Producer> producers = JDBIConector.me().withHandle((handle ->
                handle.createQuery("SELECT id, name FROM producers")
                        .mapToBean(Producer.class).stream().collect(Collectors.toList())
        ));
        return producers;
    }

    @Override
    public Producer selectById(Producer producerP) {
        Optional<Producer> producer = JDBIConector.me().withHandle((handle ->
                handle.createQuery("SELECT id, name FROM producers WHERE id=?")
                        .bind(0, producerP.getId())
                        .mapToBean(Producer.class).stream().findFirst()
        ));
        return producer.isEmpty() ? null : producer.get();
    }

    @Override
    public int insert(Producer producer) {
        int ketQua = 0;
        Connection con = null;
        PreparedStatement st = null;

        try {
            // Bước 1: Tạo kết nối đến CSDL
            con = JDBCUtil.getConnection();

            // Bước 2: Tạo câu lệnh SQL (không insert id vì nó auto_increment)
            String sql = "INSERT INTO producers (name, code) VALUES (?, ?)";

            st = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            st.setString(1, producer.getName());
            st.setString(2, producer.getCode());

            // Bước 3: Thực thi câu lệnh SQL
            ketQua = st.executeUpdate();

            // Lấy id tự sinh (optional nhưng khuyến khích)
            ResultSet rs = st.getGeneratedKeys();
            if (rs.next()) {
                int generatedId = rs.getInt(1);
                producer.setId(generatedId);
            }

            // Bước 4: Logging
            System.out.println("Bạn đã thực thi: " + sql);
            System.out.println("Có " + ketQua + " dòng bị thay đổi!");

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Bước 5: Đóng kết nối
            try {
                if (st != null) st.close();
                JDBCUtil.closeConnection(con);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return ketQua;
    }


    @Override
    public int delete(Producer producer) {
        int ketQua = 0;
        try {
            // Bước 1: tạo kết nối đến CSDL
            Connection con = JDBCUtil.getConnection();

            // Bước 2: tạo ra đối tượng statement
            String sql = "DELETE from producers " +
                    " WHERE id=?";

            PreparedStatement st = con.prepareStatement(sql);
            st.setString(1, String.valueOf(producer.getId()));

            // Bước 3: thực thi câu lệnh SQL
            System.out.println(sql);
            ketQua = st.executeUpdate();

            // Bước 4:
            System.out.println("Bạn đã thực thi: " + sql);
            System.out.println("Có " + ketQua + " dòng bị thay đổi!");

            // Bước 5:
            JDBCUtil.closeConnection(con);
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return ketQua;
    }

    @Override
    public int update(Producer producer) {
        int ketQua = 0;
        Connection con = null;
        PreparedStatement st = null;
        try {
            // Bước 1: Tạo kết nối
            con = JDBCUtil.getConnection();

            // Bước 2: Tạo câu lệnh SQL
            String sql = "UPDATE producers SET name = ?, code = ? WHERE id = ?";

            st = con.prepareStatement(sql);
            st.setString(1, producer.getName());
            st.setString(2, producer.getCode());
            st.setInt(3, producer.getId());

            // Bước 3: Thực thi câu lệnh
            ketQua = st.executeUpdate();

            // Bước 4: Logging (optional)
            System.out.println("Bạn đã thực thi: " + sql);
            System.out.println("Có " + ketQua + " dòng bị thay đổi!");

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Đóng PreparedStatement và Connection
            try {
                if (st != null) st.close();
                JDBCUtil.closeConnection(con);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return ketQua;
    }


    public static Producer getById(Integer id) {
        Optional<Producer> producer = JDBIConector.me().withHandle(handle ->
                handle.createQuery("SELECT id, name, code FROM producers WHERE id = :id")
                        .bind("id", id)
                        .map((rs, ctx) -> {
                            Producer pc = new Producer();
                            pc.setId(rs.getInt("id"));
                            pc.setName(rs.getString("name"));
                            pc.setCode(rs.getString("code"));
                            pc.setProducts(new ArrayList<>()); // Tạm thời để trống products
                            return pc;
                        }).findFirst()
        );
        return producer.orElse(null);
    }


    public static void main(String[] args) {
        ProducerDAO pdd = new ProducerDAO();

        // Test getById
        Producer producer = pdd.getById(1); // truyền id hợp lệ (ví dụ: 1)
        System.out.println(producer);

        // Test update (nếu cần)
    /*
    producer.setName("Producer Updated");
    producer.setCode("PRDUP");
    int result = pdd.update(producer);
    System.out.println("Updated rows: " + result);
    */
    }

}
