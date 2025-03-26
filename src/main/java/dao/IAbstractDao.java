package dao;

import java.sql.Connection;
import java.util.List;

import mapper.IRowMapper;

public interface IAbstractDao<T> {
	Connection getconnection();
	<T> List<T> query(String sql, IRowMapper<T> mapper, Object... params);
	Long query_insert(String sql, Object... params);
	void query_update(String sql, Object... params);
}
