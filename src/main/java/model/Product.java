package model;

import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

import java.util.Date;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Product {
    private Integer id;
    private String name;
    private Double price;
    private Integer productTypeID;
    private ProductType productType;
    private Integer quantity;
    private Integer producerID;
    private Producer producer;
    private String status;
    private Date import_date;
    private Integer couponId;
    private String detail;
    private List<Image> images;
    private List<Rate> rates;
}

