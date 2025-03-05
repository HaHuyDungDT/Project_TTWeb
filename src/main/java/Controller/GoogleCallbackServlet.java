package Controller;

import Model.User;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.gson.GsonFactory;
import org.json.JSONObject;
import service.IUserService;
import service.impl.userServiceImpl;
import utils.SessionUtil;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.security.GeneralSecurityException;
import java.util.Collections;

@WebServlet("/google-callback")
public class GoogleCallbackServlet extends HttpServlet {

    // Lấy thông tin từ biến môi trường
    private static final String CLIENT_ID = System.getenv("GOOGLE_CLIENT_ID");
    private static final String CLIENT_SECRET = System.getenv("GOOGLE_CLIENT_SECRET");
    private static final String REDIRECT_URI = System.getenv("REDIRECT_URI");

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String code = request.getParameter("code");

        if (code != null) {
            // Truy cập token từ Google
            String tokenEndpoint = "https://oauth2.googleapis.com/token";
            URL url = new URL(tokenEndpoint);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);

            String postParams = "code=" + code
                    + "&client_id=" + CLIENT_ID
                    + "&client_secret=" + CLIENT_SECRET
                    + "&redirect_uri=" + URLEncoder.encode(REDIRECT_URI, "UTF-8")
                    + "&grant_type=authorization_code";

            try (OutputStream os = conn.getOutputStream()) {
                os.write(postParams.getBytes());
                os.flush();
            }

            int responseCode = conn.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) {
                // Xử lý token và lấy thông tin người dùng
                try (BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()))) {
                    StringBuilder content = new StringBuilder();
                    String inputLine;
                    while ((inputLine = in.readLine()) != null) {
                        content.append(inputLine);
                    }

                    JSONObject tokenResponse = new JSONObject(content.toString());
                    String idToken = tokenResponse.getString("id_token");
                    GoogleIdTokenVerifier verifier = new GoogleIdTokenVerifier.Builder(new NetHttpTransport(), new GsonFactory())
                            .setAudience(Collections.singletonList(CLIENT_ID))
                            .build();

                    GoogleIdToken idTokenObj = null;
                    try {
                        idTokenObj = verifier.verify(idToken);
                    } catch (GeneralSecurityException e) {
                        throw new RuntimeException(e);
                    }
                    if (idTokenObj != null) {
                        GoogleIdToken.Payload payload = idTokenObj.getPayload();
                        String email = payload.getEmail();
                        String name = (String) payload.get("name");
                        String picture = (String) payload.get("picture");

                        // Tạo hoặc lấy người dùng
                        IUserService userService = new userServiceImpl();
                        User existingUser = userService.getByUsername(email);

                        if (existingUser != null) {
                            // Lưu thông tin người dùng vào phiên
                            SessionUtil.getInstance().putKey(request, "userEmail", email);
                            SessionUtil.getInstance().putKey(request, "userName", name);
                            SessionUtil.getInstance().putKey(request, "userPicture", picture);
                            SessionUtil.getInstance().putKey(request, "user", existingUser.getId());
                        } else {
                            // Tạo người dùng mới
                            User newUser = new User();
                            newUser.setId(userService.createId());
                            newUser.setEmail(email);
                            newUser.setName(name);
                            newUser.setUser_name(email.split("@")[0]);
                            newUser.setPassword("");
                            newUser.setSex("Unknown");
                            newUser.setAddress("Unknown");
                            newUser.setPhone_number("Unknown");
                            newUser.setRole_idStr("0");

                            userService.addGoogleUser(newUser);

                            // Lưu thông tin người dùng mới vào phiên
                            SessionUtil.getInstance().putKey(request, "userEmail", email);
                            SessionUtil.getInstance().putKey(request, "userName", name);
                            SessionUtil.getInstance().putKey(request, "user", newUser.getId());
                        }
                        response.sendRedirect("index.jsp");
                    } else {
                        response.getWriter().write("ID Token không hợp lệ.");
                    }
                }
            } else {
                response.getWriter().write("Đăng nhập thất bại: " + conn.getResponseMessage());
            }
        } else {
            response.getWriter().write("Đăng nhập thất bại: Không tìm thấy mã xác thực.");
        }
    }
}

