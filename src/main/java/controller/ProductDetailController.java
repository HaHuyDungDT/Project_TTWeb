package controller;

import model.Log;
import model.Product;
import model.Rate;
import model.User;
import service.ILogService;
import service.IProductService;
import service.IRatingService;
import service.IUserService;
import service.impl.LogServiceImpl;
import service.impl.ProductServiceImpl;
import service.impl.RatingServiceImpl;
import service.impl.UserServiceImpl;
import utils.LevelLog;
import utils.SessionUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(value = "/product")
public class ProductDetailController extends HttpServlet {
    private IProductService productService = new ProductServiceImpl();
    private ILogService logService = new LogServiceImpl();
    private IRatingService ratingService = new RatingServiceImpl();
    private IUserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        
        try {
            String productIdParam = req.getParameter("id");
            if (productIdParam == null || productIdParam.trim().isEmpty()) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Product ID is required");
                return;
            }

            Integer productId = Integer.parseInt(productIdParam);
            Product product = productService.findProductById(productId);
            
            if (product == null) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Product not found");
                return;
            }

            User user = (User) SessionUtil.getInstance().getKey(req, "user");
            
            // Log việc xem sản phẩm
            logProductView(req, resp, product, user);

            // Lấy sản phẩm liên quan
            List<Product> relatedProducts = getRelatedProducts(product);

            // Check if user has purchased this product
            boolean hasPurchased = false;
            if (user != null) {
                hasPurchased = ratingService.hasUserPurchasedProduct(user.getId(), productId);
            }

            // Set attributes for JSP
            req.setAttribute("product", product);
            req.setAttribute("relatedProducts", relatedProducts);
            req.setAttribute("hasPurchased", hasPurchased);
            req.setAttribute("ratingService", ratingService);
            req.setAttribute("userService", userService);
            
            req.getRequestDispatcher("sanpham.jsp").forward(req, resp);
        } catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid product ID format");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while processing your request");
        }
    }

    private void logProductView(HttpServletRequest req, HttpServletResponse resp, Product product, User user) {
        Log log = new Log();
        log.setUserId(user != null ? user.getId() : 0);
        log.setAction("Xem chi tiết sản phẩm: " + product.getName());
        log.setAddressIP(req.getRemoteAddr());
        log.setLevel(LevelLog.INFO);
        logService.save(log);
    }

    private List<Product> getRelatedProducts(Product product) {
        List<Product> relatedProducts = productService.findByCategory(product.getProductTypeID());
        relatedProducts.removeIf(p -> p.getId().equals(product.getId()));
        if (relatedProducts.size() > 4) {
            relatedProducts = relatedProducts.subList(0, 4);
        }
        return relatedProducts;
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
