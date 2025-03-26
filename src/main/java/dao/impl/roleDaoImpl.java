package dao.impl;

import dao.IRoleDao;
import model.Role;
import mapper.impl.roleMapperImpl;

import java.util.List;

public class roleDaoImpl extends abstractDaoImpl<Role> implements IRoleDao {
    @Override
    public Role getByName(String name) {
        String sql = "select * from roles where role_name = ?";
        List<Role> roles = query(sql, new roleMapperImpl(), name);
        return roles.size() > 0 ? roles.get(0) : null;
    }
}
