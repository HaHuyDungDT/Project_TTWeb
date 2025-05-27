package dao.impl;

import dao.IProductTypeDAO;
import db.JDBIConnector;
import model.ProductType;

import java.util.List;

public class ProductTypeDAOImpl implements IProductTypeDAO {

    @Override
    public List<ProductType> findAll() {
        return JDBIConnector.getConnect().withHandle(h ->
                h.createQuery("SELECT id, name, code FROM product_types WHERE active = 1")
                        .mapToBean(ProductType.class)
                        .list()
        );
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
        return JDBIConnector.getConnect().withHandle(h ->
                h.createQuery("SELECT id, name, code FROM product_types WHERE id = :id AND active = 1")
                        .bind("id", id)
                        .mapToBean(ProductType.class)
                        .findFirst()
                        .orElse(null)
        );
    }

    @Override
    public boolean save(ProductType productType) {
        int rowsAffected = JDBIConnector.getConnect().withHandle(handle -> {
            return handle.createUpdate(
                            "INSERT INTO product_types (name, code) VALUES (:name, :code)")
                    .bind("name", productType.getName())
                    .bind("code", productType.getCode())
                    .execute();
        });
        return rowsAffected > 0;
    }

    @Override
    public boolean update(ProductType productType) {
        int rowsAffected = JDBIConnector.getConnect().withHandle(handle -> {
            return handle.createUpdate(
                            "UPDATE product_types SET name = :name, code = :code WHERE id = :id")
                    .bind("name", productType.getName())
                    .bind("code", productType.getCode())
                    .bind("id", productType.getId())
                    .execute();
        });
        return rowsAffected > 0;
    }

    @Override
    public boolean delete(Integer productTypeId) {
        // chuyển về inactive thay vì xoá
        int rows = JDBIConnector.getConnect().withHandle(h ->
                h.createUpdate("UPDATE product_types SET active = 0 WHERE id = :id")
                        .bind("id", productTypeId)
                        .execute()
        );
        return rows > 0;
    }

    @Override
    public List<ProductType> search(String keyword) {
        return JDBIConnector.getConnect().withHandle(h ->
                h.createQuery(
                                "SELECT id,name,code FROM product_types " +
                                        "WHERE active = 1 AND (name LIKE :kw OR code LIKE :kw)")
                        .bind("kw","%"+keyword+"%")
                        .mapToBean(ProductType.class)
                        .list()
        );
    }

    public int count() {
        return JDBIConnector.getConnect().withHandle(h ->
                h.createQuery("SELECT COUNT(*) FROM product_types WHERE active = 1")
                        .mapTo(int.class).findOnly()
        );
    }

    /**
     * Lấy danh mục theo trang: offset = (page-1)*pageSize, limit = pageSize
     */
    public List<ProductType> findByPage(int offset, int limit) {
        return JDBIConnector.getConnect().withHandle(h ->
                h.createQuery(
                                "SELECT id, name, code FROM product_types " +
                                        "WHERE active = 1 LIMIT :offset, :limit")
                        .bind("offset", offset).bind("limit", limit)
                        .mapToBean(ProductType.class)
                        .list()
        );
    }


}
