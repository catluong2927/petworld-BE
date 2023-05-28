package com.petworld.service;

import com.petworld.dto.favoriteProductDto.request.FavoriteProductDtoRequest;
import com.petworld.dto.favoriteProductDto.response.FavoriteProductDtoResponse;
import com.petworld.entity.FavoriteProduct;

import java.util.List;
import java.util.Optional;

public interface FavoriteProductService {
    FavoriteProductDtoResponse add(FavoriteProductDtoRequest favoriteProductDtoRequest);

    void delete(Long id);

    List<FavoriteProductDtoResponse> findAll();

    Optional<FavoriteProductDtoResponse> getById(Long id);
}
