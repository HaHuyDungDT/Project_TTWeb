package dao.impl;

import dao.IImageDAO;
import db.JDBIConnector;
import model.Image;

import java.awt.font.ImageGraphicAttribute;
import java.util.List;

public class ImageDAOImpl implements IImageDAO {
    @Override
    public List<Image> findByProductId(Integer productID) {
        List<Image> images = JDBIConnector.getConnect().withHandle(handle -> {
            return handle.createQuery("SELECT id, link_image, product_id FROM images WHERE product_id = :productID")
                    .bind("productID", productID)
                    .mapToBean(Image.class)
                    .list();
        });
        return images;

    }

}
