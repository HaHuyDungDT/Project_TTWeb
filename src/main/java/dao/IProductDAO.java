package dao;

import model.Product;

import java.util.List;

public interface IProductDAO {
    boolean addProduct(Product product);
    boolean updateProduct(Product product);
    boolean deleteById(Integer idProduct);
    List<Product> findAll();
    Product findById(Integer id);
    List<Product> findByName(String name);
    List<Product> findByCategory(Integer categoryId);
    List<Product> findByProducer(Integer producerId);
    List<Product> findNewProduct();
    List<Product> findSaleProduct();
    List<Product> findProductIsSelling();
    List<Product> getPaging(int index);
    List<Product> findProductToImport();
    List<Product> findBestSeller();
    List<Product> findProductInStock();
}
