package dao;

import model.New_Product;
import model.Product;
import db.JDBIConector;

import java.util.ArrayList;
import java.util.List;

public class NewProductDAO implements DAOInterface<New_Product> {
    @Override
    public List<New_Product> selectAll() {
        List<New_Product> ketQua = JDBIConector.me().withHandle((handle -> {
            List<New_Product> newProductDAOS = new ArrayList<>();
            handle.createQuery("SELECT id, product_id FROM new_products")
                    .map((rs, ctx) -> {
                        String id = rs.getString("id");
                        String product_id = rs.getString(("product_id"));

                        Product product = ProductDAO.getById(product_id);
                        New_Product newProduct = new New_Product(id, product);
                        newProductDAOS.add(newProduct);

                        return null;
                    }).list();
            return newProductDAOS;
        }));
        return ketQua;
    }

    @Override
    public New_Product selectById(New_Product newProduct) {
        return null;
    }

    @Override
    public int insert(New_Product newProduct) {
        return 0;
    }

    @Override
    public int delete(New_Product newProduct) {
        return 0;
    }

    @Override
    public int update(New_Product newProduct) {
        return 0;
    }

    public static void main(String[] args) {
        NewProductDAO ne = new NewProductDAO();
        System.out.println(ne.selectAll());
    }
}
