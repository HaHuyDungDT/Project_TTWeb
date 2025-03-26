package model;

import java.sql.Date;

public class Parameter {
    private String id;
    private double number_cus;
    private double number_pro;
    private double number_ord;
    private double revenue;
    private Date update_date;
    public Parameter() {
    }

    public Parameter(String id, double number_cus, double number_pro, double number_ord, double revenue, Date update_date) {
        this.id = id;
        this.number_cus = number_cus;
        this.number_pro = number_pro;
        this.number_ord = number_ord;
        this.revenue = revenue;
        this.update_date = update_date;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public double getNumber_cus() {
        return number_cus;
    }

    public void setNumber_cus(double number_cus) {
        this.number_cus = number_cus;
    }

    public double getNumber_pro() {
        return number_pro;
    }

    public void setNumber_pro(double number_pro) {
        this.number_pro = number_pro;
    }

    public double getNumber_ord() {
        return number_ord;
    }

    public void setNumber_ord(double number_ord) {
        this.number_ord = number_ord;
    }

    public double getRevenue() {
        return revenue;
    }

    public void setRevenue(double revenue) {
        this.revenue = revenue;
    }

    public Date getUpdate_date() {
        return update_date;
    }

    public void setUpdate_date(Date update_date) {
        this.update_date = update_date;
    }

    @Override
    public String toString() {
        return "Parameter{" +
                "id='" + id + '\'' +
                ", number_cus=" + number_cus +
                ", number_pro=" + number_pro +
                ", number_ord=" + number_ord +
                ", revenue=" + revenue +
                ", update_date=" + update_date +
                '}';
    }
}