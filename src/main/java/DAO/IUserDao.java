package DAO;

import Model.User;

import java.util.List;

public interface IUserDao {
    boolean login(User item);
    User register(User item);
    String getIdTop1();
    boolean isUsernameExists(String username);
    String getIdByUsername(String username);
    User getByUsername(String username);
    User getById(String username);
    boolean isEmailExists(String email);
    void resetPass(String email, String password);
    List<User> findAll();
    void deleteById(String id);
    void update(User user);
    void add(User user);
    // Thêm phương thức để thêm người dùng qua Google

    void addGoogleUser(User user);
}

