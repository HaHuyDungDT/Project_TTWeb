package Controller;

import dao.ProductDAO;
import model.Product;
import model.Product;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "Category", value = "/category")
public class Category extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idProducer = request.getParameter("idProducer");
        ProductDAO productDAO = new ProductDAO();
        ArrayList<Product> list = productDAO.selectByIdProducer(idProducer);


        request.setAttribute("listC", list);
        request.getRequestDispatcher("danhmuctheoNSX.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
