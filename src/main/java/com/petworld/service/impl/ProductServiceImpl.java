package com.petworld.service.impl;

import com.petworld.converter.CategoryConverter;
import com.petworld.converter.ProductConverter;
import com.petworld.dto.categoryDto.response.CategoryDtoResponse;
import com.petworld.entity.Product;
import com.petworld.dto.productDto.request.ProductDtoRequest;
import com.petworld.dto.productDto.request.UpdateProductDtoRequest;
import com.petworld.dto.productDto.response.ProductDetailDtoResponse;
import com.petworld.dto.productDto.response.ProductDtoResponse;
import com.petworld.repository.CategoryRepository;
import com.petworld.repository.ImageDetailRepository;
import com.petworld.repository.MarkRepository;
import com.petworld.repository.ProductRepository;
import com.petworld.service.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
@RequiredArgsConstructor
public class ProductServiceImpl implements ProductService {
    private final ProductRepository productRepository;
    private final ProductConverter productConverter;
    private final CategoryRepository categoryRepository;
    private final ImageDetailRepository imageDetailRepository;
    private final CategoryConverter categoryConverter;
    private final MarkRepository markRepository;

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
            CategoryDtoResponse categoryDtoResponse = categoryConverter.entityToDto(product.getCategory());

            productDetailDtoResponse.setCategoryDtoResponse(categoryDtoResponse);
            return productDetailDtoResponse;
        }
        return null;
    }

    @Override
    public void addProduct(ProductDtoRequest productDtoRequest) {
        if (productDtoRequest != null) {
            Product product = productConverter.dtoToEntity(productDtoRequest);
            product.setStatus(true);
            product.setCategory(categoryRepository.findById(productDtoRequest.getCategoryId()).get());
//            product.setMark(markRepository.findById(productDtoRequest.getMarkDtoRequestid()).get());
            productRepository.save(product);
            productDtoRequest.getImageDetail().forEach(element -> {
                element.setProduct(product);
                imageDetailRepository.save(element);
            });
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

        ProductDetailDtoResponse productDetailDtoResponse = findById(id);

        productRepository.save(product);

        return productDetailDtoResponse;
    }

    @Override
    public Page<ProductDtoResponse> getAllProductBo(Pageable pageable) {

        Page<Product> products = productRepository.getAllProductBo(pageable);
        if (!products.isEmpty()) {
            Page<ProductDtoResponse> productDtoResponses = productConverter.entitiesToDtos(products);
            return productDtoResponses;
        }
        return null;
    }
}
