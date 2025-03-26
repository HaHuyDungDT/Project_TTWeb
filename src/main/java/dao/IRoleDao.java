package dao;

import model.Role;

public interface IRoleDao {
    Role getByName(String name);
}
