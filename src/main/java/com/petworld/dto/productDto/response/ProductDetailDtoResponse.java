package com.petworld.dto.productDto.response;
import lombok.*;


@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor

public class ProductDetailDtoResponse {
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
    private Integer sale;
}
