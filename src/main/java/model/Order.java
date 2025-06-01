package model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.annotation.Nullable;
import java.sql.Date;
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
    @Nullable
    private LocalDateTime deliveryDate;
    private Double totalPrice;
}