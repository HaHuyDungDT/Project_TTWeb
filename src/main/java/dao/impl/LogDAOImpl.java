package dao.impl;

import dao.ILogDAO;
import db.JDBIConnector;
import model.Log;

import java.sql.Timestamp;
import java.util.List;

public class LogDAOImpl implements ILogDAO {
    Timestamp currentTimestamp = new Timestamp(System.currentTimeMillis());

    @Override
    public Log save(Log log) {
        return JDBIConnector.getConnect().withHandle(handle -> {
            handle.createUpdate("INSERT INTO logs(level, action, address_ip, user_id, created_at) VALUES (?, ?, ?, ?, ?)")
                    .bind(0, log.getLevel())
                    .bind(1, log.getAction())
                    .bind(2, log.getAddressIP())
                    .bind(3, log.getUserId())
                    .bind(4, currentTimestamp)
                    .execute();
            return log;
        });
    }


    @Override
    public List<Log> findAll() {
       List<Log> logs = JDBIConnector.getConnect().withHandle(handle -> {
            return handle.createQuery("SELECT id, level, action, address_ip, user_id, created_at FROM logs")
                    .mapToBean(Log.class)
                    .list();
        });
        return logs;
    }

    @Override
    public List<Log> findByUserId(int userId) {
        List<Log> logs = JDBIConnector.getConnect().withHandle(handle -> {
            return handle.createQuery("SELECT id, level, action, address_ip, user_id, created_at FROM logs WHERE user_id = ?")
                    .bind(0, userId)
                    .mapToBean(Log.class)
                    .list();
        });
        return logs;
    }
}
