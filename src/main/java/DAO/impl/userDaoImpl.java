package DAO.impl;

import DAO.IUserDao;
import db.JDBIConector;
import mapper.impl.userMapperImpl;
import Model.User;
import org.jdbi.v3.core.Handle;
import org.jdbi.v3.core.Jdbi;

import java.util.List;

public class userDaoImpl extends abstractDaoImpl<User> implements IUserDao {
    @Override
    public boolean login(User item) {
        String sql = "select * from users where user_name = ? and password = ?";
        List<User> list = query(sql, new userMapperImpl(), item.getUser_name(), item.getPassword());
        return list.size() == 1 ? true : false;
    }

    @Override
    public User register(User item) {
        String sql = "insert into users values(?,?,?,?,?,?,?,?,?,?)";
        query_insert(sql, item.getId(), item.getName(), item.getSex(), item.getAddress(), item.getBirth_day(), item.getPhone_number(), item.getEmail(), item.getUser_name(), item.getPassword(), item.getRole_idStr());
        sql = "select * from users where user_name = ? and password = ?";
        List<User> list = query(sql, new userMapperImpl(), item.getUser_name(), item.getPassword());
        if(list.size() == 0)
            return null;
        return list.get(0);
    }

    @Override
    public String getIdTop1() {
        String sql = "select * from users ORDER BY LENGTH(id) DESC, id DESC LIMIT 1";
        List<User> list = query(sql, new userMapperImpl());
        return list.size() == 1 ? list.get(0).getId() : null;
    }

    @Override
    public boolean isUsernameExists(String username) {
        String sql = "select * from users where user_name = ?";
        List<User> list = query(sql, new userMapperImpl(), username);
        return list.size() > 0 ? true : false;
    }

    @Override
    public String getIdByUsername(String username) {
        String sql = "select * from users where user_name = ?";
        List<User> list = query(sql, new userMapperImpl(), username);
        return list.size() > 0 ? list.get(0).getId() : null;
    }

    @Override
    public User getByUsername(String username) {
        String sql = "select * from users where user_name = ?";
        List<User> list = query(sql, new userMapperImpl(), username);
        return list.size() > 0 ? list.get(0) : null;
    }

    @Override
    public User getById(String username) {
        String sql = "select * from users where id = ?";
        List<User> list = query(sql, new userMapperImpl(), username);
        return list.size() > 0 ? list.get(0) : null;
    }

    @Override
    public boolean isEmailExists(String email) {
        String sql = "select * from users where email = ?";
        return query(sql, new userMapperImpl(), email).size() > 0;
    }

    @Override
    public void resetPass(String email, String password) {
        String sql = "update users set password = ? where email = ?";
        query_update(sql, password, email);
    }

    @Override
    public List<User> findAll() {
        String sql = "select * from users";
        return query(sql, new userMapperImpl());
    }

    @Override
    public void deleteById(String id) {
        String sql = "delete from users where id = ?";
        query_update(sql, id);
    }

    @Override
    public void update(User user) {
        String sql = "update users set name = ?, address = ?, sex = ?, birth_day = ?, phone_number = ?, email = ?, user_name = ?, password = ? where id = ?";
        query_update(sql, user.getName(), user.getAddress(), user.getSex(), user.getBirth_day(), user.getPhone_number(), user.getEmail(), user.getUser_name(), user.getPassword(), user.getId());
    }

    @Override
    public void add(User user) {
        String sql = "insert into users values(?,?,?,?,?,?,?,?,?,?)";
        query_update(sql, user.getId(), user.getName(), user.getSex(), user.getAddress(), user.getBirth_day(), user.getPhone_number(), user.getEmail(), user.getUser_name(), user.getPassword(), user.getRole_idStr());
    }

    @Override
    public void addGoogleUser(User user) {
        try (Handle handle = JDBIConector.me().open()) {
            handle.createUpdate("INSERT INTO users (id, name, sex, address, phone_number, email, user_name, password, role_id) " +
                            "VALUES (:id, :name, :sex, :address, :phone_number, :email, :user_name, :password, :role_id)")
                    .bind("id", user.getId())
                    .bind("name", user.getName())
                    .bind("sex", user.getSex())
                    .bind("address", user.getAddress())
                    .bind("phone_number", user.getPhone_number())
                    .bind("email", user.getEmail())
                    .bind("user_name", user.getUser_name())
                    .bind("password", "")  // Password is empty for Google users
                    .bind("role_id", user.getRole_idStr())
                    .execute();
        }
    }


}

