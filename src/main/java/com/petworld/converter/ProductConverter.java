package com.petworld.converter;

import com.petworld.domain.Product;
import com.petworld.dto.productDto.request.ProductDtoRequest;
import com.petworld.dto.productDto.response.ProductDetailDtoResponse;
import com.petworld.dto.productDto.response.ProductDtoResponse;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class ProductConverter{
    public List<ProductDtoResponse> entitiesToDtos(List<Product> products ){
        List<ProductDtoResponse> productDtoResponses = new ArrayList<>();
        for(Product element : products){
            ProductDtoResponse productDtoResponse = entityToDto(element);
            productDtoResponses.add(productDtoResponse);
        }
        return productDtoResponses;
    }
    public ProductDtoResponse entityToDto(Product product){
        ProductDtoResponse productDto = new ProductDtoResponse();
        BeanUtils.copyProperties(product, productDto);
        return productDto;
    }
    public Product dtoToEntity(ProductDtoRequest productDtoRequest){
        Product product = new Product();
        BeanUtils.copyProperties(productDtoRequest, product);
        return product;
    }

    public ProductDetailDtoResponse entityToProductDetailDto(Product product){
        ProductDetailDtoResponse productDetailDtoResponse = new ProductDetailDtoResponse();
        BeanUtils.copyProperties(product, productDetailDtoResponse);
        return productDetailDtoResponse;
    }

}
