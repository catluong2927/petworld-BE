package com.petworld.service.impl;

import com.petworld.converter.ProductConverter;
import com.petworld.domain.Product;
import com.petworld.dto.productDto.response.ProductDetailDtoResponse;
import com.petworld.dto.productDto.response.ProductDtoResponse;
import com.petworld.repository.ProductRepository;
import com.petworld.service.IProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ProductServiceImpl implements IProductService {
    private final ProductRepository productRepository;

    private final ProductConverter productConverter;

    @Override
    public List<ProductDtoResponse> findAllProducts() {
        List<Product> products = productRepository.findAllProducts();
        if(!products.isEmpty()){
            List<ProductDtoResponse> productDtoResponses = productConverter.entitiesToDtos(products);
                return productDtoResponses;
        }
        return null;
    }

    @Override
    public ProductDetailDtoResponse findById(Long id) {
        Product product = productRepository.findById(id).get();
            if(product != null){
                ProductDetailDtoResponse productDetailDtoResponse = productConverter.entityToProductDetailDto(product);
                return (productDetailDtoResponse != null) ? productDetailDtoResponse : null;
            }
        return null;
    }


}
