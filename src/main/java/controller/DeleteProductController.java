
package controller;

import dao.impl.ProductDAOImpl;
import service.IProductService;
import service.impl.ProductServiceImpl;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/quanlysanpham/product-delete")
public class DeleteProductController extends HttpServlet {
    private IProductService productService = new ProductServiceImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Integer productId = Integer.parseInt(req.getParameter("productIdToDelete"));
            boolean result = productService.deleteById(productId);  // Xử lý xóa sản phẩm theo ID

            if (result) {
                req.getSession().setAttribute("deleteSuccess", true);  // Gửi thông báo thành công
            } else {
                req.getSession().setAttribute("deleteFailed", true);  // Thông báo lỗi
            }

            resp.sendRedirect("/quanlysanpham");
        } catch (NumberFormatException e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid product ID.");
        }
    }
}

