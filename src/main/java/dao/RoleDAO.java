package dao;

import model.Role;
import db.JDBIConector;

import java.util.List;
import java.util.Optional;

public class RoleDAO implements DAOInterface<Role>{
    @Override
    public List<Role> selectAll() {
        List<Role> roles = JDBIConector.me().withHandle((handle ->
                handle.createQuery("SELECT id, role_name FROM roles")
                        .mapToBean(Role.class).list()
        ));
        return roles;
    }

    @Override
    public Role selectById(Role roleP) {
        Optional<Role> role = JDBIConector.me().withHandle((handle ->
                handle.createQuery("SELECT id, role_name FROM roles WHERE id=?")
                        .bind(0, roleP.getId())
                        .mapToBean(Role.class).stream().findFirst()
        ));
        return role.isEmpty() ? null : role.get();
    }

    @Override
    public int insert(Role role) {
        return 0;
    }

    @Override
    public int delete(Role role) {
        return 0;
    }

    @Override
    public int update(Role role) {
        return 0;
    }

    public static void main(String[] args) {
        RoleDAO ro = new RoleDAO();
        Role r = new Role("1", null);
        System.out.println(ro.selectById(r));
    }


}
