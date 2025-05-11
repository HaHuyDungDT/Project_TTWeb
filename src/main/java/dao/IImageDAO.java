package dao;

import model.Image;

import java.util.List;

public interface IImageDAO {
    boolean addImageForProduct(Integer productId, String imageUrl);

    List<Image> findByProductId(Integer productID);

    boolean deleteImageById(Integer imageId);
}
