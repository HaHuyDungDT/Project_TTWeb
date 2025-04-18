package model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Order {
    private Integer id;
    private User user;
    private String address;
    private String phone_number;
    private String status;
    private String note;
    private String payment_method;
    private LocalDateTime orderDate;
    private LocalDateTime deliveryDate;
    private Double totalPrice;
    // Thêm thông tin coupon. Nếu có model Coupon thì dùng kiểu Coupon, nếu không thì có thể dùng Integer couponId
    private Coupon coupon;
}