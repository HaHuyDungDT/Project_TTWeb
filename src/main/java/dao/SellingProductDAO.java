package dao;

import model.Product;
import model.Selling_Product;
import db.JDBIConector;

import java.util.ArrayList;
import java.util.List;

public class SellingProductDAO implements DAOInterface{
    @Override
    public List<Selling_Product> selectAll() {
        List<Selling_Product> ketQua = JDBIConector.me().withHandle((handle -> {
            List<Selling_Product> selling_products = new ArrayList<>();
            handle.createQuery("SELECT id, product_id FROM new_products")
                    .map((rs, ctx) -> {
                        String id = rs.getString("id");
                        String product_id = rs.getString(("product_id"));

                        Product product = dao.ProductDAO.getById(Integer.valueOf(product_id));
                        Selling_Product sellingProduct = new Selling_Product(id, product);
                        selling_products.add(sellingProduct);

                        return null;
                    }).list();
            return selling_products;
        }));
        return ketQua;
    }


    public static void main(String[] args) {
        SellingProductDAO productDAO = new SellingProductDAO();
        System.out.println(productDAO.selectAll());
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
