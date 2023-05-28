package com.petworld.service.impl;

import com.petworld.converter.FavoriteConverter;
import com.petworld.dto.FavoriteDto.response.FavoriteDtoResponse;
import com.petworld.entity.Favorite;
import com.petworld.repository.FavoriteRepository;
import com.petworld.service.FavoriteService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.Optional;
@Service
@RequiredArgsConstructor
@Transactional
public class FavoriteServiceImpl implements FavoriteService {
    private final FavoriteRepository favoriteRepository;
    private final FavoriteConverter favoriteConverter;
    @Override
    public Page<FavoriteDtoResponse> getAll(Pageable pageable) {
        Page<Favorite> favorites = favoriteRepository.findAll(pageable);

        return favorites.map(favoriteConverter::entityToDto);
    }

//    @Override
//    public Optional<FavoriteDtoResponse> getById(Long id) {
//
//        return Optional.ofNullable(favoriteRepository.getById(id));
//    }
//
//    @Override
//    public Optional<FavoriteDtoResponse> getByUserId(Long id) {
//        return favoriteRepository.findFavoriteByUserId(id);
//    }
}
