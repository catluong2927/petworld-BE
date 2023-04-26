package com.petworld.dto.productDto.request;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class ProductDtoRequest {
    private Long id;
    private String name;
    private String description;
    private String image;
    private Double price;
    private boolean status = true;
}
