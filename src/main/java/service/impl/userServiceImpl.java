package service.impl;

import DAO.IRoleDao;
import DAO.IUserDao;
import DAO.impl.roleDaoImpl;
import DAO.impl.userDaoImpl;
import Model.User;
import db.JDBIConector;
import mapper.impl.userMapperImpl;
import service.IUserService;

import java.util.List;

public class userServiceImpl implements IUserService {
    private IUserDao DAO = new userDaoImpl();
    private IRoleDao roleDao = new roleDaoImpl();

    public void addGoogleUser(User user) {
        DAO.addGoogleUser(user);
    }


    @Override
    public boolean login(String username, String password) {
        User user = new User();
        user.setUser_name(username);
        user.setPassword(password);
        return DAO.login(user);
    }

    @Override
    public String register(User user) {
        user.setId(createId());
        User userNew = DAO.register(user);
        return userNew == null ? null : userNew.getId();
    }

    @Override
    public boolean isUsernameExists(String username) {
        return DAO.isUsernameExists(username);
    }

    @Override
    public String getIdByUsername(String username) {
        return DAO.getIdByUsername(username);
    }

    @Override
    public User getByUsername(String username) {
        return DAO.getByUsername(username);
    }

    @Override
    public User     getById(String id) {
        return DAO.getById(id);
    }

//    @Override
//    public boolean isEmailExists(String email) {
//        return DAO.isEmailExists(email);
//    }

    public boolean isEmailExists(String email) {
        String sql = "SELECT * FROM users WHERE email = :email";
        List<User> users = JDBIConector.me().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("email", email)
                        .map((rs, ctx) -> new userMapperImpl().maplist(rs))
                        .list()
        );
        return !users.isEmpty();
    }


    @Override
    public void resetPass(String email, String password) {
        DAO.resetPass(email, password);
    }

    @Override
    public List<User> findAll() {
        return DAO.findAll();
    }

    @Override
    public void deleteById(String id) {
        DAO.deleteById(id);
    }

    @Override
    public void update(User user) {
        DAO.update(user);
    }

    @Override
    public void add(User user, String role) {
        user.setRole_idStr(roleDao.getByName(role).getId());
        user.setId(createId());
        DAO.add(user);
    }

    @Override
    public void registerGoogleUser(String email, String name, String picture) {
        // Kiểm tra xem email đã tồn tại trong hệ thống chưa
        if (isEmailExists(email)) {
            return; // Nếu người dùng đã tồn tại, không làm gì cả
        }

        // Tạo người dùng mới với các giá trị mặc định cho những trường không cần thiết
        User user = new User();
        user.setId(createId());         // Tạo ID cho người dùng mới
        user.setUser_name(email);       // Đặt tên đăng nhập bằng email
        user.setEmail(email);           // Đặt email
        user.setName(name);             // Đặt tên người dùng
        user.setSex("Unknown");         // Gán giới tính mặc định nếu không có
        user.setAddress("Unknown");     // Gán địa chỉ mặc định nếu không có
        user.setPassword("");           // Mật khẩu không cần thiết khi đăng nhập qua Google
        user.setRole_idStr("0");        // Gán vai trò mặc định cho người dùng (ví dụ: "2" cho khách hàng)

        // Sửa lại: Gọi phương thức thêm người dùng đăng nhập qua Google
        DAO.addGoogleUser(user);
    }

    @Override
    public String createId() {
        // Ví dụ: Tạo id theo định dạng "USER_" kèm theo thời gian hiện tại
        return "USER_" + System.currentTimeMillis();
    }
}

