package service.impl;

import dao.IUserDao;
import dao.impl.UserDaoImpl;
import db.JDBIConnector;
import model.User;
import org.mindrot.jbcrypt.BCrypt;
import service.IUserService;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

public class UserServiceImpl implements IUserService {
    IUserDao userDao = new UserDaoImpl();

    @Override
    public boolean login(String username, String password) {
        User user = userDao.getUserByUserName(username);
        if (user == null) {
            return false;
        }
        // So sánh mật khẩu nhập với mật khẩu đã băm trong DB
        return BCrypt.checkpw(password, user.getPassword());
    }


    @Override
    public String register(User user) {
        // Băm mật khẩu trước khi lưu
        String hashedPassword = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
        user.setPassword(hashedPassword);
        IUserDao userDao = new UserDaoImpl();
        boolean result = userDao.register(user);
        return result ? "registered" : null;
    }

    @Override
    public boolean isUsernameExists(String username) {
        IUserDao userDao = new UserDaoImpl();
        return userDao.isUserNameExists(username);
    }

    @Override
    public String getIdByUsername(String username) {
        // TODO: triển khai
        return "";
    }

    @Override
    public User getByUsername(String username) {
        IUserDao userDao = new UserDaoImpl();
        return userDao.getUserByUserName(username);
    }

    @Override
    public User getById(Integer id) {
        return userDao.getUserByUserId(id); // Gọi phương thức getUserByUserId từ DAO

    }

    @Override
    public boolean isEmailExists(String email) {
        IUserDao userDao = new UserDaoImpl();
        return userDao.isEmailExists(email);
    }

    @Override
    public void resetPass(String email, String password) {
        try {
            // Băm mật khẩu mới trước khi update vào DB
            String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
            int rowsAffected = JDBIConnector.getConnect().withHandle(handle -> {
                return handle.createUpdate("UPDATE users SET password = ?, updated_at = ? WHERE email = ?")
                        .bind(0, hashedPassword)
                        .bind(1, new Timestamp(System.currentTimeMillis()))
                        .bind(2, email)
                        .execute();
            });
            if (rowsAffected == 0) {
                System.out.println("Reset pass update failed for email: " + email);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<User> findAll() {
        return List.of();
    }

    @Override
    public void deleteById(Integer id) {
        userDao.deleteById(id); // Gọi phương thức deleteById từ DAO

    }
    @Override
    public boolean update(User user) {
        try {
            int rowsAffected = JDBIConnector.getConnect().withHandle(handle -> {
                return handle.createUpdate("UPDATE users SET password = ?, updated_at = ?, secret_key = ?, twoFaEnabled = ? WHERE id = ?")
                        .bind(0, user.getPassword())
                        .bind(1, java.sql.Timestamp.valueOf(user.getUpdatedAt()))
                        .bind(2, user.getSecretKey())
                        .bind(3, user.isTwoFaEnabled())
                        .bind(4, user.getId())
                        .execute();
            });
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public void add(User user, String role) {
//        if(userDao.isEmailExists(user.getEmail()) || userDao.isUserNameExists(user.getUsername())) {
//            throw new RuntimeException("Email hoặc Username đã tồn tại");
//        }
        // Băm mật khẩu trước khi lưu
//        String hashedPassword = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
//        user.setPassword(hashedPassword);
        user.setCreatedAt(LocalDateTime.now());
        user.setUpdatedAt(LocalDateTime.now());
        user.setStatus(1); // Mặc định kích hoạt
        userDao.register(user);
        // Có thể thêm logic gửi email chào mừng ở đây

    }

    @Override
    public void addGoogleUser(User newUser) {

    }

    @Override
    public String createId() {
        return UUID.randomUUID().toString();
    }

    @Override
    public boolean isUserLocked(String username) {
        return false;
    }
}