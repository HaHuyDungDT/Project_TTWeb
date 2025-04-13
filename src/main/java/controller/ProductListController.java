package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Product;
import service.IProductService;
import service.impl.ProductServiceImpl;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ProductListController", value = "/admin/products")
public class ProductListController extends HttpServlet {
    private final IProductService productService = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Product> products = productService.findAll();
        request.setAttribute("products", products);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/product_list.jsp");
        dispatcher.forward(request, response);
    }
}
