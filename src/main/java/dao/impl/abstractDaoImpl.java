package DAO.impl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.ResourceBundle;

import DAO.IAbstractDao;
import mapper.IRowMapper;

public class abstractDaoImpl<T> implements IAbstractDao<T>{
	
	@Override
	public Connection getconnection() {
		try {
			ResourceBundle mybundle = ResourceBundle.getBundle("DB");
			Class.forName(mybundle.getString("db.driver"));
			return DriverManager.
					getConnection(mybundle.getString("db.url"),
					mybundle.getString("db.username"),
					mybundle.getString("db.password"));
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
			return null;
		}
	}

	@Override
	public <T> List<T> query(String sql, IRowMapper<T> mapper, Object... params) {
		List<T> result = new ArrayList<>();
		Connection connection = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			connection = getconnection();
			if(connection != null) {
				stmt = connection.prepareStatement(sql);
				setparams(stmt, params);
				rs = stmt.executeQuery();
				while(rs.next()) {
					result.add(mapper.maplist(rs));
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}  finally{
			try {
				if(connection != null) {
					connection.close();
				}
				if(stmt != null) {
					stmt.close();
				}
				if(rs != null) {
					rs.close();
				}
			}catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return result;
	}
	
	private PreparedStatement setparams(PreparedStatement stmt, Object... params) {
		for(int i = 0; i < params.length; i++) {
			try {
				if(params[i] instanceof Long) {
					stmt.setLong(i + 1, (Long)params[i]);
				}
				if(params[i] instanceof String) {
					stmt.setString(i + 1, (String)params[i]);
				}
				if(params[i] instanceof Integer) {
					stmt.setInt(i + 1, (int)params[i]);
				}
				if(params[i] instanceof Timestamp) {
					stmt.setTimestamp(i + 1, (Timestamp)params[i]);
				}
				if(params[i] instanceof Date) {
					stmt.setDate(i + 1, new java.sql.Date(((Date)params[i]).getTime()));
				}
				if(params[i] instanceof java.sql.Date) {
					stmt.setDate(i + 1, (java.sql.Date)params[i]);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return stmt;
	}

	@Override
	public Long query_insert(String sql, Object... params) {
		Connection connection = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		Long id = null;
		try {
			connection = getconnection();
			connection.setAutoCommit(false);
			if(connection != null) {
				stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
				setparams(stmt, params);
				stmt.executeUpdate();
				rs = stmt.getGeneratedKeys();
				if(rs.next()) {
					id = rs.getLong(1);

				}
				connection.commit();
			}
		} catch (SQLException e) {
			e.printStackTrace();
			try {
				if(connection != null) {
					connection.rollback();
				}
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}  finally{
			try {
				if(connection != null) {
					connection.close();
				}
				if(stmt != null) {
					stmt.close();
				}
				if(rs != null) {
					rs.close();
				}
			}catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return id;
	}

	@Override
	public void query_update(String sql, Object... params) {
		Connection connection = null;
		PreparedStatement stmt = null;
		try {
			connection = getconnection();
			connection.setAutoCommit(false);
			if(connection != null) {
				stmt = connection.prepareStatement(sql);
				setparams(stmt, params);
				stmt.executeUpdate();
				connection.commit();
			}
		} catch (SQLException e) {
			e.printStackTrace();
			try {
				if(connection != null) {
					connection.rollback();
				}
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}  finally{
			try {
				if(connection != null) {
					connection.close();
				}
				if(stmt != null) {
					stmt.close();
				}
			}catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}
