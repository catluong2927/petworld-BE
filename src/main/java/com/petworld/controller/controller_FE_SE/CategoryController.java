package com.petworld.controller.controller_FE_SE;

import com.petworld.dto.categoryDto.response.CategoryDtoResponse;
import com.petworld.service.CategoryService;
import com.petworld.service.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
@RequiredArgsConstructor
@RequestMapping("api/categorys")
@CrossOrigin("*")
public class CategoryController {
    private final CategoryService categoryService;
    private final ProductService productService;

    @GetMapping("")
    public ResponseEntity<?> getAllCategory(Pageable pageable) {
        Page<CategoryDtoResponse> categories = categoryService.getAllCategory(pageable);
        return new ResponseEntity<>(categories, HttpStatus.OK);
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getCategoryById(@PathVariable Long id){
        Optional<CategoryDtoResponse> categoryDtoResponse = categoryService.getById(id);
        if(categoryDtoResponse.isEmpty()) return ResponseEntity.notFound().build();
        return ResponseEntity.ok().body(categoryDtoResponse);
    }

//    @GetMapping("")
//    public List<Category> getProductsByCategoryIds(@RequestParam List<Long> categoryIds) {
//        return
//    }
}
