package com.petworld.controller.controller_FE_SE;

import com.petworld.domain.Product;
import com.petworld.dto.productDto.request.ProductDtoRequest;
import com.petworld.dto.productDto.request.UpdateProductDtoRequest;
import com.petworld.dto.productDto.response.ProductDetailDtoResponse;
import com.petworld.dto.productDto.response.ProductDtoResponse;
import com.petworld.repository.ProductRepository;
import com.petworld.service.IProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@CrossOrigin("*")
@RestController
@RequestMapping("/api/products")
@RequiredArgsConstructor
public class ProductController {
    private final IProductService productService;

    @GetMapping("")
    public ResponseEntity<?> getAllProducts(@PageableDefault(size = 9) Pageable pageable) {
        Page<ProductDtoResponse> productDtoResponses;
        productDtoResponses = productService.getAllProducts(pageable);
        return new ResponseEntity<>(productDtoResponses, HttpStatus.OK);
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> findProductById(@PathVariable("id") Long id){
        ProductDetailDtoResponse productDetailDtoResponse = productService.findById(id);
        return new ResponseEntity<>(productDetailDtoResponse, HttpStatus.OK);
    }

    @PostMapping("")
    public ResponseEntity<?> addProduct(@RequestBody ProductDtoRequest productDtoRequest){
            productService.addProduct(productDtoRequest);
            return new ResponseEntity<>(HttpStatus.OK);
    }
    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteProductById(@PathVariable("id") Long id) {
        ProductDetailDtoResponse productDetailDtoResponse = productService.findById(id);
        productService.deleteProductById(id);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> updateProductById(@PathVariable("id") Long id,
                                               @RequestBody UpdateProductDtoRequest updateProductDtoRequest) {
        ProductDetailDtoResponse productDetailDtoResponse = productService.updateProductById(id, updateProductDtoRequest);
        return new ResponseEntity<>(productDetailDtoResponse, HttpStatus.OK);
    }

}
