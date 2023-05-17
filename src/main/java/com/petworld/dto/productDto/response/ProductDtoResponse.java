package com.petworld.dto.productDto.response;

import com.petworld.domain.ImageDetail;
import com.petworld.dto.imageDetailsDto.ImageDetailsDto;
import com.petworld.dto.markDto.response.MarkDtoResponse;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class ProductDtoResponse {
    private Long id;
    private String name;
    private String image;
    private Double price;
    private String productCode;
    private Integer sale;
    private MarkDtoResponse MarkDtoResponse;


}
