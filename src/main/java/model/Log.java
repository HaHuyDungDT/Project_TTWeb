package model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import utils.LevelLog;

import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Log {
    private int id;
    private LevelLog level;
    private String action;
    private String message;
    private String addressIP;
    private Integer userId;
    private LocalDateTime createdAt;

    // Getters
    public int getId() {
        return id;
    }

    public LevelLog getLevel() {
        return level;
    }

    public String getAction() {
        return action;
    }

    public String getMessage() {
        return message;
    }

    public String getAddressIP() {
        return addressIP;
    }

    public Integer getUserId() {
        return userId;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    // Setters
    public void setId(int id) {
        this.id = id;
    }

    public void setLevel(LevelLog level) {
        this.level = level;
    }

    public void setAction(String action) {
        this.action = action;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public void setAddressIP(String addressIP) {
        this.addressIP = addressIP;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
}
