package service.impl;

import dao.ILogDAO;
import dao.impl.LogDAOImpl;
import model.Log;
import service.ILogService;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.logging.*;
import java.util.stream.Collectors;

public class LogServiceImpl implements ILogService {
    private static final Logger logger = Logger.getLogger(LogServiceImpl.class.getName());
    private ILogDAO logDao = new LogDAOImpl();
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

    @Override
    public void info(String message) {
        logger.info(getFormattedMessage("INFO", message));
    }

    @Override
    public void warning(String message) {
        logger.warning(getFormattedMessage("WARNING", message));
    }

    @Override
    public void danger(String message) {
        logger.severe(getFormattedMessage("DANGER", message));
    }

    @Override
    public void save(Log log) {
        logDao.save(log);
    }

    @Override
    public List<Log> findAll() {
        return logDao.findAll();
    }

    @Override
    public List<Log> findByLevel(String level) {
        return logDao.findAll().stream()
                .filter(log -> log.getLevel().toString().equals(level))
                .collect(Collectors.toList());
    }

    @Override
    public List<Log> search(String query) {
        String searchQuery = query.toLowerCase();
        return logDao.findAll().stream()
                .filter(log -> 
                    log.getAction().toLowerCase().contains(searchQuery) ||
                    log.getLevel().toString().toLowerCase().contains(searchQuery) ||
                    log.getAddressIP().toLowerCase().contains(searchQuery) ||
                    String.valueOf(log.getUserId()).contains(searchQuery))
                .collect(Collectors.toList());
    }

    // Định dạng thông điệp log với timestamp
    private String getFormattedMessage(String level, String message) {
        String timestamp = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
        return String.format("[%s] [%s] - %s", timestamp, level, message);
    }
}
