package model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.jetbrains.annotations.Nullable;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class User {
    private Integer id;
    private String username;
    private String password;
    @Nullable
    private String oauthProvider;
    @Nullable
    private String oauthUid;
    @Nullable
    private String oauthToken;
    private String name;
    private String email;
    private String phone; // Thêm trường số điện thoại
    private LocalDate birth; // Thêm trường ngày sinh
    private String gender; // Thêm trường giới tính
    private String address;
    private Integer roleId;
    private LocalDateTime createdAt;
    @Nullable
    private LocalDateTime updatedAt;
    private Integer status;
    // 2FA
    private String secretKey;
    private boolean twoFaEnabled;
}