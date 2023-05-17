package com.petworld.dto.productDto.request;

import lombok.*;

import javax.persistence.Column;
import javax.persistence.criteria.CriteriaBuilder;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor

public class ProductDtoRequest {
    private String name;
    private String description;
    private String image;
    private Double price;
    private String productCode;
    private String protein;
    private String fats;
    private String carbohydrates;
    private String minerals;
    private String vitamins;
    private String animal;
    private boolean status;
    private Integer sale;
}
