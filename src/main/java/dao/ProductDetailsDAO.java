package dao;

import model.Product;
import model.ProductDetails;
import db.JDBIConector;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;
import java.util.Optional;

public class ProductDetailsDAO implements DAOInterface<ProductDetails>{

    @Override
    public List<ProductDetails> selectAll() {
        return null;
    }

    @Override
    public ProductDetails selectById(ProductDetails productDetails) {
        return null;
    }

    @Override
    public int insert(ProductDetails productDetails) {
        int ketQua = 0;
        try {
            // Bước 1: tạo kết nối đến CSDL
            Connection con = JDBCUtil.getConnection();

            // Bước 2: tạo ra đối tượng statement
            String sql = "INSERT INTO product_details(id, product_id, content, quantity)" +
                    "VALUES (?, ?, ?, ?)";

            PreparedStatement st = con.prepareStatement(sql);
            st.setString(1, productDetails.getId());
            st.setString(2, productDetails.getProduct().getId());
            st.setString(4, productDetails.getDescription());
            st.setInt(3, productDetails.getQuantity());

            ketQua = st.executeUpdate();

            // Bước 3: thực thi câu lệnh SQL
            System.out.println("Bạn đã thực thi: " + sql);
            System.out.println("Có " + ketQua + " dòng bị thay đổi!");

            JDBCUtil.closeConnection(con);
        }catch(SQLException e){
            e.printStackTrace();
        }
        return ketQua;
    }

    @Override
    public int delete(ProductDetails productDetails) {
        int ketQua = 0;
        try {
            // Bước 1: tạo kết nối đến CSDL
            Connection con = JDBCUtil.getConnection();

            // Bước 2: tạo ra đối tượng statement
            String sql = "DELETE from product_details " +
                    " WHERE id=?";

            PreparedStatement st = con.prepareStatement(sql);
            st.setString(1, productDetails.getId());

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
    public int update(ProductDetails productDetails) {
        int ketQua = 0;
        try {
            // Bước 1: tạo kết nối đến CSDL
            Connection con = JDBCUtil.getConnection();

            // Bước 2: tạo ra đối tượng statement
            String sql = "UPDATE product_details " +
                    " SET " +
                    " id=?" + "," +
                    " product_id=?" + "," +
                    " content=?" + "," +
                    " quantitt=?" +
                    " WHERE id=?";

            PreparedStatement st = con.prepareStatement(sql);
            st.setString(1, productDetails.getId());
            st.setString(2, productDetails.getProduct().getId());
            st.setString(4, productDetails.getDescription());
            st.setInt(3, productDetails.getQuantity());

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

    public ProductDetails getProductDetail(Product product){
        Optional<ProductDetails> productDetails = JDBIConector.me().withHandle((handle ->
                handle.createQuery("SELECT pd.id, pd.product_id, pd.content, pd.quantity " +
                                        "FROM product_details pd " +
                                        "JOIN products p ON pd.product_id = p.id " +
                                        "WHERE p.id = ?")
                        .bind(0, product.getId())
                        .map((rs, ctx) -> {
                            String id = rs.getString("id");
                            String content = rs.getString("content");
                            int quantity = rs.getInt("quantity");
                            String product_id = rs.getString("product_id");
                            Product p = dao.ProductDAO.getById(product_id);

                            ProductDetails productDl = new ProductDetails(id, p, content, quantity);
                            return productDl;
                        }).stream().findFirst()
        ));
        return productDetails.isEmpty() ? null : productDetails.get();
    };

    public static void main(String[] args) {
        ProductDetailsDAO pdd = new ProductDetailsDAO();
        Product p = new Product("1", null, 0, null, 0, null, null);
        System.out.println(pdd.getProductDetail(p));
    }
}
