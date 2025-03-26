package mapper.impl;

import mapper.IRowMapper;
import model.User;

import java.sql.ResultSet;
import java.sql.SQLException;

public class userMapperImpl implements IRowMapper<User> {

	@Override
	public User maplist(ResultSet rs) {
		User model = new User();
		try {
			model.setId(rs.getString("id"));
			model.setName(rs.getString("name"));
			model.setSex(rs.getString("sex"));
			model.setAddress(rs.getString("address"));
			model.setPhone_number(rs.getString("phone_number"));
			model.setEmail(rs.getString("email"));
			model.setUser_name(rs.getString("user_name"));
			model.setRole_idStr(rs.getString("role_id"));
			model.setPassword(rs.getString("password"));
			model.setBirth_day(rs.getDate("birth_day"));
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return model;
	}

	@Override
	public User mapFindById(ResultSet rs) {
		return null;
	}
}
