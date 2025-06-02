package controller;

import com.google.gson.Gson;
import dao.impl.ProductTypeDAOImpl;
import model.ProductType;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
@WebServlet("/getCategories")
public class GetCategoriesServlet extends HttpServlet {
    private static final int PAGE_SIZE = 10;
    private ProductTypeDAOImpl dao = new ProductTypeDAOImpl();
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int page = 1;
        try { page = Integer.parseInt(req.getParameter("page")); } catch(Exception ignored){}
        int total = dao.count();
        int totalPages = (int)Math.ceil(total/(double)PAGE_SIZE);
        int offset = (page - 1) * PAGE_SIZE;
        List<ProductType> data = dao.findByPage(offset, PAGE_SIZE);
        HashMap<String,Object> result = new HashMap<>();
        result.put("data", data);
        result.put("currentPage", page);
        result.put("totalPages", totalPages);
        resp.setContentType("application/json;charset=UTF-8");
        new Gson().toJson(result, resp.getWriter());
    }
}