package Controller;

import dao.ProductDAO;
import model.Product;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "Type", value = "/type")
public class Type extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idProductType = request.getParameter("idProductType");
        ProductDAO productDAO = new ProductDAO();
        ArrayList<Product> list = productDAO.selectByIdProductType(idProductType);

        request.setAttribute("listT", list);
        request.getRequestDispatcher("danhmuctheoloaisanpham.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
