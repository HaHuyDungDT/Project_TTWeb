package dao;

import model.ProductType;

import java.util.List;

public interface IProductTypeDAO {
    List<ProductType> findAll();
    ProductType findById(int id);
    boolean save(ProductType productType);
    boolean update(ProductType productType);
    boolean delete(Integer productTypeId);
}
