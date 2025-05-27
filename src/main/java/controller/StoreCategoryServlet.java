package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.ProductType;
import dao.impl.ProductTypeDAOImpl;

@WebServlet("/storeCategory")
public class StoreCategoryServlet extends HttpServlet {
    private ProductTypeDAOImpl dao = new ProductTypeDAOImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // 1. Thiết lập charset cho request để lấy đúng tham số có dấu
        req.setCharacterEncoding("UTF-8");
        // 2. Thiết lập charset cho response để trả về đúng encoding
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");
        String name = req.getParameter("name");
        // Tạo mã tự động (VD: uppercase + gạch dưới)
        String code = name.toUpperCase().replaceAll("\\s+", "_");
        ProductType pt = new ProductType(null, name, code);

        if (dao.save(pt)) {
            // redirect để tránh reload form khi F5
            resp.sendRedirect("quanlydanhmuc.jsp?added=1");
        } else {
            resp.sendRedirect("quanlydanhmuc.jsp?error=1");
        }
    }
}
