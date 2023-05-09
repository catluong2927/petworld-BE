package com.petworld.dto.categoryDto.response;

import com.petworld.dto.productDto.response.ProductDtoResponse;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.data.domain.Page;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class CategoryDtoResponse {
    private Long id;
    private String name;
    Page<ProductDtoResponse> productDtoResponses;
}
