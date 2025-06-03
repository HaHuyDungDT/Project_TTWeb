package utils;

public enum LevelLog {
    INFO("INFO"),
    WARNING("WARNING"),
    DANGER("DANGER");

    private final String level;

    LevelLog(String level) {
        this.level = level;
    }

    public String getLevel() {
        return level;
    }

    @Override
    public String toString() {
        return level;
    }
}
