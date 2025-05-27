package controller;

import dao.impl.ProductTypeDAOImpl;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/deleteCategory")
public class DeleteCategoryServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        // 1. Thiết lập charset cho request để lấy đúng tham số có dấu
        req.setCharacterEncoding("UTF-8");
        // 2. Thiết lập charset cho response để trả về đúng encoding
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");
        int id = Integer.parseInt(req.getParameter("id"));
        new ProductTypeDAOImpl().delete(id);  // giờ chỉ cập nhật active=0
        resp.sendRedirect("quanlydanhmuc.jsp");
    }
}