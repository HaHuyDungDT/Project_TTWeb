package controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import dao.IImageDAO;
import dao.IProducerDAO;
import dao.IProductTypeDAO;
import dao.impl.ImageDAOImpl;
import dao.impl.ProducerDAOImpl;
import dao.impl.ProductDAOImpl;
import javax.servlet.http.Part;

import dao.impl.ProductTypeDAOImpl;
import model.Image;
import model.Product;
import model.ProductType;
import model.Producer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import service.IProductService;
import service.impl.ProductServiceImpl;

import javax.servlet.annotation.MultipartConfig;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@MultipartConfig
@WebServlet(value = "/quanlysanpham/product-edit")
public class EditProductController extends HttpServlet {
    private IProductService productService = new ProductServiceImpl();
    private IProductTypeDAO productTypeDAO = new ProductTypeDAOImpl();
    private IProducerDAO producerDAO = new ProducerDAOImpl();
    private IImageDAO imageDAO = new ImageDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String productIdParam = req.getParameter("id");
        if (productIdParam == null || productIdParam.isEmpty()) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Product ID is missing");
            return;
        }

        Integer productId = Integer.parseInt(productIdParam);
        Product product = productService.findProductById(productId);

        if (product != null) {
            // Lấy tất cả loại sản phẩm và nhà sản xuất
            List<ProductType> productTypes = productTypeDAO.findAll();
            List<Producer> producers = producerDAO.findAll(); // Lấy tất cả hãng sản xuất

            // Gán thông tin loại sản phẩm và nhà sản xuất vào sản phẩm
            ProductType productType = productTypeDAO.findById(product.getProductTypeID());
            Producer producer = producerDAO.findById(product.getProducerID());

            product.setProductType(productType);
            product.setProducer(producer);

            // Trả về dữ liệu sản phẩm và các loại sản phẩm, nhà sản xuất dưới dạng JSON
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");

            Map<String, Object> responseData = new HashMap<>();
            responseData.put("product", product);
            responseData.put("productTypes", productTypes);
            responseData.put("producers", producers);

            ObjectMapper objectMapper = new ObjectMapper();
            objectMapper.writeValue(resp.getOutputStream(), responseData);
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Product not found");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        try {
            // Lấy các tham số từ form chỉnh sửa sản phẩm
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            double price = Double.parseDouble(request.getParameter("price"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            String detail = request.getParameter("detail");
            int productTypeId = Integer.parseInt(request.getParameter("productType"));
            int producerId = Integer.parseInt(request.getParameter("producer"));
            String status = request.getParameter("status");
            String importDateStr = request.getParameter("import_date");
            String couponIdStr = request.getParameter("couponId");

            // Debug thông tin nhận được từ form
            System.out.println("Received POST data for product ID: " + id);
            System.out.println("Name: " + name + ", Price: " + price + ", Quantity: " + quantity);
            System.out.println("Detail: " + detail + ", Product Type ID: " + productTypeId + ", Producer ID: " + producerId);
            System.out.println("Status: " + status + ", Import Date: " + importDateStr + ", Coupon ID: " + couponIdStr);

            // Tạo đối tượng Product từ các tham số
            Product product = new Product();
            product.setId(id);
            product.setName(name);
            product.setPrice(price);
            product.setQuantity(quantity);
            product.setDetail(detail);
            product.setStatus(status);

            // Gán Product Type và Producer
            ProductType productType = new ProductType();
            productType.setId(productTypeId);
            product.setProductType(productType);
            product.setProductTypeID(productTypeId);

            Producer producer = new Producer();
            producer.setId(producerId);
            product.setProducer(producer);
            product.setProducerID(producerId);

            // Xử lý ngày nhập sản phẩm
            if (importDateStr != null && !importDateStr.isEmpty()) {
                java.util.Date importDate = new java.text.SimpleDateFormat("yyyy-MM-dd").parse(importDateStr);
                product.setImport_date(importDate);
            }

            // Xử lý mã giảm giá
            if (couponIdStr != null && !couponIdStr.isEmpty()) {
                product.setCouponId(Integer.parseInt(couponIdStr));
            }


            // Xử lý ảnh nếu người dùng chọn tải ảnh mới
            Part imagePart = request.getPart("imageFile"); // Lấy phần ảnh từ form
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
            } else {
                System.out.println("Không có ảnh mới được tải lên.");
            }

            // Cập nhật sản phẩm trong cơ sở dữ liệu
//            boolean success = new ProductDAOImpl().updateProduct(product);
            boolean success = productService.updateProduct(product);  // gọi service thay vì DAO trực tiếp

            System.out.println("Kết quả cập nhật sản phẩm: " + success);

            // Nếu có ảnh mới, cập nhật ảnh vào cơ sở dữ liệu
            if (imageUrl != null) {
                Image newImage = new Image();
                newImage.setLinkImage(imageUrl);
                newImage.setProductId(id);  // ID sản phẩm đã có, cập nhật ảnh
                imageDAO.addImageForProduct(id, newImage.getLinkImage());
                System.out.println("Ảnh được lưu vào DB với ID sản phẩm: " + id);
            }

            // Gán giá trị success vào session để thông báo kết quả cho người dùng
            request.getSession().setAttribute("editProductSuccess", success);

        } catch (Exception e) {
            // Xử lý lỗi
            System.out.println("Lỗi khi cập nhật sản phẩm: " + e.getMessage());
            e.printStackTrace();
            request.getSession().setAttribute("editProductSuccess", false);
        }

        // Chuyển hướng về trang quản lý sản phẩm
        response.sendRedirect("/quanlysanpham");
    }
}