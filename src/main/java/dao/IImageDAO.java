package dao;

import Model.Image;

import java.util.List;

public interface IImageDAO {
    List<Image> findByProductId(Integer productID);
}
