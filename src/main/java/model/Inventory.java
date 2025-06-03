package model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.annotation.Nullable;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Inventory {
    private int id;
    private int productId;
    private int quantity;
    @Nullable
    private String productName;
    @Nullable
    private String productImage;
}
