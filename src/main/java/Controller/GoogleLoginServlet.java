package Controller;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;

@WebServlet("/google-login")
public class GoogleLoginServlet extends HttpServlet {

    // Lấy thông tin từ biến môi trường
    private static final String CLIENT_ID = System.getenv("GOOGLE_CLIENT_ID");
    private static final String CLIENT_SECRET = System.getenv("GOOGLE_CLIENT_SECRET");
    private static final String REDIRECT_URI = System.getenv("REDIRECT_URI");

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String redirectUri = System.getenv("REDIRECT_URI");
        if (redirectUri == null) {
            throw new IllegalStateException("REDIRECT_URI môi trường không được thiết lập");
        }
        String googleAuthUrl = "https://accounts.google.com/o/oauth2/auth"
                + "?client_id=" + CLIENT_ID
                + "&redirect_uri=" + URLEncoder.encode(REDIRECT_URI, "UTF-8")
                + "&response_type=code"
                + "&scope=openid email profile";

        // Chuyển hướng người dùng đến trang đăng nhập của Google
        response.sendRedirect(googleAuthUrl);
    }
}

