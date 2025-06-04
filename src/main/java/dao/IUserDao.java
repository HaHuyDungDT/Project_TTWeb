package dao;

import model.User;

import java.time.LocalDate;
import java.util.List;

public interface IUserDao {
    boolean login(String username, String password);
    boolean register(User user);

    boolean updateAvatar(int idUser, String path);

    boolean updateInfo(int idUser, String email, String name, String phone);

    boolean isUserNameExists(String username);
    String getIdByUserName(String username);
    User getUserByUserName(String username);
    User getUserByUserId(Integer userId);
    boolean isEmailExists(String email);
    void resetPass(String email, String password);
    List<User> findAll();
    void deleteById(Integer id);
    boolean update(User user);
    User isUserExists(String oauthProvider, String oauthUid);
    User getByOAuthUser(String oauthUid);
    boolean addGoogleUser(User user);
    boolean addFacebookUser(User user);
    boolean updateProfile(int id, String username, String name,
                          String email, String phone,
                          String gender, LocalDate birth);
    // Update updateAddress method: sử dụng userId và các thành phần địa chỉ để tạo chuỗi fullAddress.
    boolean updateAddress(int userId, String province, String city, String commune, String street);
    boolean updateRole(int userId, int newRoleId);
}