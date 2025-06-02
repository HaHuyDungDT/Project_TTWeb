package dao;

import model.Order;
import model.OrderDetails;

import java.util.List;

public interface IOrderDAO {
    List<Order> findAll();
    Order findById(Integer id);
    int addOrder(Order order);
    boolean updateOrder(Order order);
    boolean deleteOrder(Integer idOrder);

    List<OrderDetails> getDetailsByOrderId(int orderId);
}
