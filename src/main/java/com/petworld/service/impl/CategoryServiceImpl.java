package com.petworld.service.impl;

import com.petworld.converter.CategoryConverter;
import com.petworld.domain.Category;
import com.petworld.dto.categoryDto.response.CategoryDtoResponse;
import com.petworld.repository.CategoryRepository;
import com.petworld.service.CategoryService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
@RequiredArgsConstructor
public class CategoryServiceImpl implements CategoryService {
    private final CategoryRepository categoryRepository;
    private final CategoryConverter categoryConverter;

    public Page<CategoryDtoResponse> getAllCategory(Pageable pageable){
        Page<Category> categories = categoryRepository.findAll(pageable);
        return categories.map(categoryConverter::entityToDto);

    }

    @Override
    public Optional<CategoryDtoResponse> getById(Long id) {
        CategoryDtoResponse category = categoryConverter.entityToDto(categoryRepository.getById(id));
        return Optional.of(category);
    }
}
