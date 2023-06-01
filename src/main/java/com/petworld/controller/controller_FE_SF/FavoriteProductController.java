package com.petworld.controller.controller_FE_SF;

import com.petworld.dto.favoriteProductDto.request.FavoriteProductDtoRequest;
import com.petworld.dto.favoriteProductDto.response.FavoriteProductDtoResponse;
import com.petworld.service.FavoriteProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.net.URI;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@RestController
@CrossOrigin("*")
@RequestMapping("/api/favorite-products")
@RequiredArgsConstructor
public class FavoriteProductController {
    private final FavoriteProductService favoriteProductService;

    @GetMapping("")
    public ResponseEntity<?> getAll(){
        List<FavoriteProductDtoResponse> favoriteProductDtoResponses = favoriteProductService.findAll();
        if (favoriteProductDtoResponses.isEmpty()) return ResponseEntity.notFound().build();
        return ResponseEntity.ok().body(favoriteProductDtoResponses);
    }
    @PostMapping("")
    public ResponseEntity<?> add(@RequestBody FavoriteProductDtoRequest favoriteProductDtoRequest){
        Optional<FavoriteProductDtoRequest> newFavoriteProduct = Optional.ofNullable(favoriteProductDtoRequest);
        if (newFavoriteProduct.isEmpty()) return ResponseEntity.badRequest().build();
        URI uri = URI.create(ServletUriComponentsBuilder.fromCurrentContextPath().
                path("api/favorite-products").toUriString());
        return ResponseEntity.created(uri).body(favoriteProductService.add(newFavoriteProduct.get()));

    }
//    @DeleteMapping("/{id}")
//    public ResponseEntity<?> delete(@PathVariable(name = "id") Long id){
//        Optional<FavoriteProductDtoResponse> favoriteProduct = favoriteProductService.getById(id);
//        if(favoriteProduct.isEmpty()) return ResponseEntity.notFound().build();
//        favoriteProductService.delete(id);
//        return ResponseEntity.ok().body(favoriteProduct);
//    }
    @DeleteMapping("")
    public void delete(@RequestBody FavoriteProductDtoRequest favoriteProductDtoRequest){
        favoriteProductService.deleteByUserIdAndProductId(favoriteProductDtoRequest.getUserId(),favoriteProductDtoRequest.getProductId());
    }
}
