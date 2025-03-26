package dao;

import db.JDBIConector;
import model.Rate;

import java.util.List;

public class RateDAO {
    public List<Rate> selectByProductId(Integer id) {
        return JDBIConector.me().withHandle(handle ->
                handle.createQuery(
                                "SELECT id, star, comment, product_id " +
                                        "FROM rates " +
                                        "WHERE product_id = :pid"
                        )
                        .bind("pid", id)
                        .map((rs, ctx) -> {
                            Rate rate = new Rate();
                            rate.setId(rs.getInt("id"));
                            rate.setStar(rs.getInt("star"));
                            rate.setComment(String.valueOf(rs.getInt("comment")));   // comment kiểu int như trong DB
                            rate.setProductId(rs.getInt("product_id"));
                            return rate;
                        })
                        .list()
        );
    }
}
