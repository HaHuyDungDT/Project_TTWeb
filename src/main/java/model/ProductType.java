package model;

import lombok.*;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductType {
    private Integer id;
    private String name;
    private String code;
}
