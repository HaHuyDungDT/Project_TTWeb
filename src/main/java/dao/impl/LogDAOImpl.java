package dao.impl;

import dao.ILogDAO;
import db.JDBIConnector;
import model.Log;
import utils.LevelLog;

import java.time.LocalDateTime;
import java.util.List;

public class LogDAOImpl implements ILogDAO {
    private static final String INSERT_LOG = "INSERT INTO logs (level, action, address_ip, user_id, created_at) VALUES (:level, :action, :addressIP, :userId, :createdAt)";
    private static final String SELECT_ALL_LOGS = "SELECT * FROM logs ORDER BY created_at DESC";
    private static final String SELECT_LOGS_BY_USER = "SELECT * FROM logs WHERE user_id = :userId ORDER BY created_at DESC";

    @Override
    public void save(Log log) {
        // Set current time if created_at is null
        if (log.getCreatedAt() == null) {
            log.setCreatedAt(LocalDateTime.now());
        }
        
        JDBIConnector.getConnect().useHandle(handle -> {
            handle.createUpdate(INSERT_LOG)
                    .bind("level", log.getLevel().toString())
                    .bind("action", log.getAction())
                    .bind("addressIP", log.getAddressIP())
                    .bind("userId", log.getUserId())
                    .bind("createdAt", log.getCreatedAt())
                    .execute();
        });
    }

    @Override
    public List<Log> findAll() {
        return JDBIConnector.getConnect().withHandle(handle -> {
            return handle.createQuery(SELECT_ALL_LOGS)
                    .mapToBean(Log.class)
                    .list();
        });
    }

    @Override
    public List<Log> findByUserId(int userId) {
        return JDBIConnector.getConnect().withHandle(handle -> {
            return handle.createQuery(SELECT_LOGS_BY_USER)
                    .bind("userId", userId)
                    .mapToBean(Log.class)
                    .list();
        });
    }
}
