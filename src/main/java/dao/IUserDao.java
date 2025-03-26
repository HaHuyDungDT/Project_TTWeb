package dao;

import model.User;

import java.util.List;

public interface IUserDao {
    boolean login(String username, String password);
    boolean register(User user);
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
}
