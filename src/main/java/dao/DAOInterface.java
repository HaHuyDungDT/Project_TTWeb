package dao;

import java.util.List;

public interface DAOInterface<T> {
    public List<T> selectAll();
    public T selectById(T t);

    public int insert(T t);

    public int delete(T t);

    public int update(T t);
}
