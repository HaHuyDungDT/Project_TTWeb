package controller;

import dao.impl.RatingDAOImpl;
import model.Rate;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/rate-product")
public class RateProductServlet extends HttpServlet {
    private RatingDAOImpl ratingDAO;

    @Override
    public void init() throws ServletException {
        ratingDAO = new RatingDAOImpl();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        int productId = Integer.parseInt(request.getParameter("productId"));
        int star = Integer.parseInt(request.getParameter("star"));
        String comment = request.getParameter("comment");

        Rate rate = new Rate();
        rate.setStar(star);
        rate.setComment(comment);
        rate.setProductId(productId);
        rate.setUserId(user.getId());

        ratingDAO.save(rate);

        response.sendRedirect("product?id=" + productId);
    }
} 