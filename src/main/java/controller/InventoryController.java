package controller;

import dao.IInventoryDAO;
import dao.impl.InventoryDAOImpl;
import dao.impl.ProductDAOImpl;
import model.Inventory;
import model.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/quanlytonkho")
public class InventoryController extends HttpServlet {
    private IInventoryDAO inventoryDAO = new InventoryDAOImpl();
    private ProductDAOImpl productDAO = new ProductDAOImpl();
    private static final int PAGE_SIZE = 12;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int page = 1;
        String pageParam = req.getParameter("page");
        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        List<Inventory> allInventories = inventoryDAO.findAll();
        int totalItems = allInventories.size();
        int totalPages = (int) Math.ceil((double) totalItems / PAGE_SIZE);

        int start = (page - 1) * PAGE_SIZE;
        int end = Math.min(start + PAGE_SIZE, totalItems);

        List<Inventory> pageInventories = new ArrayList<>();
        for (int i = start; i < end; i++) {
            Inventory inv = allInventories.get(i);
            Product product = productDAO.findById(inv.getProductId());
            if (product != null) {
                inv.setProductName(product.getName());
                if (product.getImages() != null && !product.getImages().isEmpty()) {
                    inv.setProductImage(product.getImages().get(0).getLinkImage());
                } else {
                    inv.setProductImage("default.png");
                }
            }
            pageInventories.add(inv);
        }

        req.setAttribute("inventories", pageInventories);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("currentPage", page);
        req.setAttribute("successMsg", req.getSession().getAttribute("successMsg"));
        req.setAttribute("errorMsg", req.getSession().getAttribute("errorMsg"));
        req.getSession().removeAttribute("successMsg");
        req.getSession().removeAttribute("errorMsg");

        req.getRequestDispatcher("quanlytonkho.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        try {
            int productId = Integer.parseInt(req.getParameter("productId"));

            switch (action) {
                case "update":
                    int newQty = Integer.parseInt(req.getParameter("quantity"));
                    inventoryDAO.updateQuantity(productId, newQty);
                    break;
                case "delete":
                    inventoryDAO.deleteByProductId(productId);
                    break;
                case "insert":
                    int quantity = Integer.parseInt(req.getParameter("quantity"));
                    Inventory newInv = new Inventory(0, productId, quantity, null, null);
                    inventoryDAO.insertInventory(newInv);
                    break;
                default:
                    break;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        if (action.equals("insert")) {
            req.getSession().setAttribute("successMsg", "Thêm tồn kho thành công!");
        } else if (action.equals("update")) {
            req.getSession().setAttribute("successMsg", "Cập nhật tồn kho thành công!");
        } else if (action.equals("delete")) {
            req.getSession().setAttribute("successMsg", "Xóa tồn kho thành công!");
        }

        resp.sendRedirect(req.getContextPath() + "/quanlytonkho");
    }
}
