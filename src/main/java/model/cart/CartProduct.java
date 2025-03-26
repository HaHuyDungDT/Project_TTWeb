package model.cart;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import model.Product;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CartProduct {
    private int quantity;
    private Product product;

    public void increaseQuantity(int quantity) {
        this.quantity += quantity;
    }

    public void decreaseQuantity(int quantity) {
        this.quantity -= quantity;
        if (this.quantity <= 0) {
            this.quantity += quantity;
        }
    }

}
