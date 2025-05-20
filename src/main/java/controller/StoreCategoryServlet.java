package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.ProductType;
import dao.impl.ProductTypeDAOImpl;

@WebServlet(name = "StoreCategoryServlet", urlPatterns = {"/storeCategory"})
public class StoreCategoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Ví dụ dùng SLF4J để log (nếu có)
    // private static final Logger logger = LoggerFactory.getLogger(StoreCategoryServlet.class);

    private final ProductTypeDAOImpl dao = new ProductTypeDAOImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // 1. Thiết lập UTF-8 cho request/response
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");

        // 2. Lấy và validate tham số
        String name = req.getParameter("name");
        if (name == null || name.trim().isEmpty()) {
            // thiếu tên => quay lại trang với thông báo lỗi
            resp.sendRedirect(req.getContextPath()
                    + "/quanlydanhmuc.jsp?error=missingName");
            return;
        }
        name = name.trim();

        // 3. Sinh code: uppercase và thay khoảng trắng thành dấu _
        String code = name.toUpperCase().replaceAll("\\s+", "_");

        // 4. Tạo object và lưu
        ProductType pt = new ProductType(null, name, code);
        boolean saved;
        try {
            saved = dao.save(pt);
        } catch (Exception e) {
            // Log lỗi (nếu có logging framework)
            // logger.error("Lỗi khi lưu ProductType: ", e);
            saved = false;
        }

        // 5. Redirect về trang danh sách với flag kết quả
        if (saved) {
            resp.sendRedirect(req.getContextPath()
                    + "/quanlydanhmuc.jsp?added=1");
        } else {
            resp.sendRedirect(req.getContextPath()
                    + "/quanlydanhmuc.jsp?error=saveFailed");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // Nếu user cố gắng GET /storeCategory, redirect về trang quản lý
        resp.sendRedirect(req.getContextPath() + "/quanlydanhmuc.jsp");
    }
}
