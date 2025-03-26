package model;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductType {
    private Integer id;
    private String name;
    private String code;

    public ProductType(int productTypeId, Object o) {
    }
}
