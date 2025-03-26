package dao;

import db.JDBIConector;
import model.ProductType;

import java.util.Optional;

public class ProductTypeDAO {

    public static ProductType getById(Integer id) {
        Optional<ProductType> productType = JDBIConector.me().withHandle(handle ->
                handle.createQuery("SELECT id, name, code FROM product_types WHERE id = :id")
                        .bind("id", id)
                        .map((rs, ctx) -> new ProductType(
                                rs.getInt("id"),
                                rs.getString("name"),
                                rs.getString("code")
                        ))
                        .findFirst()
        );

        return productType.orElse(null);
    }

    public ProductType selectById(ProductType productType) {
        if (productType == null || productType.getId() == null) {
            return null;
        }
        return getById(productType.getId());
    }

}