
package service.impl;

import dao.ProductDAO;
import model.Product;
import model.Product;
import service.ProductService;

import java.util.List;

public class ProductServiceImpl extends ProductService {

    private ProductDAO productDAO = new ProductDAO();

    // Phương thức tìm kiếm sản phẩm theo tên
    public List<Product> searchByName(String query) {
        return productDAO.searchByName(query);
    }

    // Phương thức lấy thông tin sản phẩm theo ID
    public Product getProductById(String productId) {
        // Gọi phương thức getById trong ProductDAO để lấy thông tin sản phẩm
        return productDAO.getById(productId);
    }

    // Phương thức lấy tất cả sản phẩm
    public List<Product> getAllProducts() {
        return productDAO.selectAll();  // Gọi phương thức selectAll() trong ProductDAO để lấy tất cả sản phẩm
    }

}
