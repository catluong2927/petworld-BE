package com.petworld.dto.productDto.response;
import com.petworld.domain.ImageDetail;
import com.petworld.domain.Mark;
import com.petworld.dto.imageDetailsDto.ImageDetailsDto;
import lombok.*;

import java.util.List;


@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor

public class ProductDetailDtoResponse {
    private long id ;
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
    private Mark mark;
    private List<ImageDetailsDto> imageDetailList;
}
