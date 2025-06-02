package controller;

import com.google.gson.Gson;
import dao.impl.ProductTypeDAOImpl;
import model.ProductType;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/autocompleteCategory")
public class AutoCompleteCategoryController extends HttpServlet {
    private ProductTypeDAOImpl dao = new ProductTypeDAOImpl();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String q = req.getParameter("query");
        resp.setContentType("application/json; charset=UTF-8");
        List<ProductType> list = (q!=null && !q.isBlank())
                ? dao.search(q.trim())
                : List.of();
        resp.getWriter().write(new Gson().toJson(list));
    }
}