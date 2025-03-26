package model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.json.JSONObject;
import utils.LevelLog;

import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Log {
    private Integer id;
    private LevelLog level;
    private String action;
    private String addressIP;
    private Integer userId;
    private LocalDateTime createdAt;
}
