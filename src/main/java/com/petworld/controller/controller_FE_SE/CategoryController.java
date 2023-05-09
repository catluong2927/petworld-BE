package com.petworld.controller.controller_FE_SE;

import com.petworld.domain.Category;
import com.petworld.dto.categoryDto.response.CategoryDtoResponse;
import com.petworld.repository.CategoryRepository;
import com.petworld.service.ICategoryService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("api/categorys")
public class CategoryController {
    private final ICategoryService categoryService;

    private final CategoryRepository categoryRepository;
    @GetMapping("")
    public ResponseEntity<?> getAllCategory(){
        List<Category> categorys = categoryRepository.findAll();
        return new ResponseEntity<>(categorys, HttpStatus.OK);
    }
}
