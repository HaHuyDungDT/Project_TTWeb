package Controller;

import model.User;
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
import java.time.LocalDateTime;
import java.util.Collections;

@WebServlet("/google-callback")
public class GoogleCallbackServlet extends HttpServlet {

    private static final String CLIENT_ID = System.getenv("GOOGLE_CLIENT_ID");
    private static final String CLIENT_SECRET = System.getenv("GOOGLE_CLIENT_SECRET");
    private static final String REDIRECT_URI = System.getenv("REDIRECT_URI");

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String code = request.getParameter("code");

        if (code != null) {
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

            if (conn.getResponseCode() == HttpURLConnection.HTTP_OK) {
                try (BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()))) {
                    StringBuilder content = new StringBuilder();
                    String inputLine;
                    while ((inputLine = in.readLine()) != null) {
                        content.append(inputLine);
                    }

                    JSONObject tokenResponse = new JSONObject(content.toString());
                    String idToken = tokenResponse.getString("id_token");

                    GoogleIdTokenVerifier verifier = new GoogleIdTokenVerifier.Builder(new NetHttpTransport(), new GsonFactory())
                            .setAudience(Collections.singletonList(CLIENT_ID)).build();

                    GoogleIdToken idTokenObj;
                    try {
                        idTokenObj = verifier.verify(idToken);
                    } catch (GeneralSecurityException e) {
                        throw new RuntimeException(e);
                    }

                    if (idTokenObj != null) {
                        GoogleIdToken.Payload payload = idTokenObj.getPayload();
                        String email = payload.getEmail();
                        String name = (String) payload.get("name");

                        IUserService userService = new userServiceImpl();
                        User existingUser = userService.getByUsername(email);

                        if (existingUser != null) {
                            SessionUtil.getInstance().putKey(request, "user", existingUser);
                        } else {
                            User newUser = new User();
                            newUser.setUsername(email.split("@")[0]);
                            newUser.setPassword("");
                            newUser.setOauthProvider("google");
                            newUser.setOauthUid(payload.getSubject());
                            newUser.setOauthToken(idToken);
                            newUser.setName(name);
                            newUser.setEmail(email);
                            newUser.setRoleId(0);
                            newUser.setCreatedAt(LocalDateTime.now());
                            newUser.setUpdatedAt(LocalDateTime.now());
                            newUser.setStatus(1);

                            userService.addGoogleUser(newUser);

                            SessionUtil.getInstance().putKey(request, "user", newUser);
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
