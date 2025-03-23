package dao;

import Model.Log;

import java.util.List;

public interface ILogDAO {
    Log save(Log log);
    List<Log> findAll();
    List<Log> findByUserId(int userId);

}
