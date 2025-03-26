package dao;

import db.JDBIConector;
import model.Producer;
import model.Product;
import model.ProductType;
import model.Image; // Nếu có dùng
import model.Rate;  // Nếu có dùng

import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

public class ProductDAO {

    // ---------------------------
    // 1) TÌM SẢN PHẨM THEO TÊN
    // ---------------------------
    public static List<Product> searchByName(String text) {
        return JDBIConector.me().withHandle(handle -> {
            List<Product> list = new ArrayList<>();
            String[] keywords = text.split("\\s+"); // Tách các từ trong chuỗi

            // Xây dựng câu truy vấn SQL với nhiều AND name LIKE ...
            StringBuilder queryBuilder = new StringBuilder(
                    "SELECT id, name, price, product_type_id, quantity, producer_id, status, coupon_id, detail, import_date " +
                            "FROM products WHERE"
            );
            for (int i = 0; i < keywords.length; i++) {
                if (i > 0) {
                    queryBuilder.append(" AND");
                }
                queryBuilder.append(" name LIKE :keyword").append(i);
            }

            handle.createQuery(queryBuilder.toString())
                    .bindMap(
                            IntStream.range(0, keywords.length)
                                    .boxed()
                                    .collect(Collectors.toMap(
                                            i -> "keyword" + i,
                                            i -> "%" + keywords[i] + "%"
                                    ))
                    )
                    .map((rs, ctx) -> {
                        // Lấy các cột trong products
                        int productId = rs.getInt("id");
                        String nameProduct = rs.getString("name");
                        double price = rs.getDouble("price");
                        int productTypeId = rs.getInt("product_type_id");
                        int quantity = rs.getInt("quantity");
                        int producerId = rs.getInt("producer_id");
                        String status = rs.getString("status");
                        int couponId = rs.getInt("coupon_id");
                        String detail = rs.getString("detail");
                        Date importDate = rs.getDate("import_date");

                        // Tạo Producer tạm, rồi selectById -> lấy đầy đủ
                        Producer producer = new ProducerDAO()
                                .selectById(new Producer(producerId, null, null, null));

                        // Tạo ProductType tạm, rồi selectById
                        ProductType productType = new ProductTypeDAO()
                                .selectById(new ProductType(productTypeId, null));

                        // Tạo Product khớp với model
                        Product product = new Product(
                                productId,
                                nameProduct,
                                price,
                                productTypeId,
                                productType,
                                quantity,
                                producerId,
                                producer,
                                status,
                                importDate,
                                couponId,
                                detail,
                                null,  // images (nếu cần query thêm)
                                null   // rates  (nếu cần query thêm)
                        );
                        list.add(product);
                        return null;
                    })
                    .list();

            return list;
        });
    }

