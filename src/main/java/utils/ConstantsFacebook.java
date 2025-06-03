package utils;

public class ConstantsFacebook {
    public static final String FACEBOOK_APP_ID = getEnvVar("1634221603925099");
    public static final String FACEBOOK_APP_SECRET = getEnvVar("5541b98424eb613ddad914bea004e10b");
    public static final String FACEBOOK_REDIRECT_URL = getEnvVar("FACEBOOK_REDIRECT_URL");
    public static final String FACEBOOK_LINK_GET_TOKEN = "https://graph.facebook.com/oauth/access_token?client_id=%s&client_secret=%s&redirect_uri=%s&code=%s";

    private static String getEnvVar(String varName) {
        String value = System.getenv(varName);
        if (value == null || value.isEmpty()) {
            throw new RuntimeException("Biến môi trường " + varName + " không được thiết lập hoặc rỗng!");
        }
        return value;
    }
}
