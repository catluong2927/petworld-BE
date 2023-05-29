package com.petworld.converter;

import com.petworld.entity.Category;
import com.petworld.entity.Product;
import com.petworld.dto.categoryDto.response.CategoryDtoResponse;
import com.petworld.dto.productDto.response.ProductDtoResponse;
import lombok.AllArgsConstructor;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
@AllArgsConstructor
public class CategoryConverter {
    private final ProductConverter productConverter;

        public CategoryDtoResponse entityToDto(Category category){
        CategoryDtoResponse categoryDto = new CategoryDtoResponse();
        BeanUtils.copyProperties(category, categoryDto);

        List<Product> products = category.getProducts();
        List<ProductDtoResponse> productDtoResponses = new ArrayList<>();
        products.forEach(product -> productDtoResponses.add(productConverter.entityToDto(product)));

        categoryDto.setProductDtoResponses(productDtoResponses);
        return categoryDto;
    }
}
