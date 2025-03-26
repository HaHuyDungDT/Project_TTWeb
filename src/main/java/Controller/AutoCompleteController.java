package Controller;


import com.google.gson.Gson;
import dao.ProductDAO;
import model.Product;

import java.io.IOException;
import java.util.List;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletException;

@WebServlet(name = "AutoCompleteController", value = "/autocomplete")
public class AutoCompleteController extends HttpServlet {

    private ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String query = request.getParameter("query");  // Lấy từ khóa tìm kiếm từ query string

        // Thiết lập mã hóa UTF-8 cho response để đảm bảo không bị lỗi ký tự
        response.setContentType("application/json; charset=UTF-8");

        if (query != null && !query.trim().isEmpty()) {
            try {
                // Tìm kiếm sản phẩm từ cơ sở dữ liệu
                List<Product> productList = productDAO.searchByName(query);  // Gọi phương thức searchByName trong ProductDAO

                if (productList != null && !productList.isEmpty()) {
                    // Chuyển danh sách sản phẩm thành JSON
                    String jsonResponse = new Gson().toJson(productList);
                    response.getWriter().write(jsonResponse);  // Trả về JSON cho frontend
                } else {
                    // Nếu không có kết quả, trả về mảng rỗng
                    response.getWriter().write("[]");
                }
            } catch (Exception e) {
                // Nếu có lỗi trong quá trình tìm kiếm, trả về lỗi cho frontend
                response.getWriter().write("{\"error\":\"Không thể lấy dữ liệu\"}");
                e.printStackTrace();  // Ghi log lỗi ra console để dễ dàng debug
            }
        } else {
            // Trả về mảng rỗng nếu không có query
            response.getWriter().write("[]");
        }
    }
}