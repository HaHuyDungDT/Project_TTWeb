package service.impl;

import dao.IUserDao;
import dao.impl.UserDaoImpl;
import db.JDBIConnector;
import model.User;
import org.mindrot.jbcrypt.BCrypt;
import service.IUserService;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

public class UserServiceImpl implements IUserService {
    private IUserDao userDao = new UserDaoImpl(); // tách ra thành field (không tạo mỗi lần)

    @Override
    public boolean login(String username, String password) {
        IUserDao userDao = new UserDaoImpl();
        User user = userDao.getUserByUserName(username);
        if (user == null) {
            return false;
        }
        // So sánh mật khẩu nhập với mật khẩu đã băm trong DB
        return BCrypt.checkpw(password, user.getPassword());
    }

    @Override
    public String register(User user) {
        try {
            // Băm mật khẩu trước khi lưu
            String hashedPassword = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
            user.setPassword(hashedPassword);
            IUserDao userDao = new UserDaoImpl();
            boolean result = userDao.register(user);

            System.out.println("Đăng ký user? " + result);
            return result ? "registered" : null;
        } catch (Exception e) {
            e.printStackTrace(); // In lỗi cụ thể
            return null;
        }
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
        return userDao.getUserByUserId(id);
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
        String sql = "SELECT id, username, password, oauth_provider, oauth_uid, oauth_token, name, email, role_id, created_at, updated_at, status, phone, birth, gender, address FROM users WHERE status = 1";

        return JDBIConnector.getConnect().withHandle(handle -> {
            // Tạo danh sách user bằng ánh xạ thủ công
            return handle.createQuery(sql)
                    .map((rs, ctx) -> {
                        // Ánh xạ thủ công từng trường vào đối tượng User
                        User user = new User();
                        user.setId(rs.getInt("id"));
                        user.setUsername(rs.getString("username"));
                        user.setPassword(rs.getString("password"));
                        user.setOauthProvider(rs.getString("oauth_provider"));
                        user.setOauthUid(rs.getString("oauth_uid"));
                        user.setOauthToken(rs.getString("oauth_token"));
                        user.setName(rs.getString("name"));
                        user.setEmail(rs.getString("email"));
                        user.setRoleId(rs.getInt("role_id"));
                        user.setCreatedAt(rs.getObject("created_at", LocalDateTime.class));
                        user.setUpdatedAt(rs.getObject("updated_at", LocalDateTime.class));
                        user.setStatus(rs.getInt("status"));
                        user.setPhone(rs.getString("phone"));
                        user.setBirth(rs.getObject("birth", LocalDate.class));
                        user.setGender(rs.getString("gender"));
                        user.setAddress(rs.getString("address"));
                        // Các trường chưa triển khai
                        user.setSecretKey(null);  // Ánh xạ thủ công giá trị mặc định là null
                        user.setTwoFaEnabled(false);  // Giá trị mặc định là false
                        user.setPicture(null);  // Giá trị mặc định là null
                        return user;
                    })
                    .list();
        });
    }

    @Override
    public void deleteById(Integer id) {
        userDao.deleteById(id);
    }

    @Override
    public boolean update(User user) {
//        try {
//            int rowsAffected = JDBIConnector.getConnect().withHandle(handle -> {
//                return handle.createUpdate("UPDATE users SET password = ?, updated_at = ?, secret_key = ?, twoFaEnabled = ? WHERE id = ?")
//                        .bind(0, user.getPassword())
//                        .bind(1, java.sql.Timestamp.valueOf(user.getUpdatedAt()))
//                        .bind(2, user.getSecretKey())
//                        .bind(3, user.isTwoFaEnabled())
//                        .bind(4, user.getId())
//                        .execute();
//            });
//            return rowsAffected > 0;
//        } catch (Exception e) {
//            e.printStackTrace();
//            return false;
//        }
        return userDao.update(user);
    }

    @Override
    public boolean add(User user) {


        String hashedPassword = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
        user.setPassword(hashedPassword);
        return userDao.register(user); // đơn giản hơn

    }

    @Override
    public boolean addGoogleUser(User newUser) {
        IUserDao userDao = new UserDaoImpl();
        boolean result = userDao.addGoogleUser(newUser);
        if(result) {
            System.out.println("Google user registration successful");
        } else {
            System.err.println("Google user registration failed");
        }
        return result;
    }

    // Phương thức bổ sung để thêm tài khoản Facebook vào DB
    @Override
    public boolean addFacebookUser(User newUser) {
        IUserDao userDao = new UserDaoImpl();
        boolean result = userDao.addFacebookUser(newUser);
        if(result) {
            System.out.println("Facebook user registration successful");
        } else {
            System.err.println("Facebook user registration failed");
        }
        return result;
    }

    @Override
    public void updateInfo(Integer id, String newEmail, String name, String phone) {
        try {
            boolean ok = userDao.updateInfo(id, newEmail, name, phone);
            if (!ok) {
                // Không cập nhật được, có thể throw exception hoặc log
                throw new RuntimeException("Cập nhật thông tin thất bại cho user id=" + id);
            }
        } catch (Exception e) {
            // Ghi log lỗi và rethrow nếu cần
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public String createId() {
        return UUID.randomUUID().toString();
    }

    @Override
    public boolean isUserLocked(String username) {
        return false;
    }

    @Override
    public User getByOAuthUser(String id) {
        IUserDao userDao = new UserDaoImpl();
        return userDao.getByOAuthUser(id);
    }
}