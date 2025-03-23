package dao;

import Model.Role;

import java.util.List;

public interface IRoleDao {
    List<Role> findAll(String userId);
    Role findById(Integer id);
}
