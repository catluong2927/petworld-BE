package com.petworld.converter;

import com.petworld.dto.favoriteProductDto.request.FavoriteProductDtoRequest;
import com.petworld.dto.favoriteProductDto.response.FavoriteProductDtoResponse;
import com.petworld.entity.Favorite;
import com.petworld.entity.FavoriteProduct;
import com.petworld.entity.Product;
import com.petworld.repository.FavoriteRepository;
import com.petworld.repository.ProductRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Component;

import java.util.Optional;

@Component
@RequiredArgsConstructor
public class FavoriteProductConverter {
    private final ProductRepository productRepository;
    private final FavoriteRepository favoriteRepository;
    private final ProductConverter productConverter;
    private final FavoriteConverter favoriteConverter;

    public FavoriteProductDtoResponse entityToDto(FavoriteProduct favoriteProduct){
        FavoriteProductDtoResponse favoriteProductDtoResponse = new FavoriteProductDtoResponse();
        BeanUtils.copyProperties(favoriteProduct,favoriteProductDtoResponse);
        favoriteProductDtoResponse.setProductDtoResponse(productConverter.entityToDto(favoriteProduct.getProduct()));
        favoriteProductDtoResponse.setFavoriteDtoResponse(favoriteConverter.entityToDto(favoriteProduct.getFavorite()));
        return favoriteProductDtoResponse;
    }

    public FavoriteProduct dtoToEntity(FavoriteProductDtoRequest favoriteProductDtoRequest) {
        FavoriteProduct favoriteProduct = new FavoriteProduct();
        Optional<Product> product = productRepository.findById(favoriteProductDtoRequest.getProductId());
        favoriteProduct.setProduct(product.get());
        Optional<Favorite> favorite = favoriteRepository.findFavoriteByUserId(favoriteProductDtoRequest.getUserId());
        favoriteProduct.setFavorite(favorite.get());
        return favoriteProduct;
    }
}
