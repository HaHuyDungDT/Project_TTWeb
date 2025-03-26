package Controller;

import model.Product;
import com.google.gson.Gson;
import service.impl.ProductServiceImpl;

import java.io.IOException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletException;

@WebServlet(name = "ProductDetailsController", value = "/productDetails")
public class ProductDetailsController extends HttpServlet {

    private ProductServiceImpl productService = new ProductServiceImpl();  // Khởi tạo service

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productId = request.getParameter("id");  // Lấy id sản phẩm từ request

        if (productId != null && !productId.trim().isEmpty()) {
            Product product = productService.getProductById(productId);  // Lấy thông tin sản phẩm từ Service
            if (product != null) {
                String jsonResponse = new Gson().toJson(product);  // Chuyển đối tượng Product thành JSON
                response.setContentType("application/json");
                response.getWriter().write(jsonResponse);  // Trả về JSON cho frontend
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);  // Nếu không tìm thấy sản phẩm
            }
        } else {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);  // Nếu id không hợp lệ
        }
    }
}