    // ---------------------------
    // 2) THÊM SẢN PHẨM MỚI
    // ---------------------------
    public int insert(Product product) {
        int ketQua = 0;
        Connection con = null;
        PreparedStatement st = null;
        try {
            // Bước 1: Tạo kết nối
            con = JDBCUtil.getConnection();

            // Bước 2: Câu lệnh SQL
            String sql = "INSERT INTO products " +
                    "(name, price, product_type_id, producer_id, quantity, status, coupon_id, detail, import_date) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

            st = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            st.setString(1, product.getName());
            st.setDouble(2, product.getPrice());
            st.setInt(3, product.getProductTypeID());
            st.setInt(4, product.getProducerID());
            st.setInt(5, product.getQuantity());
            st.setString(6, product.getStatus());
            st.setInt(7, product.getCouponId());
            st.setString(8, product.getDetail());
            st.setDate(9, product.getImport_date() == null ? null
                    : new java.sql.Date(product.getImport_date().getTime()));

            // Bước 3: Thực thi
            ketQua = st.executeUpdate();

            // Lấy ID tự tăng
            ResultSet rs = st.getGeneratedKeys();
            if (rs.next()) {
                product.setId(rs.getInt(1));
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

    // ---------------------------
    // 3) LẤY DS SP BẰNG producer_id
    // ---------------------------
    public ArrayList<Product> selectByIdProducer(String idProducer) {
        ArrayList<Product> ketQua = new ArrayList<>();
        try {
            Connection con = JDBCUtil.getConnection();

            String sql = "SELECT id, name, price, product_type_id, quantity, producer_id, status, import_date, coupon_id, detail " +
                    "FROM products WHERE producer_id = ?";
            PreparedStatement st = con.prepareStatement(sql);
            st.setInt(1, Integer.parseInt(idProducer));

            ResultSet rs = st.executeQuery();

            ProductTypeDAO productTypeDAO = new ProductTypeDAO();
            ProducerDAO producerDAO = new ProducerDAO();
            ImageDAO imageDAO = new ImageDAO(); // Nếu có
            RateDAO rateDAO = new RateDAO();    // Nếu có

            while (rs.next()) {
                Product pro = new Product();
                pro.setId(rs.getInt("id"));
                pro.setName(rs.getString("name"));
                pro.setPrice(rs.getDouble("price"));

                int productTypeId = rs.getInt("product_type_id");
                pro.setProductTypeID(productTypeId);
                pro.setProductType(productTypeDAO.selectById(new ProductType(productTypeId, null)));

                pro.setQuantity(rs.getInt("quantity"));

                int producerId = rs.getInt("producer_id");
                pro.setProducerID(producerId);
                pro.setProducer(producerDAO.selectById(new Producer(producerId, null, null, null)));

                pro.setStatus(rs.getString("status"));
                pro.setImport_date(rs.getDate("import_date"));
                pro.setCouponId(rs.getInt("coupon_id"));
                pro.setDetail(rs.getString("detail"));

                // Lấy hình ảnh và đánh giá (nếu DAO có)
                pro.setImages(imageDAO.selectByProductId(pro.getId()));
                pro.setRates(rateDAO.selectByProductId(pro.getId()));

                ketQua.add(pro);
            }
            JDBCUtil.closeConnection(con);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return ketQua;
    }

    // ---------------------------
    // 4) XÓA SP THEO ID
    // ---------------------------
    public int deleteProductById(String id) {
        int ketQua = 0;
        try {
            Connection con = JDBCUtil.getConnection();
            String sql = "DELETE FROM products WHERE id=?";
            PreparedStatement st = con.prepareStatement(sql);
            st.setString(1, id);

            ketQua = st.executeUpdate();

            System.out.println("Bạn đã thực thi: " + sql);
            System.out.println("Có " + ketQua + " dòng bị thay đổi!");

            JDBCUtil.closeConnection(con);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return ketQua;
    }

    // ---------------------------
    // 5) CẬP NHẬT SP
    // ---------------------------
    public int update(Product product) {
        int ketQua = 0;
        try {
            Connection con = JDBCUtil.getConnection();

            String sql = "UPDATE products " +
                    "SET name=?, price=?, product_type_id=?, quantity=?, producer_id=?, status=?, coupon_id=?, detail=?, import_date=? " +
                    "WHERE id=?";

            PreparedStatement st = con.prepareStatement(sql);
            st.setString(1, product.getName());
            st.setDouble(2, product.getPrice());
            st.setInt(3, product.getProductTypeID());
            st.setInt(4, product.getQuantity());
            st.setInt(5, product.getProducerID());
            st.setString(6, product.getStatus());
            st.setInt(7, product.getCouponId());
            st.setString(8, product.getDetail());
            st.setDate(9, product.getImport_date() == null ? null
                    : new java.sql.Date(product.getImport_date().getTime()));
            st.setInt(10, product.getId());

            ketQua = st.executeUpdate();
            JDBCUtil.closeConnection(con);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return ketQua;
    }

    // ---------------------------
    // 6) LẤY SP THEO ID
    // ---------------------------
    public static Product getById(Integer id) {
        Optional<Product> product = JDBIConector.me().withHandle(handle ->
                handle.createQuery(
                                "SELECT id, name, price, product_type_id, producer_id, quantity, status, coupon_id, detail, import_date " +
                                        "FROM products WHERE id = ?"
                        )
                        .bind(0, id)
                        .map((rs, ctx) -> {
                            String nameProduct = rs.getString("name");
                            double price = rs.getDouble("price");
                            int productType_id = rs.getInt("product_type_id");
                            int producer_id = rs.getInt("producer_id");
                            int quantity = rs.getInt("quantity");
                            String status = rs.getString("status");
                            int couponId = rs.getInt("coupon_id");
                            String detail = rs.getString("detail");
                            Date import_date = rs.getDate("import_date");

                            Producer producer = new ProducerDAO().selectById(new Producer(producer_id, null, null, null));
                            ProductType productType = new ProductTypeDAO().selectById(new ProductType(productType_id, null));

                            return new Product(
                                    id,
                                    nameProduct,
                                    price,
                                    productType_id,
                                    productType,
                                    quantity,
                                    producer_id,
                                    producer,
                                    status,
                                    import_date,
                                    couponId,
                                    detail,
                                    null, // images
                                    null  // rates
                            );
                        })
                        .stream()
                        .findFirst()
        );
        return product.orElse(null);
    }
}
