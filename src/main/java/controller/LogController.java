package controller;

import dao.impl.LogDAOImpl;
import model.Log;
import utils.LevelLog;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/getLogs")
public class LogController extends HttpServlet {
    private LogDAOImpl logDAO = new LogDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");

            int page = Integer.parseInt(request.getParameter("page"));
            int size = Integer.parseInt(request.getParameter("size"));
            String levelStr = request.getParameter("level");
            String searchQuery = request.getParameter("search");

            System.out.println("Requested level: " + levelStr); // Debug log

            List<Log> allLogs = logDAO.findAll();
            
            // Lọc theo level nếu có
            if (levelStr != null && !levelStr.equals("all")) {
                try {
                    LevelLog level = LevelLog.valueOf(levelStr);
                    System.out.println("Converted to enum: " + level); // Debug log
                    
                    allLogs = allLogs.stream()
                            .filter(log -> {
                                boolean matches = log.getLevel() == level;
                                System.out.println("Log level: " + log.getLevel() + ", matches: " + matches); // Debug log
                                return matches;
                            })
                            .collect(Collectors.toList());
                    
                    System.out.println("Filtered logs count: " + allLogs.size()); // Debug log
                } catch (IllegalArgumentException e) {
                    System.out.println("Invalid level: " + levelStr); // Debug log
                }
            }

            // Tìm kiếm nếu có query
            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                String query = searchQuery.toLowerCase();
                allLogs = allLogs.stream()
                        .filter(log -> 
                            log.getAction().toLowerCase().contains(query) ||
                            log.getLevel().toString().toLowerCase().contains(query) ||
                            log.getAddressIP().toLowerCase().contains(query) ||
                            String.valueOf(log.getUserId()).contains(query))
                        .collect(Collectors.toList());
            }

            // Tính toán phân trang
            int totalItems = allLogs.size();
            int totalPages = (int) Math.ceil((double) totalItems / size);
            int start = (page - 1) * size;
            int end = Math.min(start + size, totalItems);

            // Lấy danh sách log cho trang hiện tại
            List<Log> pageLogs = allLogs.subList(start, end);

            // Tạo response JSON
            StringBuilder json = new StringBuilder();
            json.append("{");
            json.append("\"currentPage\":").append(page).append(",");
            json.append("\"totalPages\":").append(totalPages).append(",");
            json.append("\"data\":[");
            
            for (int i = 0; i < pageLogs.size(); i++) {
                Log log = pageLogs.get(i);
                json.append("{");
                json.append("\"id\":").append(log.getId()).append(",");
                json.append("\"level\":\"").append(log.getLevel()).append("\",");
                json.append("\"action\":\"").append(log.getAction()).append("\",");
                json.append("\"addressIP\":\"").append(log.getAddressIP()).append("\",");
                json.append("\"userId\":").append(log.getUserId()).append(",");
                json.append("\"createdAt\":\"").append(log.getCreatedAt()).append("\"");
                json.append("}");
                if (i < pageLogs.size() - 1) {
                    json.append(",");
                }
            }
            
            json.append("]}");
            
            response.getWriter().write(json.toString());
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\":\"" + e.getMessage() + "\"}");
        }
    }
}

@WebServlet("/searchLogs")
class SearchLogsServlet extends HttpServlet {
    private LogDAOImpl logDAO = new LogDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String query = request.getParameter("query").toLowerCase();
        List<Log> logs = logDAO.findAll().stream()
                .filter(log -> 
                    log.getAction().toLowerCase().contains(query) ||
                    log.getLevel().toString().toLowerCase().contains(query) ||
                    log.getAddressIP().toLowerCase().contains(query))
                .collect(Collectors.toList());

        StringBuilder json = new StringBuilder();
        json.append("[");
        
        for (int i = 0; i < logs.size(); i++) {
            Log log = logs.get(i);
            json.append("{");
            json.append("\"id\":").append(log.getId()).append(",");
            json.append("\"level\":\"").append(log.getLevel()).append("\",");
            json.append("\"action\":\"").append(log.getAction()).append("\",");
            json.append("\"addressIP\":\"").append(log.getAddressIP()).append("\",");
            json.append("\"userId\":").append(log.getUserId()).append(",");
            json.append("\"createdAt\":\"").append(log.getCreatedAt()).append("\"");
            json.append("}");
            if (i < logs.size() - 1) {
                json.append(",");
            }
        }
        
        json.append("]");
        
        response.getWriter().write(json.toString());
    }
} 