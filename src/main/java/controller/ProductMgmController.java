package controller;

import model.Product;
import service.IProductService;
import service.impl.ProductServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import model.ProductType;
import model.Producer;

@WebServlet("/quanlysanpham")
public class ProductMgmController extends HttpServlet {
    private IProductService productService = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int page = 1;
        int pageSize = 10;
        String pageParam = req.getParameter("page");
        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
                if (page < 1) page = 1;
            } catch (NumberFormatException e) {
                page = 1;
            }
        }


        // Lấy tất cả sản phẩm từ service
//        List<Product> products = productService.findAll();
        List<Product> products = productService.getProductsByPage(page, pageSize);

        int totalProducts = productService.countProducts();
        int totalPages = (int) Math.ceil((double) totalProducts / pageSize);
        // Lấy danh sách loại sản phẩm và nhà sản xuất
        List<ProductType> productTypes = productService.getProductTypes();  // Lấy tất cả các loại sản phẩm
        List<Producer> producers = productService.getProducers();  // Lấy tất cả các nhà sản xuất

        // Truyền danh sách sản phẩm và các loại sản phẩm, nhà sản xuất vào request để hiển thị trong JSP
        req.setAttribute("products", products);
        req.setAttribute("productTypes", productTypes);
        req.setAttribute("producers", producers);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);
        // Kiểm tra thông báo thành công hoặc thất bại nếu có
        HttpSession session = req.getSession();
        String successMessage = (String) session.getAttribute("successMessage");
        if (successMessage != null) {
            req.setAttribute("successMessage", successMessage);
            session.removeAttribute("successMessage");
        }

        String errorMessage = (String) session.getAttribute("errorMessage");
        if (errorMessage != null) {
            req.setAttribute("errorMessage", errorMessage);
            session.removeAttribute("errorMessage");
        }

        req.getRequestDispatcher("quanlysanpham.jsp").forward(req, resp);
    }

    // Cập nhật thông tin sản phẩm (sửa)
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Lấy thông tin từ form
        try {
            Integer id = Integer.parseInt(req.getParameter("id"));
            String name = req.getParameter("name");
            double price = Double.parseDouble(req.getParameter("price"));
            int quantity = Integer.parseInt(req.getParameter("quantity"));
            String detail = req.getParameter("detail");
            String productType = req.getParameter("productType");
            String producer = req.getParameter("producer");
            String status = req.getParameter("status");

            // Tạo đối tượng Product
            Product product = new Product();
            product.setId(id);
            product.setName(name);
            product.setPrice(price);
            product.setQuantity(quantity);
            product.setDetail(detail);

            // Cập nhật loại sản phẩm và nhà sản xuất
            product.setProductTypeID(Integer.parseInt(productType));
            product.setProducerID(Integer.parseInt(producer));
            product.setStatus(status);

            boolean result = productService.updateProduct(product); // Cập nhật sản phẩm

            // Lưu thông báo thành công vào session
            if (result) {
                HttpSession session = req.getSession();
                session.setAttribute("successMessage", "Cập nhật sản phẩm thành công");
            } else {
                HttpSession session = req.getSession();
                session.setAttribute("errorMessage", "Không thể cập nhật sản phẩm");
            }

            resp.sendRedirect("quanlysanpham");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid input format.");
        }
    }

    // Xóa sản phẩm
    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            // Lấy ID sản phẩm từ request
            Integer id = Integer.parseInt(req.getParameter("id"));

            // Xóa sản phẩm
            boolean result = productService.deleteById(id);

            // Lưu thông báo thành công hoặc thất bại vào session
            if (result) {
                HttpSession session = req.getSession();
                session.setAttribute("successMessage", "Xóa sản phẩm thành công");
            } else {
                HttpSession session = req.getSession();
                session.setAttribute("errorMessage", "Không thể xóa sản phẩm");
            }

            resp.sendRedirect("quanlysanpham");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid product ID.");
        }
    }
}
