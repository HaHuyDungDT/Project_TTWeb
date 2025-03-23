package dao.impl;

import dao.IRoleDao;
import db.JDBIConnector;
import model.Role;

import java.util.List;

public class RoleDaoImpl implements IRoleDao {
    private static final String SELECT_ROLE = "SELECT id, name FROM roles";
    @Override
    public List<Role> findAll(String userId) {
        List<Role> roles = JDBIConnector.getConnect().withHandle(handle -> {
            return handle.createQuery(SELECT_ROLE)
                    .mapToBean(Role.class)
                    .list();
        });
        return roles;
    }

    @Override
    public Role findById(Integer id) {
        Role role = JDBIConnector.getConnect().withHandle(handle -> {
            return handle.createQuery(SELECT_ROLE + " WHERE id = :id")
                    .bind("id", id)
                    .mapToBean(Role.class)
                    .findFirst()
                    .orElse(null);
        });
        return role;
    }
}
