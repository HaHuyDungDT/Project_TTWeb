package utils;

import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.sqlobject.SqlObjectPlugin;

public class JDBIConnector {
    private static Jdbi jdbi;

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/your_database_name?useSSL=false&serverTimezone=UTC";
            String username = "your_username";
            String password = "your_password";
            
            jdbi = Jdbi.create(url, username, password);
            jdbi.installPlugin(new SqlObjectPlugin());
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public static Jdbi getJdbi() {
        return jdbi;
    }
} 