package com.petworld.dto.productDto.request;

import com.petworld.entity.ImageDetail;
import com.petworld.dto.markDto.request.MarkDtoRequest;
import lombok.*;

import java.util.List;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class UpdateProductDtoRequest {
    private Long id;
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
    private Boolean status;
    private Integer sale;
    private MarkDtoRequest mark;
    private List<ImageDetail> imageDetailList;

}
