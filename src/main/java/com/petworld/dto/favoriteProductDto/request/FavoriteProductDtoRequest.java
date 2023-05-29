package com.petworld.dto.favoriteProductDto.request;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class FavoriteProductDtoRequest {
    private Long id;
    private Long productId;
    private Long userId;
}
