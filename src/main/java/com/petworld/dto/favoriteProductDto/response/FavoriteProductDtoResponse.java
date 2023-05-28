package com.petworld.dto.favoriteProductDto.response;

import com.petworld.entity.Favorite;
import com.petworld.entity.Product;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class FavoriteProductDtoResponse {
    private Long id;
    private Favorite favorite;
    private Product product;
}
