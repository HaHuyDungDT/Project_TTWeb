package model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Rate {
    private Integer id;
    private Integer star;
    private Integer comment;   // Vì cột `comment` đang để kiểu int
    private Integer productId;
}
