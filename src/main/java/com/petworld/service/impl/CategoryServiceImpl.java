package com.petworld.service.impl;

import com.petworld.domain.Category;
import com.petworld.dto.categoryDto.response.CategoryDtoResponse;
import com.petworld.repository.CategoryRepository;
import com.petworld.service.ICategoryService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class CategoryServiceImpl implements ICategoryService {
    private final CategoryRepository categoryRepository;

    public List<Category> getAllCategory(){
        return categoryRepository.findAll();
    }

    @Override
    public Category getProductsByCategoryName(String name) {
        return null;
    }

//    @Override
//    public Category getProductsByCategoryName(String name) {
//        Category category = categoryRepository.getProductsByCategoryName(name);
//        return null;
//    }




}
