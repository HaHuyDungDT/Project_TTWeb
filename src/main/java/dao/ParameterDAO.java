package dao;

import model.Parameter;
import db.JDBIConector;
import org.jdbi.v3.core.JdbiException;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

public class ParameterDAO implements DAOInterface<Parameter> {

    @Override
    public List<Parameter> selectAll() {
        return JDBIConector.me().withHandle((handle ->
                handle.createQuery("SELECT id, number_cus, number_pro, number_ord, revenue, update_date FROM parameter")
                        .mapToBean(Parameter.class).stream().collect(Collectors.toList())
        ));
    }



    @Override
    public Parameter selectById(Parameter parameter) {
        Optional<Parameter> parameter1 = JDBIConector.me().withHandle((handle ->
                handle.createQuery("SELECT id, number_cus, number_pro, number_ord, revenue, update_date FROM parameter WHERE id = ?")
                        .bind(0, parameter.getId())
                        .mapToBean(Parameter.class).stream().findFirst()
        ));
        return parameter1.isEmpty() ? null : parameter1.get();
    }

    @Override
    public int insert(Parameter parameter) {
        try {
            return JDBIConector.me().withHandle(handle ->
                    handle.createUpdate("INSERT INTO parameter (id, number_cus, number_pro, number_ord, revenue, update_date) VALUES (?, ?, ?, ?, ?, ?)")
                            .bind(0, parameter.getId())
                            .bind(1, parameter.getNumber_cus())
                            .bind(2, parameter.getNumber_pro())
                            .bind(3, parameter.getNumber_ord())
                            .bind(4, parameter.getRevenue())
                            .bind(5, LocalDate.now())
                            .execute());
        } catch (JdbiException e) {
            e.printStackTrace();
            return -1;
        }
    }

    @Override
    public int delete(Parameter parameter) {
        try {
            return JDBIConector.me().withHandle(handle ->
                    handle.createUpdate("DELETE FROM parameter WHERE id = ?")
                            .bind(0, parameter.getId())
                            .execute());
        } catch (JdbiException e) {
            e.printStackTrace();
            return -1; // Đối với mục đích demo, bạn có thể thay đổi xử lý lỗi này.
        }
    }

    @Override
    public int update(Parameter parameter) {
        try {
            return JDBIConector.me().withHandle(handle ->
                    handle.createUpdate("UPDATE parameter SET number_cus = ?, number_pro = ?, number_ord = ?, revenue = ?, update_date = ? WHERE id = ?")
                            .bind(0, parameter.getNumber_cus())
                            .bind(1, parameter.getNumber_pro())
                            .bind(2, parameter.getNumber_ord())
                            .bind(3, parameter.getRevenue())
                            .bind(4, LocalDate.now())
                            .bind(5, parameter.getId())
                            .execute());
        } catch (JdbiException e) {
            e.printStackTrace();
            return -1; // Đối với mục đích demo, bạn có thể thay đổi xử lý lỗi này.
        }
    }

    public List<Parameter> getByMonth(int month, int year) {
        String sql = "SELECT id, number_cus, number_pro, number_ord, revenue, update_date " +
                "FROM parameter " +
                "WHERE MONTH(update_date) = ? AND YEAR(update_date) = ?";

        return JDBIConector.me().withHandle(handle ->
                handle.createQuery(sql)
                        .bind(0, month)
                        .bind(1, year)
                        .mapToBean(Parameter.class)
                        .stream()
                        .collect(Collectors.toList())
        );
    }

    public static void main(String[] args) {
        //System.out.println(new ParameterDAO().selectById(new Parameter("1", 0, 0, 0, 0, null)));

        System.out.println(new ParameterDAO().getByMonth(LocalDate.now().getMonthValue(), LocalDate.now().getYear()));
    }
}
