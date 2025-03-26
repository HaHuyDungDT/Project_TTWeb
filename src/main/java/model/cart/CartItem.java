package model.cart;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import model.Product;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CartItem {
    private String id;
    private Integer cartId;
    private Integer productId;
    private Integer quantity;
}
