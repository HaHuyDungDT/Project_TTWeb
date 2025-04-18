package model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.sql.Timestamp;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CouponUsage {
    private Integer id;
    private Integer couponId;
    private Integer userId; // nếu coupon được áp dụng bởi khách hàng cụ thể, null nếu không cần theo dõi
    private Timestamp usedAt;
}