package service;

import model.Log;

import java.util.List;

public interface ILogService {
    void info(String message);
    void warning(String message);
    void danger(String message);
    void save(Log log);
    List<Log> findAll();
    List<Log> findByLevel(String level);
    List<Log> search(String query);
}
