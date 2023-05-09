package com.petworld.service;

import com.petworld.domain.Category;

import java.util.List;

public interface ICategoryService {
    List<Category> getAllCategory();

    Category getProductsByCategoryName(String name);
}
