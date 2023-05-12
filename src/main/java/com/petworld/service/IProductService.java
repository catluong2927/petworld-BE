package com.petworld.service;

import com.petworld.domain.Product;
import com.petworld.dto.productDto.request.ProductDtoRequest;
import com.petworld.dto.productDto.request.UpdateProductDtoRequest;
import com.petworld.dto.productDto.response.ProductDetailDtoResponse;
import com.petworld.dto.productDto.response.ProductDtoResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface IProductService {

//    Page<ProductDtoResponse> getAllProducts(Pageable pageable);
//    Page<Product> getAllProducts(Pageable pageable)
    Page<ProductDtoResponse> getAllProducts(List<Long> categoryIds,Pageable pageable);

    ProductDetailDtoResponse findById(Long id);
    void addProduct(ProductDtoRequest productDtoRequest);
    void deleteProductById(Long id);
    ProductDetailDtoResponse updateProductById(Long id, UpdateProductDtoRequest updateProductDtoRequest);



}
