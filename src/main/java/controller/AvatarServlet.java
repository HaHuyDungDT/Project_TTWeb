package controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import model.User;
import service.UploadService;
import service.UserInForServies;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

@WebServlet("/api/avatar/upload")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize       = 5 * 1024 * 1024,
        maxRequestSize    = 10 * 1024 * 1024
)
public class AvatarServlet extends HttpServlet {
    private UploadService     uploadService = new UploadService();
    private UserInForServies  userService   = new UserInForServies();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user    = (User) session.getAttribute("user");
        File tempFile = null;

        try {
            Part filePart = request.getPart("avatar");
            if (filePart == null || filePart.getSize() == 0) {
                session.setAttribute("message", "Vui lòng chọn file ảnh.");
                session.setAttribute("messageType", "error");
                response.sendRedirect(request.getContextPath() + "/profile.jsp");
                return;
            }

            // Kiểm tra định dạng JPG/PNG
            String contentType = filePart.getContentType();
            if (!"image/jpeg".equals(contentType) && !"image/png".equals(contentType)) {
                session.setAttribute("message", "Chỉ hỗ trợ định dạng ảnh JPG hoặc PNG.");
                session.setAttribute("messageType", "error");
                response.sendRedirect(request.getContextPath() + "/profile.jsp");
                return;
            }

            // Tạo tên file duy nhất giữ extension
            String submitted = filePart.getSubmittedFileName();
            String ext       = submitted.substring(submitted.lastIndexOf('.'));
            String unique    = "avatar_" + user.getId() + "_" + UUID.randomUUID() + ext;

            // Lưu vào temp
            tempFile = File.createTempFile("upload_", ext);
            filePart.write(tempFile.getAbsolutePath());

            // Upload lên Cloudinary
            String avatarUrl = uploadService.uploadCloud(unique, tempFile);
            if (avatarUrl == null) {
                session.setAttribute("message", "Upload ảnh thất bại, vui lòng thử lại.");
                session.setAttribute("messageType", "error");
                response.sendRedirect(request.getContextPath() + "/profile.jsp");
                return;
            }

            // Cập nhật DB
            if (!userService.updateAvatar(user.getId(), avatarUrl)) {
                session.setAttribute("message", "Cập nhật avatar thất bại.");
                session.setAttribute("messageType", "error");
            } else {
                // Cập nhật session để hiển thị ngay
                user.setPicture(avatarUrl);
                session.setAttribute("user", user);
                session.setAttribute("message", "Cập nhật avatar thành công!");
                session.setAttribute("messageType", "success");
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("message", "Có lỗi xảy ra khi tải lên avatar.");
            session.setAttribute("messageType", "error");
        } finally {
            if (tempFile != null && tempFile.exists()) {
                tempFile.delete();
            }
            // Luôn redirect về profile
            response.sendRedirect(request.getContextPath() + "/profile.jsp");
        }
    }
}