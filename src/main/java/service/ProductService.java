package service;

import model.Product;
import dao.ProductDAO;

import java.util.List;

public class ProductService {
    private static ProductService instance;

    public static ProductService getInstance() {
        if (instance == null) instance = new ProductService();
        return instance;
    }

    public List<Product> getAll() {
        return ProductDAO.getAll();
    }

    public Product getById(String add) {
        return ProductDAO.getById(add);
    }

    public static void main(String[] args) {
        System.out.println(ProductService.getInstance().getAll());
    }
}


