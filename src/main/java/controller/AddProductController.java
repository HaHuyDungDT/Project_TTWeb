package controller;

import dao.IProductDAO;
import dao.impl.ProductDAOImpl;
import model.Product;
import service.IProductService;
import service.impl.ProductServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;



@WebServlet("/quanlysanpham/product-add")
@MultipartConfig
public class AddProductController extends HttpServlet {
    private IProductDAO productDAO = new ProductDAOImpl();
    private IProductService productService = new ProductServiceImpl();

    private static final String UPLOAD_DIR = "uploads";

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            // Lấy dữ liệu form
            String name = req.getParameter("name");
            double price = Double.parseDouble(req.getParameter("price"));
            int productTypeID = Integer.parseInt(req.getParameter("productType"));
            int producerID = Integer.parseInt(req.getParameter("producer"));
            int quantity = Integer.parseInt(req.getParameter("quantity"));
            String status = req.getParameter("status");
            String detail = req.getParameter("detail");
            String couponIdStr = req.getParameter("couponId");
            Integer couponId = (couponIdStr == null || couponIdStr.isEmpty()) ? null : Integer.parseInt(couponIdStr);
            java.sql.Date import_date = new java.sql.Date(System.currentTimeMillis());

            Product product = new Product();
            product.setName(name);
            product.setPrice(price);
            product.setProductTypeID(productTypeID);
            product.setProducerID(producerID);
            product.setQuantity(quantity);
            product.setStatus(status);
            product.setDetail(detail);
            product.setCouponId(couponId);
            product.setImport_date(import_date);

            boolean isAdded = productService.insert(product);  // gọi service thay vì DAO trực tiếp

            if (isAdded) {
                // Upload ảnh
                Part imagePart = req.getPart("imageFile");
                if (imagePart != null && imagePart.getSize() > 0) {
                    String appPath = req.getServletContext().getRealPath("");
                    String uploadPath = appPath + File.separator + UPLOAD_DIR;
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) uploadDir.mkdir();

                    String fileName = extractFileName(imagePart);
                    String filePath = uploadPath + File.separator + fileName;
                    imagePart.write(filePath);

                    String relativePath = "./" + UPLOAD_DIR + "/" + fileName;
                    productDAO.saveImage(product.getId(), relativePath);
                }

                req.getSession().setAttribute("addProductSuccess", true);
                resp.sendRedirect(req.getContextPath() + "/quanlysanpham");
            } else {
                resp.sendRedirect(req.getContextPath() + "/product-add.jsp?error=fail");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/product-add.jsp?error=exception");
        }
    }

    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        for (String token : contentDisp.split(";")) {
            if (token.trim().startsWith("filename")) {
                return new File(token.substring(token.indexOf('=') + 1).trim().replace("\"", "")).getName();
            }
        }
        return null;
    }
}
