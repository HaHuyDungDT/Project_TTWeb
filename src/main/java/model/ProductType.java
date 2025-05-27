package model;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductType {
    private Integer id;
    private String name;
    private String code;
    private Integer active;    // 1 = active, 0 = soft-deleted

    // nếu cần constructor 3-params (id,name,code) vẫn giữ nguyên
    public ProductType(Integer id, String name, String code) {
        this.id   = id;
        this.name = name;
        this.code = code;
        this.active = 1;
    }
}