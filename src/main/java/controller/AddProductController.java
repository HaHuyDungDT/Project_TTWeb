package controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import dao.IImageDAO;
import dao.IProducerDAO;
import dao.IProductDAO;
import dao.IProductTypeDAO;
import dao.impl.ImageDAOImpl;
import dao.impl.ProducerDAOImpl;
import dao.impl.ProductDAOImpl;
import dao.impl.ProductTypeDAOImpl;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import model.Image;
import model.Producer;
import model.Product;
import model.ProductType;
import service.IProductService;
import service.impl.ProductServiceImpl;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "AddProductController", value = "/quanlysanpham/product-add")
@MultipartConfig  // Cấu hình multi-part để xử lý file upload
public class AddProductController extends HttpServlet {
    private IProductDAO dao = new ProductDAOImpl();
    private final IImageDAO imageDAO = new ImageDAOImpl();
    private IProductService productService = new ProductServiceImpl();
    private IProductTypeDAO productTypeDAO = new ProductTypeDAOImpl();
    private IProducerDAO producerDAO = new ProducerDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Fetch the list of product types and producers
            List<ProductType> productTypes = productService.getProductTypes();
            List<Producer> producers = productService.getProducers();

            // Set the product types and producers as attributes to be used in the JSP
            request.setAttribute("productTypes", productTypes);
            request.setAttribute("producers", producers);

            // Forward the request to the JSP where the form is located
            request.getRequestDispatcher("/quanlysanpham.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error fetching product types and producers");
        }
    }


