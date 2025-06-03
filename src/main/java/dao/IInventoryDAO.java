package dao;

import model.Inventory;
import java.util.List;

public interface IInventoryDAO {
    List<Inventory> findAll();
    Inventory findByProductId(int productId);
    void updateQuantity(int productId, int newQuantity);
    void insertInventory(Inventory inventory);
    void deleteByProductId(int productId);
}
