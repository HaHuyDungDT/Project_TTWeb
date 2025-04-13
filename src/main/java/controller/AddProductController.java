package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Product;
import service.IProductService;
import service.impl.ProductServiceImpl;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet(name = "AddProductController", value = "/admin/add-product")
public class AddProductController extends HttpServlet {
    private final IProductService productService = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/add_product.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        try {
            String name = request.getParameter("name");
            Double price = Double.parseDouble(request.getParameter("price"));
            Integer productTypeId = Integer.parseInt(request.getParameter("productTypeId"));
            Integer producerId = Integer.parseInt(request.getParameter("producerId"));
            Integer quantity = Integer.parseInt(request.getParameter("quantity"));
            String status = request.getParameter("status");
            String detail = request.getParameter("detail");
            Integer couponId = Integer.parseInt(request.getParameter("couponId"));
            Date importDate = new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("importDate"));

            Product product = new Product(null, name, price, productTypeId, null,
                    quantity, producerId, null, status, importDate, couponId, detail, null, null);

            productService.insert(product);

            response.sendRedirect(request.getContextPath() + "/admin/products");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi thêm sản phẩm.");
            request.getRequestDispatcher("/admin/add_product.jsp").forward(request, response);
        }
    }
}
