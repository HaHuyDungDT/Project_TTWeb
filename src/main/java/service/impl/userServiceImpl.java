package service.impl;

import dao.IRoleDao;
import dao.IUserDao;
import dao.impl.roleDaoImpl;
import dao.impl.userDaoImpl;
import model.User;
import org.mindrot.jbcrypt.BCrypt;
import service.IUserService;

import java.util.List;
import java.util.UUID;

public class userServiceImpl implements IUserService {
    private IUserDao DAO = new userDaoImpl();
    private IRoleDao roleDao = new roleDaoImpl();

    @Override
    public boolean login(String username, String password) {
        // Đối với chức năng đăng nhập, cần lấy user từ DB rồi so sánh mật khẩu đã mã hóa
        User user = DAO.getByUsername(username);
        if(user == null|| isUserLocked(username)) {
            return false;
        }
        // Sử dụng BCrypt để so sánh mật khẩu
        if(BCrypt.checkpw(password, user.getPassword())){
            return true;
        }
        return false;
    }
    @Override
    public boolean isUserLocked(String username) {
        User user = DAO.getByUsername(username);
        return user != null && user.isLocked(); // Giả sử User có phương thức isLocked()
    }

    @Override
    public String register(User user) {
        // Mã hóa mật khẩu trước khi lưu vào DB
        String hashedPassword = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt(12));
        user.setPassword(hashedPassword);

        // Tạo ID cho user
        user.setId(createId());

        // Gọi DAO để thực hiện chèn vào DB
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
    public User getById(String id) {
        return DAO.getById(id);
    }

    @Override
    public boolean isEmailExists(String email) {
        return DAO.isEmailExists(email);
    }

    @Override
    public void resetPass(String email, String password) {
        // Hash mật khẩu mới trước khi cập nhật
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt(12));
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
        // Nếu cập nhật mật khẩu, cần hash lại trước khi update
        if(user.getPassword() != null && !user.getPassword().isEmpty()){
            String hashedPassword = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt(12));
            user.setPassword(hashedPassword);
        }
        DAO.update(user);
    }

    @Override
    public void add(User user, String role) {
        user.setRole_idStr(roleDao.getByName(role).getId());
        user.setId(createId());
        DAO.add(user);
    }

    @Override
    public void addGoogleUser(User user) {
        DAO.addGoogleUser(user);
    }

    public String createId() {
        // Tạo ID dựa trên UUID
        String newId = "u_" + UUID.randomUUID().toString();

        if (DAO.isIdExists(newId)) {
            return createId(); // Gọi lại nếu ID đã tồn tại
        }

        return newId;
    }


}
