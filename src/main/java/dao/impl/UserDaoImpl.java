package dao.impl;

import dao.IUserDao;
import db.JDBIConnector;
import model.User;

import java.sql.Timestamp;
import java.util.List;

public class UserDaoImpl implements IUserDao {
    private static final String SELECT_USER = "SELECT id, username, password, name, email, created_at, updated_at, role_id, status FROM users";

    Timestamp currentTimestamp = new Timestamp(System.currentTimeMillis()); // ngày giờ hiện tại

    @Override
    public boolean login(String username, String password) {
        return true;
    }

    @Override
    public boolean register(User user) {
        int rowsAffected = JDBIConnector.getConnect().withHandle(handle -> {
            return handle.createUpdate("INSERT INTO users(username, password, name, email, created_at, updated_at, role_id, status, oauth_provider, oauth_uid, oauth_token) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)")
                    .bind(0, user.getUsername())
                    .bind(1, user.getPassword())
                    .bind(2, user.getName())
                    .bind(3, user.getEmail())
                    .bind(4, currentTimestamp)
                    .bind(5, currentTimestamp)
                    .bind(6, user.getRoleId())
                    .bind(7, user.getStatus())
                    .bind(8, user.getOauthProvider())
                    .bind(9, user.getOauthUid())
                    .bind(10, user.getOauthToken())
                    .execute();

        });
        return rowsAffected > 0;
    }


    @Override
    public boolean isUserNameExists(String username) {
        int count = JDBIConnector.getConnect().withHandle(handle ->
                handle.createQuery("SELECT COUNT(*) FROM users WHERE username = :username")
                        .bind("username", username)
                        .mapTo(Integer.class)
                        .one()
        );
        return count > 0;
    }

    @Override
    public String getIdByUserName(String username) {
        return "";
    }

    @Override
    public User getUserByUserName(String username) {
        User user = JDBIConnector.getConnect().withHandle(handle -> {
            return handle.createQuery(SELECT_USER + " WHERE username = :username")
                    .bind("username", username)
                    .mapToBean(User.class)
                    .findFirst()
                    .orElse(null);
        });
        return user;
    }

    public static void main(String[] args) {
        IUserDao userDao = new UserDaoImpl();
        User user = userDao.getUserByUserName("admin");
        System.out.println(user);
    }

    @Override
    public User getUserByUserId(Integer userId) {
        User user = JDBIConnector.getConnect().withHandle(handle -> {
            return handle.createQuery(SELECT_USER + " WHERE id = :userId")
                    .bind("userId", userId)
                    .mapToBean(User.class)
                    .findFirst()
                    .orElse(null);
        });
        return user;
    }


    @Override
    public boolean isEmailExists(String email) {
        int count = JDBIConnector.getConnect().withHandle(handle ->
                handle.createQuery("SELECT COUNT(*) FROM users WHERE email = :email")
                        .bind("email", email)
                        .mapTo(Integer.class)
                        .one()
        );
        return count > 0;
    }

    @Override
    public void resetPass(String email, String password) {

    }

    @Override
    public List<User> findAll() {
        List<User> users = JDBIConnector.getConnect().withHandle(handle -> {
            return handle.createQuery(SELECT_USER)
                    .mapToBean(User.class)
                    .list();
        });
        return users;
    }

    @Override
    public void deleteById(Integer id) {
        JDBIConnector.getConnect().useHandle(handle ->
                handle.createUpdate("UPDATE users SET status = 0 WHERE id = :id")
                        .bind("id", id)
                        .execute()
        );
    }

    @Override
    public boolean update(User user) {
        int rowsAffected = JDBIConnector.getConnect().withHandle(handle -> {
            return handle.createUpdate("INSERT INTO users(username, password, name, email, updatedAt, role_id) VALUES (?, ?, ?, ?, ?, ?)")
                    .bind(0, user.getUsername())
                    .bind(1, user.getPassword())
                    .bind(2, user.getName())
                    .bind(3, user.getEmail())
                    .bind(4, currentTimestamp)
                    .bind(5, 1)
                    .execute();

        });
        return rowsAffected > 0;
    }

    @Override
    public User isUserExists(String oauthProvider, String oauthUid) {
        User user = JDBIConnector.getConnect().withHandle(handle -> {
            return handle.createQuery(SELECT_USER + " WHERE oauth_provider = :oauthProvider AND oauth_uid = :oauthUid")
                    .bind("oauthProvider", oauthProvider)
                    .bind("oauthUid", oauthUid)
                    .mapToBean(User.class)
                    .findFirst()
                    .orElse(null);
        });
        return user;
    }

}