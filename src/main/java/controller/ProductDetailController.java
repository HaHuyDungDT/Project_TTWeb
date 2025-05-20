package controller;

import model.Log;
import model.Product;
import model.Rate;
import model.User;
import service.ILogService;
import service.IProductService;
import service.impl.LogServiceImpl;
import service.impl.ProductServiceImpl;
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

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        Integer productId = Integer.parseInt(req.getParameter("id"));
        Product product = productService.findProductById(productId);
        User user = (User) SessionUtil.getInstance().getKey(req, "user");
        
        // Log việc xem sản phẩm
        logProductView(req, resp, product, user);

        // Lấy sản phẩm liên quan
        List<Product> relatedProducts = getRelatedProducts(product);


        req.setAttribute("product", product);
        req.setAttribute("relatedProducts", relatedProducts);
        req.getRequestDispatcher("sanpham.jsp").forward(req, resp);
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
