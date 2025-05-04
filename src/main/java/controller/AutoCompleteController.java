package controller;

import com.google.gson.Gson;
import dao.impl.ProductDAOImpl;
import model.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/autocomplete")
public class AutoCompleteController extends HttpServlet {
    private ProductDAOImpl productDAO = new ProductDAOImpl();  // Tạo đối tượng DAO để gọi phương thức tìm kiếm

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy từ khóa tìm kiếm từ tham số query
        String query = request.getParameter("query");

        // Thiết lập mã hóa UTF-8 cho response
        response.setContentType("application/json; charset=UTF-8");

        if (query != null && !query.trim().isEmpty()) {
            try {
                // Tìm kiếm sản phẩm dựa trên gợi ý (auto-complete)
                List<Product> productList = productDAO.findByName(query);

                // Chuyển danh sách sản phẩm thành JSON và trả về
                String jsonResponse = new Gson().toJson(productList);
                response.getWriter().write(jsonResponse);
            } catch (Exception e) {
                // Nếu có lỗi trong quá trình tìm kiếm
                response.getWriter().write("{\"error\":\"Không thể lấy dữ liệu\"}");
                e.printStackTrace();
            }
        } else {
            // Trả về mảng rỗng nếu không có từ khóa tìm kiếm
            response.getWriter().write("[]");
        }
    }
}
