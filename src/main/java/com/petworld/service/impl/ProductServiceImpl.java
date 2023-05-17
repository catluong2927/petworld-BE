package com.petworld.service.impl;

import com.petworld.converter.ProductConverter;
import com.petworld.domain.Product;
import com.petworld.dto.productDto.request.ProductDtoRequest;
import com.petworld.dto.productDto.request.UpdateProductDtoRequest;
import com.petworld.dto.productDto.response.ProductDetailDtoResponse;
import com.petworld.dto.productDto.response.ProductDtoResponse;
import com.petworld.repository.ProductRepository;
import com.petworld.service.IProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
@RequiredArgsConstructor
public class ProductServiceImpl implements IProductService {
    private final ProductRepository productRepository;
    private final ProductConverter productConverter;

    @Override
    public Page<ProductDtoResponse> getAllProducts(List<Long> categoryIds,Pageable pageable) {
        Page<Product> products;
        if(categoryIds.isEmpty()) {
            products = productRepository.getAllProducts(pageable);
        } else {
            products = productRepository.findByCategoryIds(categoryIds, pageable);
        }

        if (!products.isEmpty()) {
            Page<ProductDtoResponse> productDtoResponses = productConverter.entitiesToDtos(products);
            return productDtoResponses;
        }
        return null;
    }

    @Override
    public ProductDetailDtoResponse findById(Long id) {
        Product product = productRepository.findById(id).get();
        if (product != null) {
            ProductDetailDtoResponse productDetailDtoResponse = productConverter.entityToProductDetailDto(product);
            return (productDetailDtoResponse != null) ? productDetailDtoResponse : null;
        }
        return null;
    }

    @Override
    public void addProduct(ProductDtoRequest productDtoRequest) {
        if (productDtoRequest != null) {
            Product product = productConverter.dtoToEntity(productDtoRequest);
            productRepository.save(product);
        } else {
            System.out.println("Don't save database");
        }
    }

    @Override
    public void deleteProductById(Long id) {
        productRepository.deleteProductById(id);
    }

    @Override
    public ProductDetailDtoResponse updateProductById(Long id, UpdateProductDtoRequest updateProductDtoRequest) {
        Product product = productRepository.findById(id).orElse(null);
        product = productConverter.dtoToEntity(updateProductDtoRequest, product);
        productRepository.save(product);
        ProductDetailDtoResponse productDetailDtoResponse = findById(id);
        return productDetailDtoResponse;
    }
}
