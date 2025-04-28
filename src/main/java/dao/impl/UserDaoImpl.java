package dao.impl;

import dao.IUserDao;
import db.JDBIConnector;
import model.User;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;

public class UserDaoImpl implements IUserDao {
    private static final String SELECT_USER = "SELECT id, username, password, oauth_provider, oauth_uid, oauth_token, name, email, role_id, created_at, updated_at, status, phone, birth, gender, address, secretKey, twoFaEnabled, picture FROM users";
    Timestamp currentTimestamp = new Timestamp(System.currentTimeMillis());

    @Override
    public boolean login(String username, String password) {
        return true;
    }

    @Override
    public boolean register(User user) {
        System.out.println("Đang insert user vào DB...");
        System.out.println(user);
        try {
            int rowsAffected = JDBIConnector.getConnect().withHandle(handle -> {
//                return handle.createUpdate("INSERT INTO users(username, password, oauth_provider, oauth_uid, oauth_token, name, email, picture, role_id, created_at, updated_at, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)")

                return handle.createUpdate("INSERT INTO users(username, password, oauth_provider, oauth_uid, oauth_token, name, email, role_id, created_at, updated_at, status, phone, birth, gender, address, secretKey, twoFaEnabled, picture) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)")
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
                        .bind(11, user.getPhone())
                        .bind(12, user.getBirth())
                        .bind(13, user.getGender())
                        .bind(14, user.getAddress())
                        .bind(15, user.getSecretKey())
                        .bind(16, user.isTwoFaEnabled())
                        .bind(17, user.getPicture())
                        .execute();

            });
            return rowsAffected > 0;
        } catch (Exception e) {
            System.err.println("❌ LỖI KHI INSERT:");
            e.printStackTrace(); // Xem lỗi SQL
            return false; // Trả về false nếu có lỗi
        }
    }

    @Override
    public boolean isUserNameExists(String username) {
        try {
            int count = JDBIConnector.getConnect().withHandle(handle ->
                    handle.createQuery("SELECT COUNT(*) FROM users WHERE username = :username")
                            .bind("username", username)
                            .mapTo(Integer.class)
                            .one()
            );
            return count > 0;
        } catch (Exception e) {
            e.printStackTrace(); // In lỗi để debug
            return false; // Trả về false nếu có lỗi
        }
    }

    @Override
    public String getIdByUserName(String username) {
        return "";
    }

    @Override
    public User getUserByUserName(String username) {
        try {
            return JDBIConnector.getConnect().withHandle(handle -> {
                return handle.createQuery(SELECT_USER + " WHERE username = :username")
                        .bind("username", username)
                        .mapToBean(User.class)
                        .findFirst()
                        .orElse(null);
            });
        } catch (Exception e) {
            e.printStackTrace(); // In lỗi để debug
            return null; // Trả về null nếu có lỗi
        }
    }

    @Override
    public User getUserByUserId(Integer userId) {
        return JDBIConnector.getConnect().withHandle(handle ->
                handle.createQuery("SELECT * FROM users WHERE id = :userId")
                        .bind("userId", userId)
                        .map((rs, ctx) -> {
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

                            Timestamp createdAt = rs.getTimestamp("created_at");
                            if (createdAt != null) {
                                user.setCreatedAt(createdAt.toLocalDateTime());
                            }

                            Timestamp updatedAt = rs.getTimestamp("updated_at");
                            if (updatedAt != null) {
                                user.setUpdatedAt(updatedAt.toLocalDateTime());
                            }

                            user.setStatus(rs.getInt("status"));
                            user.setPhone(rs.getString("phone"));

                            Date birthDate = rs.getDate("birth");
                            if (birthDate != null) {
                                user.setBirth(birthDate.toLocalDate());
                            }

                            user.setGender(rs.getString("gender"));
                            user.setAddress(rs.getString("address"));
                            user.setSecretKey(rs.getString("secretKey"));
                            user.setTwoFaEnabled(rs.getBoolean("twoFaEnabled"));
                            user.setPicture(rs.getString("picture"));

                            return user;
                        })
                        .findFirst()
                        .orElse(null)
        );
    }


    @Override
    public boolean isEmailExists(String email) {
        try {
            int count = JDBIConnector.getConnect().withHandle(handle ->
                    handle.createQuery("SELECT COUNT(*) FROM users WHERE email = :email")
                            .bind("email", email)
                            .mapTo(Integer.class)
                            .one()
            );
            return count > 0;
        } catch (Exception e) {
            e.printStackTrace(); // In lỗi để debug
            return false; // Trả về false nếu có lỗi
        }
    }

