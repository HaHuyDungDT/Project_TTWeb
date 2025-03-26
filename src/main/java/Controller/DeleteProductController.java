package Controller;

import dao.ProductDAO;
import model.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "DeleteProductController", value = "/delete")
public class DeleteProductController extends HttpServlet {
    private ProductDAO productDAO = new ProductDAO();
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");

        String id = request.getParameter("productIdToDelete");
        if(id != null && !id.isEmpty()){
            productDAO.deleteProductById(id);
            request.getSession().setAttribute("deleteSuccess", true);
            response.sendRedirect("quanlysanpham.jsp");
        }else{
            response.sendRedirect("index.jsp");
        }
    }
}
