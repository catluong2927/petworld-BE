package com.petworld.converter;

import com.petworld.dto.FavoriteDto.response.FavoriteDtoResponse;
import com.petworld.dto.userDto.response.UserDtoResponse;
import com.petworld.entity.Favorite;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class FavoriteConverter {

    public FavoriteDtoResponse entityToDto(Favorite favorite) {
        FavoriteDtoResponse favoriteDtoResponse = new FavoriteDtoResponse();
        BeanUtils.copyProperties(favorite,favoriteDtoResponse);
        return favoriteDtoResponse;
    }
}
