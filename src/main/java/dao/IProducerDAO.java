package dao;

import Model.Producer;

import java.util.List;

public interface IProducerDAO {
    List<Producer> findAll();
    Producer findById(Integer id);
    boolean save(Producer producer);
    boolean update(Producer producer);
    boolean delete(Integer id);
}