//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        request.setCharacterEncoding("UTF-8");
//        response.setCharacterEncoding("UTF-8");
//
//        try {
//            String name = request.getParameter("name");
//            System.out.println("Tên sản phẩm: " + name);
//
//            double price = 0;
//            int quantity = 0;
//            try {
//                price = Double.parseDouble(request.getParameter("price"));
//                quantity = Integer.parseInt(request.getParameter("quantity"));
//                System.out.println("Giá sản phẩm: " + price);
//                System.out.println("Số lượng: " + quantity);
//            } catch (NumberFormatException e) {
//                System.out.println("Lỗi khi parse giá hoặc số lượng: " + e.getMessage());
//                request.setAttribute("errorMessage", "Giá và số lượng phải là số hợp lệ.");
//                request.getRequestDispatcher("/quanlysanpham").forward(request, response);
//                return;
//            }
//
//            String detail = request.getParameter("detail");
//            System.out.println("Mô tả sản phẩm: " + detail);
//
//            int productTypeId = Integer.parseInt(request.getParameter("productType"));
//            System.out.println("ID loại sản phẩm: " + productTypeId);
//
//            int producerId = Integer.parseInt(request.getParameter("producer"));
//            System.out.println("ID nhà sản xuất: " + producerId);
//
//            String status = request.getParameter("status");
//            System.out.println("Trạng thái sản phẩm: " + status);
//
//            String importDateStr = request.getParameter("import_date");
//            System.out.println("Ngày nhập: " + importDateStr);
//
//            String couponIdStr = request.getParameter("couponId");
//            System.out.println("Mã giảm giá: " + couponIdStr);
//
//            Product product = new Product();
//            product.setName(name);
//            product.setPrice(price);
//            product.setQuantity(quantity);
//            product.setDetail(detail);
//            product.setStatus(status);
//
//            ProductType productType = new ProductType();
//            productType.setId(productTypeId);
//            product.setProductType(productType);
//            product.setProductTypeID(productTypeId);
//
//            Producer producer = new Producer();
//            producer.setId(producerId);
//            product.setProducer(producer);
//            product.setProducerID(producerId);
//
//            // Xử lý ngày nhập
//            if (importDateStr != null && !importDateStr.isEmpty()) {
//                try {
//                    java.util.Date importDate = new java.text.SimpleDateFormat("yyyy-MM-dd").parse(importDateStr);
//                    product.setImport_date(importDate);
//                } catch (Exception e) {
//                    System.out.println("Lỗi khi parse ngày nhập: " + e.getMessage());
//                }
//            }
//
//            // Gán mã giảm giá (nullable)
//            if (couponIdStr != null && !couponIdStr.isEmpty()) {
//                product.setCouponId(Integer.parseInt(couponIdStr));
//            }
//
//            // Xử lý ảnh (nếu có ảnh mới)
//            Part imagePart = request.getPart("imageFile");
//            String imageUrl = null;
//            if (imagePart != null && imagePart.getSize() > 0) {
//                // Lưu ảnh vào thư mục img
//                String filename = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
//                String uploadPath = getServletContext().getRealPath("/img");
//                File uploadDir = new File(uploadPath);
//                if (!uploadDir.exists()) uploadDir.mkdirs();  // Tạo thư mục nếu không tồn tại
//
//                String fullPath = uploadPath + File.separator + filename;
//                imagePart.write(fullPath);  // Lưu ảnh vào thư mục
//
//                // Lưu đường dẫn ảnh vào DB
//                imageUrl = "img/" + filename;
//                System.out.println("Ảnh mới đã được lưu với đường dẫn: " + imageUrl);
//            }
//
//            // Thêm sản phẩm vào cơ sở dữ liệu
//            boolean success = dao.addProduct(product);
//            System.out.println("Kết quả thêm sản phẩm vào cơ sở dữ liệu: " + success);
//
//
//            if (success) {
//                Integer productId = product.getId(); // ID sẽ được gán sau khi insert thành công
//                // Lấy ID sản phẩm sau khi thêm thành công từ cơ sở dữ liệu
//                if (productId == null) {
//                    System.out.println("Lỗi: ID sản phẩm không được gán sau khi thêm vào cơ sở dữ liệu.");
//                    request.getSession().setAttribute("addProductSuccess", false);
//                    response.sendRedirect("/quanlysanpham");
//                    return;
//                }
//                if (imageUrl != null) {
//                    Image newImage = new Image();
//                    newImage.setLinkImage(imageUrl);
//                    newImage.setProductId(productId);  // Cập nhật ID sản phẩm thực tế
//                    imageDAO.addImageForProduct(productId, newImage.getLinkImage());
//                    System.out.println("Ảnh được lưu vào DB với ID sản phẩm: " + productId);
//                }
//                // Nếu có ảnh, lưu ảnh vào DB
//
//
//                request.getSession().setAttribute("addProductSuccess", true);
//            } else {
//                request.getSession().setAttribute("addProductSuccess", false);
//
//                System.out.println("them san pham that bai");
//            }
//
//        } catch (Exception e) {
//            System.out.println("Lỗi trong quá trình xử lý sản phẩm: " + e.getMessage());
//            e.printStackTrace();
//            request.getSession().setAttribute("addProductSuccess", false);
//        }
//
//        // Quay lại trang quản lý sản phẩm
//        response.sendRedirect("/quanlysanpham");
//    }
@Override
protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");

    try {
        String name = request.getParameter("name");
        System.out.println("Tên sản phẩm: " + name);

        double price = 0;
        int quantity = 0;
        try {
            price = Double.parseDouble(request.getParameter("price"));
            quantity = Integer.parseInt(request.getParameter("quantity"));
            System.out.println("Giá sản phẩm: " + price);
            System.out.println("Số lượng: " + quantity);
        } catch (NumberFormatException e) {
            System.out.println("Lỗi khi parse giá hoặc số lượng: " + e.getMessage());
            request.setAttribute("errorMessage", "Giá và số lượng phải là số hợp lệ.");
            request.getRequestDispatcher("/quanlysanpham").forward(request, response);
            return;
        }

        String detail = request.getParameter("detail");
        System.out.println("Mô tả sản phẩm: " + detail);

        int productTypeId = Integer.parseInt(request.getParameter("productType"));
        System.out.println("ID loại sản phẩm: " + productTypeId);

        int producerId = Integer.parseInt(request.getParameter("producer"));
        System.out.println("ID nhà sản xuất: " + producerId);

        String status = request.getParameter("status");
        System.out.println("Trạng thái sản phẩm: " + status);

        String importDateStr = request.getParameter("import_date");
        System.out.println("Ngày nhập: " + importDateStr);

        String couponIdStr = request.getParameter("couponId");
        System.out.println("Mã giảm giá: " + couponIdStr);

        Product product = new Product();
        product.setName(name);
        product.setPrice(price);
        product.setQuantity(quantity);
        product.setDetail(detail);
        product.setStatus(status);

        ProductType productType = new ProductType();
        productType.setId(productTypeId);
        product.setProductType(productType);
        product.setProductTypeID(productTypeId);

        Producer producer = new Producer();
        producer.setId(producerId);
        product.setProducer(producer);
        product.setProducerID(producerId);

        // Xử lý ngày nhập
        if (importDateStr != null && !importDateStr.isEmpty()) {
            try {
                java.util.Date importDate = new java.text.SimpleDateFormat("yyyy-MM-dd").parse(importDateStr);
                product.setImport_date(importDate);
            } catch (Exception e) {
                System.out.println("Lỗi khi parse ngày nhập: " + e.getMessage());
            }
        }

        // Gán mã giảm giá (nullable)
        if (couponIdStr != null && !couponIdStr.isEmpty()) {
            product.setCouponId(Integer.parseInt(couponIdStr));
        }

        // Xử lý ảnh (nếu có ảnh mới)
        Part imagePart = request.getPart("imageFile");
        String imageUrl = null;
        if (imagePart != null && imagePart.getSize() > 0) {
            // Lưu ảnh vào thư mục img
            String filename = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
            String uploadPath = getServletContext().getRealPath("/img");
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();  // Tạo thư mục nếu không tồn tại

            String fullPath = uploadPath + File.separator + filename;
            imagePart.write(fullPath);  // Lưu ảnh vào thư mục

            // Lưu đường dẫn ảnh vào DB
            imageUrl = "img/" + filename;
            System.out.println("Ảnh mới đã được lưu với đường dẫn: " + imageUrl);
        }

        // Thêm sản phẩm vào cơ sở dữ liệu
        boolean success = dao.addProduct(product);
        System.out.println("Kết quả thêm sản phẩm vào cơ sở dữ liệu: " + success);

        if (success) {
            // Lấy ID sản phẩm sau khi thêm thành công từ cơ sở dữ liệu
            Integer productId = product.getId(); // ID sẽ được gán sau khi insert thành công
            if (productId == null) {
                System.out.println("Lỗi: ID sản phẩm không được gán sau khi thêm vào cơ sở dữ liệu.");
                request.getSession().setAttribute("addProductSuccess", false);
                response.sendRedirect("/quanlysanpham");
                return;
            }

            // Nếu có ảnh, lưu ảnh vào DB
            if (imageUrl != null) {
                Image newImage = new Image();
                newImage.setLinkImage(imageUrl);
                newImage.setProductId(productId);  // Cập nhật ID sản phẩm thực tế
                imageDAO.addImageForProduct(productId, newImage.getLinkImage());
                System.out.println("Ảnh được lưu vào DB với ID sản phẩm: " + productId);
            }

            request.getSession().setAttribute("addProductSuccess", true);
        } else {
            request.getSession().setAttribute("addProductSuccess", false);
        }

    } catch (Exception e) {
        System.out.println("Lỗi trong quá trình xử lý sản phẩm: " + e.getMessage());
        e.printStackTrace();
        request.getSession().setAttribute("addProductSuccess", false);
    }

    // Quay lại trang quản lý sản phẩm
    response.sendRedirect("/quanlysanpham");
}

}