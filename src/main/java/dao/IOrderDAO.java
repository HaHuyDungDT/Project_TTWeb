package dao;

import model.Order;
import model.OrderDetails;

import java.util.List;

public interface IOrderDAO {
    int addOrder(Order order);
    List<Order> getOrdersByUserId(Integer userId);
    List<Order> findAll();
    Order findById(Integer id);
    boolean updateOrder(Order order);
    boolean deleteOrder(Integer idOrder);

    List<OrderDetails> getDetailsByOrderId(int orderId);
}
