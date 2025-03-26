package dao;

import model.Product;
import model.Sale_Product;
import db.JDBIConector;

import java.util.ArrayList;
import java.util.List;

public class SaleProductDAO implements DAOInterface{
    @Override
    public List<Sale_Product> selectAll() {
        List<Sale_Product> ketQua = JDBIConector.me().withHandle((handle -> {
            List<Sale_Product> sale_products = new ArrayList<>();
            handle.createQuery("SELECT id, product_id,discount FROM sale_products")
                    .map((rs, ctx) -> {
                        String id = rs.getString("id");
                        String product_id = rs.getString(("product_id"));
                        double discount = rs.getDouble("discount");

                        Product product = dao.ProductDAO.getById(Integer.valueOf(product_id));
                        Sale_Product saleProduct = new Sale_Product(id, product, discount);
                        sale_products.add(saleProduct);

                        return null;
                    }).list();
            return sale_products;
        }));
        return ketQua;
    }
    public static void main(String[] args) {
        SaleProductDAO saleProductDAO = new SaleProductDAO();
        System.out.println(saleProductDAO.selectAll());
    }

    @Override
    public Object selectById(Object o) {
        return null;
    }

    @Override
    public int insert(Object o) {
        return 0;
    }

    @Override
    public int delete(Object o) {
        return 0;
    }

    @Override
    public int update(Object o) {
        return 0;
    }
}
