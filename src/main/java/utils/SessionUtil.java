package utils;

import model.User;
import service.impl.LogServiceImpl;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;
import java.util.Enumeration;

public class SessionUtil {

    private static SessionUtil instance = null;
    private static final Map<String, HttpSession> sessions = new HashMap<>();
    private static final LogServiceImpl logService = new LogServiceImpl();

    public static SessionUtil getInstance(){
        if (instance == null)
            instance = new SessionUtil();
        return instance;
    }

    public void putKey(HttpServletRequest req, String key, Object value) {
        HttpSession session = req.getSession();
        session.setAttribute(key, value);
        
        // Luôn lưu session vào map
        sessions.put(session.getId(), session);
        
        if (key.equals("user") && value instanceof User) {
            User user = (User) value;
            logService.info("Session created for user: " + user.getUsername() + " (ID: " + user.getId() + ")");
        }
    }

    public void delKey(HttpServletRequest req, String key) {
        HttpSession session = req.getSession();
        session.removeAttribute(key);
        if (key.equals("user")) {
            sessions.remove(session.getId());
            logService.info("Session removed for session ID: " + session.getId());
        }
    }

    public Object getKey(HttpServletRequest req, String key) {
        HttpSession session = req.getSession();
        return session.getAttribute(key);
    }

    public HttpSession getSessionByUserId(int userId) {
        for (HttpSession session : sessions.values()) {
            try {
                User user = (User) session.getAttribute("user");
                if (user != null && user.getId() == userId) {
                    return session;
                }
            } catch (IllegalStateException e) {
                // Session đã bị vô hiệu hóa, bỏ qua
                continue;
            }
        }
        return null;
    }

    public void invalidateAllUserSessions(int userId) {
        logService.info("Starting to invalidate all sessions for user ID: " + userId);
        Map<String, HttpSession> sessionsCopy = new HashMap<>(sessions);
        int invalidatedCount = 0;
        
        for (Map.Entry<String, HttpSession> entry : sessionsCopy.entrySet()) {
            HttpSession session = entry.getValue();
            try {
                User user = (User) session.getAttribute("user");
                if (user != null && user.getId() == userId) {
                    logService.info("Invalidating session for user: " + user.getUsername() + " (Session ID: " + session.getId() + ")");
                    
                    // Xóa tất cả attributes
                    Enumeration<String> attributeNames = session.getAttributeNames();
                    while (attributeNames.hasMoreElements()) {
                        String attributeName = attributeNames.nextElement();
                        session.removeAttribute(attributeName);
                    }
                    
                    // Vô hiệu hóa session
                    session.invalidate();
                    sessions.remove(entry.getKey());
                    invalidatedCount++;
                }
            } catch (IllegalStateException e) {
                logService.info("Session already invalidated: " + entry.getKey());
                sessions.remove(entry.getKey());
            }
        }
        
        logService.info("Completed invalidating sessions for user ID: " + userId + ". Total sessions invalidated: " + invalidatedCount);
    }

    // Thêm method để lấy tất cả sessions
    public Map<String, HttpSession> getAllSessions() {
        return new HashMap<>(sessions);
    }
}
