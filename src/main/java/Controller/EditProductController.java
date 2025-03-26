package Controller;

import dao.ProducerDAO;
import dao.ProductDAO;
import dao.ProductTypeDAO;
import model.Producer;
import model.Product;
import model.ProductType;
import model.Producer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;

@WebServlet(name = "EditProductController", value = "/edit")
public class EditProductController extends HttpServlet {
    private ProductDAO productDAO = new ProductDAO();
    private ProductTypeDAO productTypeDAO = new ProductTypeDAO();
    private ProducerDAO producerDAO = new ProducerDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        try {
            Integer id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            Double price = Double.parseDouble(request.getParameter("price"));
            Integer productTypeId = Integer.parseInt(request.getParameter("productType"));
            Integer quantity = Integer.parseInt(request.getParameter("quantity"));
            Integer productCategoryId = Integer.parseInt(request.getParameter("productCategory"));
            String img = request.getParameter("img");

            ProductType productType = productTypeDAO.getById(productTypeId);
            Producer producer = producerDAO.getById(productCategoryId);

            Product product = new Product(
                    id,
                    name,
                    price,
                    productType.getId(),
                    productType,
                    quantity,
                    producer.getId(),
                    producer,
                    "Active",
                    new Date(),
                    null,               // couponId
                    "",                 // detail
                    new ArrayList<>(),  // images
                    new ArrayList<>()   // rates
            );

            productDAO.update(product);
            request.getSession().setAttribute("editProductSuccess", true);
            response.sendRedirect("quanlysanpham.jsp");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }


}
