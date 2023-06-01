package com.petworld.controller.controller_FE_SF;

import com.petworld.dto.FavoriteDto.response.FavoriteDtoResponse;
import com.petworld.entity.Favorite;
import com.petworld.service.FavoriteService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

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

    @GetMapping("/{id}")
    public ResponseEntity<?> findById(@PathVariable("id") Long id) {
         if(favoriteService.getById(id).isEmpty()) return ResponseEntity.notFound().build();
         return ResponseEntity.ok().body(favoriteService.getById(id).get());
    }

    @GetMapping("/user/{id}")
    public ResponseEntity<?> findByUserId (@PathVariable("id") Long id){
        Optional<FavoriteDtoResponse> favorite = favoriteService.getByUserId(id);
        if (favorite.isEmpty()) return ResponseEntity.notFound().build();
        return ResponseEntity.ok().body(favorite);
    }
}
