package com.petworld.dto.FavoriteDto.response;
import com.petworld.dto.favoriteProductDto.response.FavoriteProductDtoResponse;
import com.petworld.entity.FavoriteProduct;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class FavoriteDtoResponse {
    private Long id;

    private List<FavoriteProductDtoResponse> favoriteProductDtoResponses;
}
