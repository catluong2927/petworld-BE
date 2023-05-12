package com.petworld.service;

import com.petworld.dto.categoryDto.response.CategoryDtoResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.Optional;

public interface ICategoryService {
    Page<CategoryDtoResponse> getAllCategory(Pageable pageable);

    Optional<CategoryDtoResponse> getById(Long id);


}
