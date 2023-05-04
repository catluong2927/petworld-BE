package com.petworld.service;

import com.petworld.dto.productDto.request.ProductDtoRequest;
import com.petworld.dto.productDto.request.UpdateProductDtoRequest;
import com.petworld.dto.productDto.response.ProductDetailDtoResponse;
import com.petworld.dto.productDto.response.ProductDtoResponse;

import java.util.List;

public interface IProductService {
    List<ProductDtoResponse> findAllProducts();

    ProductDetailDtoResponse findById(Long id);
    void addProduct(ProductDtoRequest productDtoRequest);
    void deleteProductById(Long id);
    ProductDetailDtoResponse updateProductById(Long id, UpdateProductDtoRequest updateProductDtoRequest);
}
