package controller;

import model.Product;
import service.impl.ProductServiceImpl;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet(name = "SearchController", value = "/productList")
public class SearchController extends HttpServlet {

    private ProductServiceImpl productService = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");  // Lấy id nếu có
        String query = request.getParameter("query");  // Lấy từ khóa tìm kiếm nếu có

        List<Product> productList = null;
        String message = null;

        if (id != null && !id.isEmpty()) {
            // Nếu có id, lấy sản phẩm theo id và tạo danh sách chứa duy nhất sản phẩm đó
            Product product = productService.findProductById(Integer.parseInt(id));
            if (product == null) {
                message = "Không tìm thấy sản phẩm!";
            }
            productList = List.of(product);  // Tạo danh sách chứa duy nhất sản phẩm này
            request.setAttribute("isDetail", true);  // Flag để JSP biết hiển thị chi tiết
        } else if (query != null && !query.trim().isEmpty()) {
            productList = productService.findByName(query);
            if (productList == null || productList.isEmpty()) {
                message = "Không tìm thấy sản phẩm nào với từ khóa '" + query + "'. Vui lòng thử lại.";
            }
            request.setAttribute("isDetail", false);  // Flag để JSP biết hiển thị danh sách
        } else {
            // Nếu không có id và query, lấy tất cả sản phẩm
            productList = productService.findAll();
            request.setAttribute("isDetail", false);  // Flag để JSP biết hiển thị danh sách
        }

        request.setAttribute("productList", productList);  // Lưu danh sách sản phẩm vào request
        request.setAttribute("message", message);  // Lưu thông báo lỗi vào request
        request.getRequestDispatcher("/danhmucsanpham.jsp").forward(request, response);  // Chuyển hướng đến trang danh mục sản phẩm
    }


}
