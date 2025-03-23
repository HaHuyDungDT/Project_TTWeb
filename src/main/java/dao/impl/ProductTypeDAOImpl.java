package dao.impl;

import dao.IProductTypeDAO;
import db.JDBIConnector;
import model.ProductType;

import java.util.List;

public class ProductTypeDAOImpl implements IProductTypeDAO {

    @Override
    public List<ProductType> findAll() {
        List<ProductType> productTypes = JDBIConnector.getConnect().withHandle(handle -> {
            return handle.createQuery("SELECT id, name, code FROM product_types")
                    .mapToBean(ProductType.class)
                    .list();
        });
        return productTypes;
    }

    public static void main(String[] args) {
        IProductTypeDAO productTypeDAO = new ProductTypeDAOImpl();
        List<ProductType> productTypes = productTypeDAO.findAll();
        for (ProductType productType : productTypes) {
            System.out.println(productType);
        }
    }

    @Override
    public ProductType findById(int id) {
        ProductType productType = JDBIConnector.getConnect().withHandle(handle -> {
            return handle.select("SELECT id, name, code FROM product_types WHERE id = :id")
                    .bind("id", id)
                    .mapToBean(ProductType.class)
                    .findFirst()
                    .orElse(null);
        });
        return productType;
    }

    @Override
    public boolean save(ProductType productType) {
        int rowsAffected = JDBIConnector.getConnect().withHandle(handle -> {
            return handle.createUpdate("INSERT INTO product_type (name, code) VALUES (:name, :code)")
                    .bind("name", productType.getName())
                    .bind("code", productType.getCode())
                    .execute();
        });
        return rowsAffected > 0;
    }

    @Override
    public boolean update(ProductType productType) {
        int rowsAffected = JDBIConnector.getConnect().withHandle(handle -> {
            return handle.createUpdate("UPDATE product_type SET name = :name, code = :code WHERE id = :id")
                    .bind("name", productType.getName())
                    .bind("code", productType.getCode())
                    .execute();
        });
        return rowsAffected > 0;
    }

    @Override
    public boolean delete(Integer productTypeId) {
        int rowsAffected = JDBIConnector.getConnect().withHandle(handle -> {
            return handle.createUpdate("Delete from product_type WHERE id = :id")
                    .bind("id", productTypeId)
                    .execute();
        });
        return rowsAffected > 0;
    }

}
