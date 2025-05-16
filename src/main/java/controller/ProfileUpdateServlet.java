package controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import model.User;
import service.UploadService;
import service.UserInForServies;
import java.io.File;
import java.io.IOException;
import java.time.LocalDate;

@WebServlet({"/api/profile/update", "/updateProfile"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize       = 5 * 1024 * 1024,
        maxRequestSize    = 10 * 1024 * 1024
)
public class ProfileUpdateServlet extends HttpServlet {
    private UserInForServies userService  = new UserInForServies();
    private UploadService    uploadService = new UploadService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // 1) Thiết lập UTF-8
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        // 2) Kiểm tra phiên
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendError(401);
            return;
        }
        User u = (User) session.getAttribute("user");

        // 3) Đọc params
        int    id       = u.getId();
        String username = req.getParameter("username");
        String name     = req.getParameter("name");
        String email    = req.getParameter("email");
        String phone    = req.getParameter("phone");
        String gender   = req.getParameter("gender");
        String d        = req.getParameter("day");
        String m        = req.getParameter("month");
        String y        = req.getParameter("year");
        LocalDate birth = null;
        if (d!=null && m!=null && y!=null && !d.isEmpty() && !m.isEmpty() && !y.isEmpty()) {
            birth = LocalDate.of(
                    Integer.parseInt(y),
                    Integer.parseInt(m),
                    Integer.parseInt(d)
            );
        }

        // 4) Xử lý avatar
        Part avatar = req.getPart("avatar");
        if (avatar!=null && avatar.getSize()>0) {
            String ext = avatar.getSubmittedFileName()
                    .replaceAll(".*(\\.[^.]*)$", "$1");
            File tmp = File.createTempFile("up_", ext);
            avatar.write(tmp.getAbsolutePath());
            String url = uploadService.uploadCloud(
                    "avatar_"+id+"_"+System.currentTimeMillis()+ext,
                    tmp
            );
            tmp.delete();
            if (url!=null) {
                userService.updateAvatar(id, url);
                u.setPicture(url);
            }
        }

        // 5) Cập nhật profile
        boolean ok = userService.updateProfile(
                id, username, name, email, phone, gender, birth
        );
        u.setPhone(phone);
        u.setGender(gender);
        u.setBirth(birth);

        // 6) Phân biệt AJAX vs normal
        if ("XMLHttpRequest".equals(req.getHeader("X-Requested-With"))) {
            resp.setContentType("application/json;charset=UTF-8");
            String safeName = name.replace("\"", "\\\"");
            String json = String.format(
                    "{\"ok\":%b,\"name\":\"%s\",\"phone\":\"%s\",\"gender\":\"%s\"}",
                    ok, safeName, phone, gender
            );
            resp.getWriter().write(json);
            return;
        }

        // 7) Normal redirect
        session.setAttribute("user", u);
        session.setAttribute("message",
                ok? "Cập nhật thành công" : "Cập nhật thất bại"
        );
        session.setAttribute("messageType",
                ok? "success" : "error"
        );
        resp.sendRedirect(req.getContextPath() + "/profile.jsp");
    }
}