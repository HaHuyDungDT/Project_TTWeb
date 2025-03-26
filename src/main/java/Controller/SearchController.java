package Controller;

import model.Product;
import model.Product;
import service.impl.ProductServiceImpl;

import java.io.IOException;
import java.util.List;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletException;

@WebServlet(name = "SearchController", value = "/productList")
public class SearchController extends HttpServlet {

    private ProductServiceImpl productService = new ProductServiceImpl();  // Khởi tạo service

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String query = request.getParameter("query");  // Lấy từ khóa tìm kiếm
        String productId = request.getParameter("productId");  // Lấy id sản phẩm nếu người dùng click vào gợi ý

        List<Product> productList = null;
        String message = null;  // Biến thông báo lỗi

        if (productId != null && !productId.isEmpty()) {
            // Nếu người dùng click vào sản phẩm, chỉ hiển thị sản phẩm đó
            productList = List.of(productService.getProductById(productId));  // Lấy sản phẩm theo id
        } else if (query != null && !query.trim().isEmpty()) {
            // Nếu người dùng tìm kiếm, gọi phương thức tương ứng
            productList = productService.searchByName(query);  // Tìm kiếm sản phẩm theo tên

            if (productList == null || productList.isEmpty()) {
                // Nếu không tìm thấy sản phẩm nào với từ khóa, trả về thông báo lỗi
                message = "Không tìm thấy sản phẩm nào với từ khóa '" + query + "'. Vui lòng thử lại với từ khóa khác.";
            }
        } else {
            // Nếu không có từ khóa tìm kiếm, lấy tất cả sản phẩm
            productList = productService.getAllProducts();
        }

        request.setAttribute("productList", productList);  // Lưu kết quả vào request
        request.setAttribute("message", message);  // Lưu thông báo lỗi vào request
        request.getRequestDispatcher("/sanpham.jsp").forward(request, response);  // Chuyển hướng tới trang danh mục sản phẩm
    }
}
