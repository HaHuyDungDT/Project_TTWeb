package service;

import dao.UserDAO;
import model.User;
import db.JDBIConector;

import java.sql.SQLException;
import java.util.List;

public class UserService {
    private static UserService instance;

    public static UserService getInstance() {
        if (instance == null)
            instance = new UserService();
        return instance;
    }

    public User checkLogin(String email, String pass) throws SQLException {
        UserDAO userDAO = new UserDAO();
        User userByEmail = userDAO.getUserByEmail(email);
        if (userByEmail == null || !userByEmail.getPassword().equals(pass)) {
            return null;
        }
        return userByEmail;
    }

    public List<User> getAllUsers() {
        return JDBIConector.me().withHandle(handle ->
                handle.createQuery("SELECT id, username, password, oauth_provider, oauth_uid, oauth_token, name, email, role_id, created_at, updated_at, status FROM users")
                        .map((rs, ctx) -> new User(
                                rs.getInt("id"),
                                rs.getString("username"),
                                rs.getString("password"),
                                rs.getString("oauth_provider"),
                                rs.getString("oauth_uid"),
                                rs.getString("oauth_token"),
                                rs.getString("name"),
                                rs.getString("email"),
                                rs.getInt("role_id"),
                                rs.getTimestamp("created_at").toLocalDateTime(),
                                rs.getTimestamp("updated_at").toLocalDateTime(),
                                rs.getInt("status")
                        ))
                        .list()
        );
    }


    public static void main(String[] args) throws SQLException {
        List<User> users = UserService.getInstance().getAllUsers();
        users.forEach(System.out::println);
    }
}