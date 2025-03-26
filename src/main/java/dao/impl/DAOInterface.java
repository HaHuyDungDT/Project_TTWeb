package dao.impl;

import java.util.List;

public interface DAOInterface<T> {
    List<T> selectAll();
    T selectById(T t);
    int insert(T t);
    int update(T t);
    int delete(T t);
}
