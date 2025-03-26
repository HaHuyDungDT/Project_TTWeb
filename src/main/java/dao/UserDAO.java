package dao;

import dao.impl.DAOInterface;
import model.User;
import db.JDBIConector;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

public class UserDAO implements DAOInterface<User> {

    @Override
    public List<User> selectAll() {
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

    public User getUserByEmail(String email) {
        Optional<User> user = JDBIConector.me().withHandle(handle ->
                handle.createQuery("SELECT id, username, password, oauth_provider, oauth_uid, oauth_token, name, email, role_id, created_at, updated_at, status FROM users WHERE email = ?")
                        .bind(0, email)
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
                        .findFirst()
        );
        return user.orElse(null);
    }

    @Override
    public User selectById(User userP) {
        return getById(userP.getId());
    }

    public User getById(Integer userId) {
        Optional<User> user = JDBIConector.me().withHandle(handle ->
                handle.createQuery("SELECT id, username, password, oauth_provider, oauth_uid, oauth_token, name, email, role_id, created_at, updated_at, status FROM users WHERE id = ?")
                        .bind(0, userId)
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
                        .findFirst()
        );
        return user.orElse(null);
    }

    @Override
    public int insert(User user) {
        return JDBIConector.me().withHandle(handle ->
                handle.createUpdate("INSERT INTO users (username, password, oauth_provider, oauth_uid, oauth_token, name, email, role_id, created_at, updated_at, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)")
                        .bind(0, user.getUsername())
                        .bind(1, user.getPassword())
                        .bind(2, user.getOauthProvider())
                        .bind(3, user.getOauthUid())
                        .bind(4, user.getOauthToken())
                        .bind(5, user.getName())
                        .bind(6, user.getEmail())
                        .bind(7, user.getRoleId())
                        .bind(8, user.getCreatedAt())
                        .bind(9, user.getUpdatedAt())
                        .bind(10, user.getStatus())
                        .execute()
        );
    }

    @Override
    public int update(User user) {
        return JDBIConector.me().withHandle(handle ->
                handle.createUpdate("UPDATE users SET username=?, password=?, oauth_provider=?, oauth_uid=?, oauth_token=?, name=?, email=?, role_id=?, updated_at=?, status=? WHERE id=?")
                        .bind(0, user.getUsername())
                        .bind(1, user.getPassword())
                        .bind(2, user.getOauthProvider())
                        .bind(3, user.getOauthUid())
                        .bind(4, user.getOauthToken())
                        .bind(5, user.getName())
                        .bind(6, user.getEmail())
                        .bind(7, user.getRoleId())
                        .bind(8, LocalDateTime.now())
                        .bind(9, user.getStatus())
                        .bind(10, user.getId())
                        .execute()
        );
    }

    @Override
    public int delete(User user) {
        return JDBIConector.me().withHandle(handle ->
                handle.createUpdate("DELETE FROM users WHERE id=?")
                        .bind(0, user.getId())
                        .execute()
        );
    }

    public static void main(String[] args) {
        UserDAO userDAO = new UserDAO();
        List<User> users = userDAO.selectAll();
        users.forEach(System.out::println);
    }
}