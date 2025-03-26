package model;

public class Sale_Product {
    private String id;
    private Product product;

    private double discount;

    public Sale_Product() {
    }

    public Sale_Product(String id, Product product, double discount) {
        this.id = id;
        this.product = product;
        this.discount = discount;
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

    public double getDiscount() {
        return discount;
    }

    public void setDiscount(double discount) {
        this.discount = discount;
    }

    @Override
    public String toString() {
        return "Sale_Product{" +
                "id='" + id + '\'' +
                ", product=" + product +
                ", discount=" + discount +
                '}';
    }
}
