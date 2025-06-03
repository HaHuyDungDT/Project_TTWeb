package dao;

import model.Log;

import java.util.List;

public interface ILogDAO {
    void save(Log log);
    List<Log> findAll();
    List<Log> findByUserId(int userId);
}
