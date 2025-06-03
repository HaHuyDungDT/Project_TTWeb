package dao.impl;

import dao.IInventoryDAO;
import model.Inventory;
import db.JDBIConnector;

import java.util.List;

public class InventoryDAOImpl implements IInventoryDAO {

    @Override
    public List<Inventory> findAll() {
        return JDBIConnector.getConnect().withHandle(handle ->
                handle.createQuery("SELECT * FROM inventory")
                        .mapToBean(Inventory.class)
                        .list()
        );
    }

    @Override
    public Inventory findByProductId(int productId) {
        return JDBIConnector.getConnect().withHandle(handle ->
                handle.createQuery("SELECT * FROM inventory WHERE product_id = :productId")
                        .bind("productId", productId)
                        .mapToBean(Inventory.class)
                        .findFirst()
                        .orElse(null)
        );
    }

    @Override
    public void updateQuantity(int productId, int newQuantity) {
        JDBIConnector.getConnect().useHandle(handle ->
                handle.createUpdate("UPDATE inventory SET quantity = :qty WHERE product_id = :productId")
                        .bind("qty", newQuantity)
                        .bind("productId", productId)
                        .execute()
        );
    }

    @Override
    public void insertInventory(Inventory inventory) {
        JDBIConnector.getConnect().useHandle(handle ->
                handle.createUpdate("INSERT INTO inventory (product_id, quantity) VALUES (:productId, :quantity)")
                        .bind("productId", inventory.getProductId())
                        .bind("quantity", inventory.getQuantity())
                        .execute()
        );
    }

    @Override
    public void deleteByProductId(int productId) {
        JDBIConnector.getConnect().useHandle(handle ->
                handle.createUpdate("DELETE FROM inventory WHERE product_id = :productId")
                        .bind("productId", productId)
                        .execute()
        );
    }
}
