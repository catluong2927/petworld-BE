package com.petworld.converter;

import com.petworld.dto.FavoriteDto.response.FavoriteDtoResponse;
import com.petworld.dto.favoriteProductDto.response.FavoriteProductDtoResponse;
import com.petworld.dto.userDto.response.UserDtoResponse;
import com.petworld.entity.Favorite;
import com.petworld.entity.FavoriteProduct;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

@Component
@RequiredArgsConstructor
public class FavoriteConverter {
    private final FavoriteProductConverter favoriteProductConverter;

    public FavoriteDtoResponse entityToDto(Favorite favorite) {
        FavoriteDtoResponse favoriteDtoResponse = new FavoriteDtoResponse();
        BeanUtils.copyProperties(favorite,favoriteDtoResponse);
        List<FavoriteProduct> favoriteProducts = favorite.getFavoriteProducts();
        if (!favoriteProducts.isEmpty()) {
            List<FavoriteProductDtoResponse> favoriteProductDtoResponses = favoriteProducts.
                    stream().map(favoriteProductConverter::entityToDto).collect(Collectors.toList());
            favoriteDtoResponse.setFavoriteProductDtoResponses(favoriteProductDtoResponses);
        }
        return favoriteDtoResponse;
    }
}
