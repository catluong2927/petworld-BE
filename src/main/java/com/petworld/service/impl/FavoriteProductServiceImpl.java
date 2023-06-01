package com.petworld.service.impl;

import com.petworld.converter.FavoriteProductConverter;
import com.petworld.dto.favoriteProductDto.request.FavoriteProductDtoRequest;
import com.petworld.dto.favoriteProductDto.response.FavoriteProductDtoResponse;
import com.petworld.entity.Favorite;
import com.petworld.entity.FavoriteProduct;
import com.petworld.repository.FavoriteProductRepository;
import com.petworld.repository.FavoriteRepository;
import com.petworld.service.FavoriteProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import javax.persistence.Table;
import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Transactional
public class FavoriteProductServiceImpl implements FavoriteProductService {
    private final FavoriteProductRepository favoriteProductRepository;
    private final FavoriteProductConverter favoriteProductConverter;
    @Override
    public FavoriteProductDtoResponse add(FavoriteProductDtoRequest favoriteProductDtoRequest) {
        FavoriteProduct favoriteProduct = favoriteProductConverter.dtoToEntity(favoriteProductDtoRequest);
        favoriteProductRepository.save(favoriteProduct);
        return favoriteProductConverter.entityToDto(favoriteProduct);
    }

    @Override
    public void delete(Long id) {
        Optional<FavoriteProduct> favoriteProduct = Optional.ofNullable(favoriteProductRepository.getById(id));
        favoriteProductRepository.deleteById(id);
    }

    @Override
    public List<FavoriteProductDtoResponse> findAll() {
        List<FavoriteProduct> favoriteProducts = favoriteProductRepository.findAll();
        List<FavoriteProductDtoResponse> favoriteProductDtoResponses = new ArrayList<>();
        favoriteProductDtoResponses.addAll(favoriteProducts.stream().map(favoriteProductConverter::entityToDto).collect(Collectors.toList()));
        return favoriteProductDtoResponses;
    }

    @Override
    public Optional<FavoriteProductDtoResponse> getById(Long id) {
        Optional<FavoriteProduct> favoriteProduct = Optional.ofNullable(favoriteProductRepository.getById(id));
        return Optional.ofNullable(favoriteProductConverter.entityToDto(favoriteProduct.get()));
    }

    @Override
    public void deleteByUserIdAndProductId(Long userId, Long productId) {
        favoriteProductRepository.deleteFavoriteProductByFavoriteUserIdAndProductId(userId,productId);
    }
}
