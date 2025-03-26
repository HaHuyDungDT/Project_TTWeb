package mapper.impl;

import model.Role;
import mapper.IRowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class roleMapperImpl implements IRowMapper<Role> {
    @Override
    public Role maplist(ResultSet rs) {
        Role model = new Role();
        try {
            model.setId(rs.getString("id"));
            model.setRole_name(rs.getString("role_name"));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return model;
    }

    @Override
    public Role mapFindById(ResultSet rs) {
        return null;
    }
}
