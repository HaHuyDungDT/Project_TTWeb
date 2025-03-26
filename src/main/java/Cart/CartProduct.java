package Cart;

import model.Product;

public class CartProduct {
    private int quantity;
    private Product product;

    public CartProduct() {
    }

    public CartProduct(int quantity, Product product) {
        this.quantity = quantity;
        this.product = product;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public void intcreQuantity(int quantity) {
        this.quantity += quantity;
    }

    public void decreQuantity(int quantity) {
        this.quantity -= quantity;
        if(this.quantity<=0) this.quantity+= quantity;
    }


    @Override
    public String toString() {
        return "CartProduct{" +
                "quantity=" + quantity +
                ", product=" + product +
                '}';
    }
<<<<<<< HEAD
}
=======
}
>>>>>>> 445a502 (Tạm lưu các thay đổi trên main)
