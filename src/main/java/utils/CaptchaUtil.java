package utils;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import org.json.JSONObject;

public class CaptchaUtil {
    // Lấy secret key từ file sensitive.properties thông qua ConfigLoader
    private static final String SECRET_KEY = ConfigLoader.getProperty("captcha.secretKey");
    private static final String VERIFY_URL = "https://www.google.com/recaptcha/api/siteverify";

    public static boolean verifyCaptcha(String captchaResponse) {
        if (captchaResponse == null || captchaResponse.trim().isEmpty()) {
            System.out.println("Captcha response rỗng.");
            return false;
        }
        try {
            URL url = new URL(VERIFY_URL);
            HttpURLConnection con = (HttpURLConnection) url.openConnection();
            con.setRequestMethod("POST");
            con.setDoOutput(true);

            String postParams = "secret=" + SECRET_KEY + "&response=" + captchaResponse;
            try (OutputStream os = con.getOutputStream()) {
                os.write(postParams.getBytes("UTF-8"));
                os.flush();
            }

            int responseCode = con.getResponseCode();
            System.out.println("HTTP Response Code: " + responseCode);
            if (responseCode != HttpURLConnection.HTTP_OK) {
                System.err.println("Lỗi khi kết nối đến reCAPTCHA API");
                return false;
            }

            StringBuilder responseStr = new StringBuilder();
            try (BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"))) {
                String line;
                while ((line = in.readLine()) != null) {
                    responseStr.append(line);
                }
            }

            JSONObject jsonObject = new JSONObject(responseStr.toString());
            System.out.println("ReCAPTCHA response JSON: " + jsonObject.toString());
            return jsonObject.getBoolean("success");
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}