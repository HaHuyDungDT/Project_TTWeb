package service;

import dao.impl.UserDaoImpl;
import db.JDBIConnector;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class UserInForServies {
    private UserDaoImpl userDao;

    public UserInForServies() {
        this.userDao = new UserDaoImpl();
    }

    // Cập nhật thông tin cơ bản của user: email, name, phone
    public boolean updateInfo(int userId, String email, String name, String phone) {
        try {
            // chỉ build SQL cập nhật các trường không null
            StringBuilder sql = new StringBuilder("UPDATE users SET ");
            List<Object> params = new ArrayList<>();
            if (email!=null) { sql.append("email=?,"); params.add(email); }
            if (name!=null ) { sql.append("name=?,");  params.add(name ); }
            if (phone!=null) { sql.append("phone=?,"); params.add(phone); }
            sql.append("updated_at=? WHERE id=?");
            params.add(new Timestamp(System.currentTimeMillis()));
            params.add(userId);

            int rows = JDBIConnector.getConnect().withHandle(h ->
                    h.createUpdate(sql.toString())
                            .bindList(params.toString())
                            .execute()
            );
            return rows>0;
        } catch(Exception e){ e.printStackTrace(); return false;}
    }

    // Cập nhật địa chỉ dựa trên thành phần: province, city, commune, street
    public boolean updateAddress(int userId, String province, String city, String commune, String street) {
        try {
            return userDao.updateAddress(userId, province, city, commune, street);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Cập nhật đồng thời thông tin cá nhân và địa chỉ của user
    public boolean updateUser(int userId, String email, String name, String phone,
                              String province, String city, String commune, String street) {
        boolean infoUpdated = updateInfo(userId, email, name, phone);
        if (!infoUpdated) {
            return false;
        }
        boolean addressUpdated = updateAddress(userId, province, city, commune, street);
        return addressUpdated;
    }

    // Cập nhật avatar: lưu đường link của ảnh vào trường picture
    public boolean updateAvatar(int userId, String path) {
        return userDao.updateAvatar(userId, path);
    }

    public boolean updateProfile(int id, String username, String name,
                                 String email, String phone,
                                 String gender, LocalDate birth) {
        try {
            String sql = "UPDATE users SET username=?,name=?,email=?,phone=?,gender=?,birth=?,updated_at=? WHERE id=?";
            Timestamp now = new Timestamp(System.currentTimeMillis());
            int rows = JDBIConnector.getConnect().withHandle(h->
                    h.createUpdate(sql)
                            .bind(0,username)
                            .bind(1,name)
                            .bind(2,email)
                            .bind(3,phone)
                            .bind(4,gender)
                            .bind(5,birth)
                            .bind(6,now)
                            .bind(7,id)
                            .execute()
            );
            return rows>0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}