package service;

import DAO.RoleDAO;
import DAO.UserDAO;
import Model.Role;
import Model.User;
import db.JDBIConnector;

import java.sql.Date;
import java.sql.SQLException;
import java.util.List;
import java.util.stream.Collectors;

public class UserService {
    private static UserService instance;

    public static UserService getInstance(){
        if(instance == null)
            instance = new UserService();
        return instance;
    }

    public User checkLogin(String email, String pass) throws SQLException {
        UserDAO userDAO = new UserDAO();
        User userByEmail = userDAO.getUserByEmail(email);
        if(userByEmail == null) return null;
        if(!userByEmail.getEmail().equals(email) || !userByEmail.getPassword().equals(pass)) return null;
        return userByEmail;
    }

    public static void main(String[] args) throws SQLException {
        List<User> users = JDBIConnector.me().withHandle((handle -> {
            return handle.createQuery("SELECT id, name, sex, address, birth_day, phone_number, " +
                            "email, user_name, password, role_id FROM users")
                    .map((rs, ctx) -> {
                        String id = rs.getString("id");
                        String name = rs.getString("name");
                        String sex = rs.getString("sex");
                        String address = rs.getString("address");
                        Date birth_day = rs.getDate("birth_day");
                        String phone_number = rs.getString("phone_number");
                        String email = rs.getString("email");
                        String user_name = rs.getString("user_name");
                        String password = rs.getString("password");
                        String role_id = rs.getString("role_id");

                        Role role = new RoleDAO().selectById(new Role(role_id, null));
                        return new User(id, name, sex, address, birth_day, phone_number, email, user_name, password, role);
                    }).stream().collect(Collectors.toList());
        }));
        System.out.println(users);
    }
}
