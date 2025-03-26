package service;

public interface ILogService {
    void info(String message);
    void alert(String message) ;
    void warning(String message) ;
    void danger(String message) ;
    void error(String message) ;
}
