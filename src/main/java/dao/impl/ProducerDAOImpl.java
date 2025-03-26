package dao.impl;

import dao.IProducerDAO;
import model.*;
import db.JDBIConnector;

import java.util.List;

public class ProducerDAOImpl implements IProducerDAO {
    @Override
    public List<Producer> findAll() {
        List<Producer> producers = JDBIConnector.getConnect().withHandle(handle -> {
            return handle.select("SELECT id, name, code FROM producers")
                    .mapToBean(Producer.class)
                    .list();
        });
        return producers;
    }
    @Override
    public Producer findById(Integer id) {
        Producer producer = JDBIConnector.getConnect().withHandle(handle -> {
            return handle.select("SELECT id, name, code FROM producers WHERE id = ?", id)
                    .mapToBean(Producer.class)
                    .findFirst()
                    .orElse(null);
                }
        );
        return producer;
    }

    @Override
    public boolean save(Producer producer) {
        int rowsAffected = JDBIConnector.getConnect().withHandle(handle -> {
            return handle.createUpdate("INSERT INTO producers (name, code) VALUES (:name, :code)")
                    .bind("name", producer.getName())
                    .bind("code", producer.getCode())
                    .execute();
        });
        return rowsAffected > 0;
    }

    @Override
    public boolean update(Producer producer) {
        int rowsAffected = JDBIConnector.getConnect().withHandle(handle -> {
            return handle.createUpdate("UPDATE producers SET name = :name, code = :code WHERE id = :id")
                    .bind("name", producer.getName())
                    .bind("code", producer.getCode())
                    .bind("id", producer.getId())
                    .execute();
        });

        return rowsAffected > 0;
    }

    @Override
    public boolean delete(Integer id) {
        int rowsAffected = JDBIConnector.getConnect().withHandle(handle -> {
            return handle.createUpdate("DELETE FROM producers WHERE id = :id")
                    .execute();
        });
        return rowsAffected > 0;
    }

}
