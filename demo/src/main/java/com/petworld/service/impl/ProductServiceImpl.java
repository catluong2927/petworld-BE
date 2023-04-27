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
import lombok.extern.slf4j.Slf4j;
import org.apache.juli.logging.Log;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
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
    @Override
    public void addProduct(ProductDtoRequest productDtoRequest){
        if(productDtoRequest != null){
            Product product = productConverter.dtoToEntity(productDtoRequest);
            productRepository.save(product);
        } else {
            System.out.println("Don't save database");
        }
    }

    @Override
    public void deleteProductById(Long id){
        productRepository.deleteProductById(id);
    }

    @Override
    public ProductDetailDtoResponse updateProductById(Long id, UpdateProductDtoRequest updateProductDtoRequest) {
        ProductDetailDtoResponse productDetailDtoResponse = findById(id);
        if(checkExist(id)) {
            Product product = productRepository.findById(id).get();
            if (product != null) {
                product = productConverter.dtoToEntity(updateProductDtoRequest, product);
                productRepository.save(product);
                return productDetailDtoResponse;
            }
        }
        return null;
    }

    public Boolean checkExist(Long id) {
        ProductDetailDtoResponse productDetailDtoResponse = findById(id);
        if(productDetailDtoResponse != null)
            return true;
        return false;
    }
}
