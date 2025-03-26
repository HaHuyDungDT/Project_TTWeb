package model;

public class ProductDetails {
    private String id;
    private Product product;

    private String description;
    private int quantity;

    public ProductDetails() {

    }

    public ProductDetails(String id, Product product, String description, int quantity) {
        this.id = id;
        this.product = product;
        this.description = description;
        this.quantity = quantity;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    @Override
    public String toString() {
        return "ProductDetails{" +
                "id='" + id + '\'' +
                ", product=" + product +
                ", description='" + description + '\'' +
                ", quantity=" + quantity +
                '}';
    }
}
