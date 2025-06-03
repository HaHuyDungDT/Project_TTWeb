package controller;

import com.fasterxml.jackson.databind.ObjectMapper;

//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.User;
import service.IUserService;
import service.impl.UserServiceImpl;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@WebServlet(name = "addAccount", value = "/quanlytaikhoan/account-add")
public class AddAccountController extends HttpServlet {
    private IUserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json");
        ObjectMapper objectMapper = new ObjectMapper();
        if(userService.isEmailExists(req.getParameter("email"))){
            objectMapper.writeValue(resp.getOutputStream(), false);
            return;
        }
        objectMapper.writeValue(resp.getOutputStream(), true);
    }

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json");
        ObjectMapper objectMapper = new ObjectMapper();
        System.out.println(req.getParameter("user"));
        if(userService.isUsernameExists(req.getParameter("user"))){
            objectMapper.writeValue(resp.getOutputStream(), false);
            return;
        }
        objectMapper.writeValue(resp.getOutputStream(), true);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");//
        resp.setContentType("application/json");

        try {
            // Chuyển đổi dữ liệu từ form thành đối tượng User
            User user = new User();
            user.setUsername(req.getParameter("user"));
            user.setPassword(req.getParameter("password"));
            user.setName(req.getParameter("name"));
            user.setEmail(req.getParameter("email"));
            user.setPhone(req.getParameter("phone"));
            String birthDateStr = req.getParameter("birth");
            if (birthDateStr != null && !birthDateStr.isEmpty()) {
                user.setBirth(LocalDate.parse(birthDateStr, DateTimeFormatter.ISO_DATE));
            }
            user.setGender(req.getParameter("gender"));
            user.setAddress(req.getParameter("address"));
            user.setRoleId(Integer.parseInt(req.getParameter("role")));  // Quyền admin (1) hoặc user (2)
            user.setStatus(1);  // Trạng thái mặc định là kích hoạt
            user.setOauthProvider(null);
            user.setOauthUid(null);
            user.setOauthToken(null);
            user.setCreatedAt(LocalDateTime.now());
            user.setUpdatedAt(LocalDateTime.now());

            user.setSecretKey(null);
            user.setTwoFaEnabled(false);
            user.setPicture(null);
            System.out.println("=== User cần insert ===");
            System.out.println(user);
            if (userService.isEmailExists(user.getEmail()) || userService.isUsernameExists(user.getUsername())) {
                req.setAttribute("errorMessage", "Email hoặc Username đã tồn tại!");
                req.getRequestDispatcher("/quanlytaikhoan").forward(req, resp);
                return;
            }
            boolean success = userService.add(user);

            if (success) {
                HttpSession session = req.getSession();
                session.setAttribute("addAccountSuccess", true);
                resp.sendRedirect("/quanlytaikhoan");
                return;
            } else {
                HttpSession session = req.getSession();
                session.setAttribute("addAccountSuccess", false);
                req.getRequestDispatcher("/quanlytaikhoan").forward(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("errorMessage", "Lỗi hệ thống: " + e.getMessage());
            req.getRequestDispatcher("/quanlytaikhoan").forward(req, resp);
        }

    }

}