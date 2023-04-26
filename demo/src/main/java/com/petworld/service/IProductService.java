package com.petworld.service;

import com.petworld.dto.productDto.response.ProductDetailDtoResponse;
import com.petworld.dto.productDto.response.ProductDtoResponse;

import java.util.List;

public interface IProductService {
    public List<ProductDtoResponse> findAllProducts();

    public ProductDetailDtoResponse findById(Long id);
}
