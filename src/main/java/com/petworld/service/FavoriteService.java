package com.petworld.service;

import com.petworld.dto.FavoriteDto.response.FavoriteDtoResponse;
import com.petworld.entity.Favorite;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.Optional;

public interface FavoriteService {
    Page<FavoriteDtoResponse> getAll(Pageable pageable);

//    Optional<FavoriteDtoResponse> getById(Long id);
//
//    Optional<FavoriteDtoResponse> getByUserId(Long id);
 }