    @Override
    public void resetPass(String email, String password) {
        // TODO: Triển khai reset mật khẩu
    }

    @Override
    public List<User> findAll() {
        try {
            return JDBIConnector.getConnect().withHandle(handle -> {
                return handle.createQuery(SELECT_USER)
                        .mapToBean(User.class)
                        .list();
            });
        } catch (Exception e) {
            e.printStackTrace();
            return List.of();
        }
    }

    @Override
    public void deleteById(Integer id) {
        try {
            JDBIConnector.getConnect().useHandle(handle ->
                    handle.createUpdate("UPDATE users SET status = 0 WHERE id = :id")
                            .bind("id", id)
                            .execute()
            );
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public boolean update(User user) {
        try {
            int rowsAffected = JDBIConnector.getConnect().withHandle(handle -> {
                return handle.createUpdate("UPDATE users SET username = ?, password = ?, name = ?, email = ?, updated_at = ?, phone = ?, birth = ?, gender = ?, address = ? WHERE id = ?")
                        .bind(0, user.getUsername())
                        .bind(1, user.getPassword())
                        .bind(2, user.getName())
                        .bind(3, user.getEmail())
                        .bind(4, user.getUpdatedAt())
                        .bind(5, user.getPhone())
                        .bind(6, user.getBirth())
                        .bind(7, user.getGender())
                        .bind(8, user.getAddress())
                        .bind(9, user.getId())
                        .execute();
            });
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
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

    @Override
    public User getByOAuthUser(String oauthUid) {
        try {
            return JDBIConnector.getConnect().withHandle(handle ->
                    handle.createQuery(SELECT_USER + " WHERE oauth_uid = :oauthUid")
                            .bind("oauthUid", oauthUid)
                            .mapToBean(User.class)
                            .findFirst().orElse(null)
            );
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public boolean addGoogleUser(User user) {
        int rowsAffected = JDBIConnector.getConnect().withHandle(handle -> {
            // Cập nhật câu lệnh INSERT để thêm giá trị cho cột picture
            return handle.createUpdate("INSERT INTO users(username, password, oauth_provider, oauth_uid, oauth_token, name, email, picture, role_id, created_at, updated_at, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)")
                    .bind(0, user.getUsername())
                    .bind(1, user.getPassword())
                    .bind(2, user.getOauthProvider())
                    .bind(3, user.getOauthUid())
                    .bind(4, user.getOauthToken())
                    .bind(5, user.getName())
                    .bind(6, user.getEmail())
                    .bind(7, user.getPicture())
                    .bind(8, user.getRoleId())
                    .bind(9, user.getCreatedAt())
                    .bind(10, user.getUpdatedAt())
                    .bind(11, user.getStatus())
                    .execute();
        });
        return rowsAffected > 0;
    }
    @Override
    public boolean addFacebookUser(User user) {
        try {
            // Kiểm tra xem người dùng với oauth_uid đã tồn tại chưa
            User existingUser = getByOAuthUser(user.getOauthUid());
            if (existingUser != null) {
                // Nếu đã tồn tại, cập nhật lại thông tin mới (oauthToken, name, email, picture, updated_at)
                int rowsAffected = JDBIConnector.getConnect().withHandle(handle -> {
                    return handle.createUpdate("UPDATE users SET oauth_token = ?, name = ?, email = ?, picture = ?, updated_at = ? WHERE id = ?")
                            .bind(0, user.getOauthToken())
                            .bind(1, user.getName())
                            .bind(2, user.getEmail())
                            .bind(3, user.getPicture())
                            .bind(4, user.getUpdatedAt())
                            .bind(5, existingUser.getId())
                            .execute();
                });
                return rowsAffected > 0;
            } else {
                // Nếu chưa tồn tại, tiến hành INSERT bản ghi mới
                int rowsAffected = JDBIConnector.getConnect().withHandle(handle -> {
                    return handle.createUpdate("INSERT INTO users(username, password, oauth_provider, oauth_uid, oauth_token, name, email, picture, role_id, created_at, updated_at, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)")
                            .bind(0, user.getUsername())
                            .bind(1, user.getPassword())
                            .bind(2, user.getOauthProvider())
                            .bind(3, user.getOauthUid())
                            .bind(4, user.getOauthToken())
                            .bind(5, user.getName())
                            .bind(6, user.getEmail())
                            .bind(7, user.getPicture())
                            .bind(8, user.getRoleId())
                            .bind(9, user.getCreatedAt())
                            .bind(10, user.getUpdatedAt())
                            .bind(11, user.getStatus())
                            .execute();
                });
                return rowsAffected > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

}