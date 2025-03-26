package service;

import model.User;

import java.util.List;

public interface IUserService {
    boolean login(String username, String password);
    String register(model.User user);
    boolean isUsernameExists(String username);
    String getIdByUsername(String username);
    model.User getByUsername(String username);
    model.User getById(String id);
    boolean isEmailExists(String email);
    void resetPass(String email, String password);
    List<model.User> findAll();
    void deleteById(String id);
    void update(model.User user);
    void add(model.User user, String role);

    void addGoogleUser(model.User newUser);

    String createId();
    boolean isUserLocked(String username);
}
