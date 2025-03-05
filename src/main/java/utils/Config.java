package utils;

public class Config {

    public static String getClientId() {
        return System.getenv("GOOGLE_CLIENT_ID"); // Lấy giá trị từ biến môi trường
    }

    public static String getClientSecret() {
        return System.getenv("GOOGLE_CLIENT_SECRET"); // Lấy giá trị từ biến môi trường
    }

    public static String getRedirectUri() {
        return System.getenv("REDIRECT_URI"); // Lấy giá trị từ biến môi trường
    }
}

