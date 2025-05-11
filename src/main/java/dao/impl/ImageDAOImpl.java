package dao.impl;

import dao.IImageDAO;
import db.JDBIConnector;
import model.Image;

import java.util.List;

public class ImageDAOImpl implements IImageDAO {

    @Override
    public boolean addImageForProduct(Integer productId, String imageUrl) {
        // Cập nhật câu lệnh SQL sử dụng đúng tên cột là `link_image`
        String sql = "INSERT INTO images (product_id, link_image) VALUES (?, ?)";
        return JDBIConnector.getConnect().withHandle(handle ->
                handle.createUpdate(sql)
                        .bind(0, productId)  // Gắn giá trị productId vào dấu ? đầu tiên
                        .bind(1, imageUrl)   // Gắn giá trị imageUrl vào dấu ? thứ hai
                        .execute() > 0       // Kiểm tra số bản ghi bị ảnh hưởng
        );
    }


    @Override
    public List<Image> findByProductId(Integer productId) {
        String sql = "SELECT * FROM images WHERE product_id = ?";
        return JDBIConnector.getConnect().withHandle(handle ->
                handle.createQuery(sql)
                        .bind(0, productId)
                        .mapToBean(Image.class)
                        .list());


    }

    @Override
    public boolean deleteImageById(Integer imageId) {
        String sql = "DELETE FROM images WHERE id = ?";
        return JDBIConnector.getConnect().withHandle(handle ->
                handle.createUpdate(sql)
                        .bind(0, imageId)
                        .execute() > 0
        );
    }
}
