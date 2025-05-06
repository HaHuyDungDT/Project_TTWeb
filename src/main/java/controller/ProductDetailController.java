package controller;

import model.Log;
import model.Product;
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
        if (user == null) {
            Log log = new Log();
            log.setUserId(0);
            log.setAction("Xem chi tiết sản phẩm: " + product.getName());
            log.setAddressIP(req.getRemoteAddr());
            log.setLevel(LevelLog.INFO);
            logService.save(log);
        } else {
            Log log = new Log();
            log.setUserId(user.getId());
            log.setAction("Xem chi tiết sản phẩm: " + product.getName());
            log.setAddressIP(req.getRemoteAddr());
            log.setLevel(LevelLog.INFO);
            logService.save(log);
        }
        req.setAttribute("product", product);
        req.getRequestDispatcher("sanpham.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
