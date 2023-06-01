package com.petworld.dto.FavoriteDto.response;
import com.petworld.dto.favoriteProductDto.response.FavoriteProductDtoResponse;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.util.Set;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class FavoriteDtoResponse {
    private Long id;

    private Set<FavoriteProductDtoResponse> favoriteProductDtoResponses;
}
