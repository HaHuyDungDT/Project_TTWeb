package utils;

public class Constants {
    // Thay bằng Client ID/Secret mới do bạn tạo trên Google Console
    public static final String GOOGLE_CLIENT_ID     = "..";
    public static final String GOOGLE_CLIENT_SECRET = "..";
    // Phải đúng với redirect URI bạn khai báo trong Google API Console
    public static final String GOOGLE_REDIRECT_URI  = "https://hadung6765.id.vn/google-callback";

    public static final String GOOGLE_LINK_GET_TOKEN     = "https://accounts.google.com/o/oauth2/token";
    public static final String GOOGLE_LINK_GET_USER_INFO = "https://www.googleapis.com/oauth2/v1/userinfo?access_token=";
    public static final String GOOGLE_GRANT_TYPE         = "authorization_code";
}