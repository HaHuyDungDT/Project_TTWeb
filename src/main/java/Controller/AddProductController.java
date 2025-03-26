package Controller;

import dao.ProductTypeDAO;
import dao.ProducerDAO;
import dao.ProductDAO;
import model.Producer;
import model.Product;
import model.ProductType;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;

@WebServlet(name = "AddProductController", value = "/add")
public class AddProductController extends HttpServlet {

    private ProductDAO productDAO = new ProductDAO();
    private ProductTypeDAO productTypeDAO = new ProductTypeDAO();
    private ProducerDAO producerDAO = new ProducerDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        try {
            String name = request.getParameter("name");
            Double price = Double.parseDouble(request.getParameter("price"));
            Integer productTypeID = Integer.valueOf(request.getParameter("productType"));
            Integer quantity = Integer.parseInt(request.getParameter("quantity"));
            Integer producerID = Integer.valueOf(request.getParameter("producer"));
            String img = request.getParameter("img");

            ProductType productType = productTypeDAO.getById(productTypeID);
            Producer producer = producerDAO.getById(producerID);

            if (productType != null && producer != null) {
                Product product = new Product();
                product.setName(name);
                product.setPrice(price);
                product.setProductTypeID(productTypeID);
                product.setProductType(productType);
                product.setQuantity(quantity);
                product.setProducerID(producerID);
                product.setProducer(producer);
                product.setStatus("ACTIVE"); // giá trị mặc định
                product.setImport_date(new Date()); // ngày hiện tại
                product.setImages(new ArrayList<>());
                product.setRates(new ArrayList<>());

                productDAO.insert(product);
                request.getSession().setAttribute("addProductSuccess", true);
            } else {
                request.getSession().setAttribute("addProductSuccess", false);
            }
            response.sendRedirect("quanlysanpham.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("addProductSuccess", false);
            response.sendRedirect("quanlysanpham.jsp");
        }
    }
}
