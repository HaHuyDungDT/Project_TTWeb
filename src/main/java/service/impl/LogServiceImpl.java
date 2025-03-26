package service.impl;

import service.ILogService;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.*;

public class LogServiceImpl implements ILogService {
    private static final Logger logger = Logger.getLogger(LogServiceImpl.class.getName());

    static {
        try {
            // File handler ghi log vào file
            FileHandler fileHandler = new FileHandler("application.log", true);
            fileHandler.setFormatter(new SimpleFormatter());
            logger.addHandler(fileHandler);

            // Console handler ghi log vào console
            ConsoleHandler consoleHandler = new ConsoleHandler();
            consoleHandler.setLevel(Level.ALL);
            logger.addHandler(consoleHandler);

            logger.setLevel(Level.ALL);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // Phương thức ghi log thông tin
    @Override
    public void info(String message) {
        logger.info(getFormattedMessage("INFO", message));
    }

    // Phương thức ghi log cảnh báo
    @Override
    public void warning(String message) {
        logger.warning(getFormattedMessage("WARNING", message));
    }

    // Phương thức ghi log báo động
    @Override
    public void alert(String message) {
        logger.severe(getFormattedMessage("ALERT", message));
    }

    // Phương thức ghi log nguy hiểm
    @Override
    public void danger(String message) {
        logger.severe(getFormattedMessage("DANGER", message));
    }

    // Phương thức ghi log lỗi
    public void error(String message) {
        logger.severe(getFormattedMessage("ERROR", message));
    }

    // Phương thức ghi log lỗi kèm Exception
    public void error(String message, Exception e) {
        logger.severe(getFormattedMessage("ERROR", message));
        e.printStackTrace();
    }

    // Định dạng thông điệp log với timestamp
    private String getFormattedMessage(String level, String message) {
        String timestamp = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
        return String.format("[%s] [%s] - %s", timestamp, level, message);
    }
}
