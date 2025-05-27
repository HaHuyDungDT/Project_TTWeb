package controller;

import dao.impl.ProductTypeDAOImpl;
import model.ProductType;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;

// filepath: src/controller/UpdateCategoryServlet.java
@WebServlet("/updateCategory")
public class UpdateCategoryServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // 1. Thiết lập charset cho request để lấy đúng tham số có dấu
        req.setCharacterEncoding("UTF-8");
        // 2. Thiết lập charset cho response để trả về đúng encoding
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");
        String idParam = req.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            // quay về list nếu không có id
            resp.sendRedirect(req.getContextPath() + "/quanlydanhmuc.jsp");
            return;
        }
        int id = Integer.parseInt(idParam);
        String name = req.getParameter("name");
        String code = req.getParameter("code");
        new ProductTypeDAOImpl().update(new ProductType(id,name,code));
        resp.sendRedirect(req.getContextPath() + "/quanlydanhmuc.jsp");
    }
}
