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
    @Nullable private String oauthProvider;
    @Nullable private String oauthUid;
    @Nullable private String oauthToken;
    private String name;
    private String email;
    private Integer roleId;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private Integer status;
    private String phone;    // Số điện thoại/
    private LocalDate birth; // Ngày sinh/
    private String gender;   // Giới tính/
    private String address;  // Địa chỉ/
    // 2FA
    @Nullable private String secretKey;
    private boolean twoFaEnabled;
    @Nullable private String picture;
}