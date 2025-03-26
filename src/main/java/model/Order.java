package model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Date;
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Order {
    private String id;
    private User user;
    private String address;
    private String status;
    private String note;
    private String payment_method;
    private Date orderDate;
    private Date deliveryDate;
    private Double totalPrice;
}