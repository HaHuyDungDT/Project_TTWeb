package Controller;

import dao.ProductDAO;
import model.Product;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "Paging", value = "/paging")
public class Paging extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String index = request.getParameter("index");
        if(index==null){
            index = "1";
        }
        int indexPage = Integer.parseInt(index);
        ProductDAO productDAO = new ProductDAO();
        List<Product> list = productDAO.getPaging(indexPage);

        request.setAttribute("listP", list);
        request.getRequestDispatcher("danhmucsanpham.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
