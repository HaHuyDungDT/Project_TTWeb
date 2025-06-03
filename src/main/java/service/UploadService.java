package service;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;

import java.io.File;
import java.util.Map;

public class UploadService {
    private final Cloudinary cloudinary;

    public UploadService() {
        // Tạo Cloudinary instance với cấu hình hard-code cho local testing
        this.cloudinary = createCloudinary();
    }

    private Cloudinary createCloudinary() {
        // Lưu ý: Hard-code các key nhạy cảm chỉ dùng cho testing local. Không sử dụng trong production.
        String cloudName = "dhhvmdtcz";
        String apiKey = "824244389152141";
        String apiSecret = "4hNp7VpB29IDLzteZCIpHlOai8A";

        return new Cloudinary(ObjectUtils.asMap(
                "cloud_name", cloudName,
                "api_key", apiKey,
                "api_secret", apiSecret
        ));
    }

    public String uploadCloud(String fileName, File file) {
        if (file == null || !file.exists()) {
            System.err.println("File không tồn tại hoặc null.");
            return null;
        }

        try {
            Map<String, Object> uploadOptions = ObjectUtils.asMap(
                    "upload_preset", "avatar_upload",
                    "public_id", fileName,
                    "folder", "users/avatars"
            );

            Map<String, Object> uploadResult = cloudinary.uploader().upload(file, uploadOptions);

            if (uploadResult.containsKey("secure_url")) {
                String imageUrl = (String) uploadResult.get("secure_url");
                System.out.println("Upload thành công! URL: " + imageUrl);
                return imageUrl;
            } else {
                System.err.println("Upload thất bại! Không tìm thấy secure_url.");
                return null;
            }
        } catch (Exception e) {
            System.err.println("Có lỗi xảy ra khi tải lên Cloudinary:");
            e.printStackTrace();
            return null;
        }
    }

    public static void main(String[] args) {
        String cloudName = "your_cloud_name";
        System.out.println(cloudName);
    }
}