package dao;

import model.OrderDetails;

import java.util.List;

public interface IOrderDetailDAO {
    List<OrderDetails> findAll();
    OrderDetails findById(Integer id);
    List<OrderDetails> findByIdOrder(Integer idOrder);
    boolean addOrderDetails(OrderDetails orderDetails);
    boolean updateOrderDetails(OrderDetails orderDetails);
    boolean deleteOrder(Integer idOrderDetails);
    List<OrderDetails> findByOrderId(Integer orderId);

}
