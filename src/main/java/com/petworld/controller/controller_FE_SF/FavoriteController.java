package com.petworld.controller.controller_FE_SF;

import com.petworld.dto.FavoriteDto.response.FavoriteDtoResponse;
import com.petworld.entity.Favorite;
import com.petworld.service.FavoriteService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@CrossOrigin("*")
@RequestMapping("/api/favorites")
@RequiredArgsConstructor
public class FavoriteController {
    private final FavoriteService favoriteService;
    @GetMapping("")
    public ResponseEntity<?> findAll(Pageable pageable){
        Page<FavoriteDtoResponse> favorites = favoriteService.getAll(pageable);
        if(favorites.isEmpty()) return ResponseEntity.notFound().build();
        return ResponseEntity.ok().body(favorites);
    }
}
