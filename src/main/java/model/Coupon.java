package model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.sql.Timestamp;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Coupon {
    private Integer id;
    private String code;
    private String discount_type;         // ENUM('percent', 'fixed')
    private Integer discount_value;       // if percent then the percentage; if fixed then monetary value
    private Double order_minimum;         // minimum order amount
    private Integer total_usage_limit;    // total coupon usage limit
    private Integer per_customer_limit;   // usage limit per customer
    private Timestamp date_start;
    private Timestamp date_end;
    private List<Product> products;
}