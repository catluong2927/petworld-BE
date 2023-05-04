package com.petworld.controller.controller_FE_SE;

import com.petworld.domain.Product;
import com.petworld.dto.productDto.request.ProductDtoRequest;
import com.petworld.dto.productDto.request.UpdateProductDtoRequest;
import com.petworld.dto.productDto.response.ProductDetailDtoResponse;
import com.petworld.dto.productDto.response.ProductDtoResponse;
import com.petworld.repository.ProductRepository;
import com.petworld.service.IProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;
import java.util.Set;

@CrossOrigin("*")
@RestController
@RequestMapping("/api/products")
@RequiredArgsConstructor
public class ProductController {
    private final IProductService productService;

    @GetMapping("")
    public ResponseEntity<?> findAllProducts() {
        List<ProductDtoResponse> productDtoResponses = productService.findAllProducts();
        if (productDtoResponses.isEmpty()) {
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        }
        return new ResponseEntity<>(productDtoResponses, HttpStatus.OK);
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> findProductById(@PathVariable("id") Long id){
        ProductDetailDtoResponse productDetailDtoResponse = productService.findById(id);
        if (productDetailDtoResponse == null) {
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        }
        return new ResponseEntity<>(productDetailDtoResponse, HttpStatus.OK);
    }

    @PostMapping("")
    public ResponseEntity<?> addProduct(@RequestBody ProductDtoRequest productDtoRequest){
        if(productDtoRequest != null) {
            productService.addProduct(productDtoRequest);
            return new ResponseEntity<>(HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        }
    }
    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteProductById(@PathVariable("id") Long id) {
        if(id != null) {
            ProductDetailDtoResponse productDetailDtoResponse = productService.findById(id);
            if (productDetailDtoResponse != null) {
                productService.deleteProductById(id);
                return new ResponseEntity<>(HttpStatus.OK);
            }
        }
        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> updateProductById(@PathVariable("id") Long id,
                                               @RequestBody UpdateProductDtoRequest updateProductDtoRequest) {
        if(id != null && updateProductDtoRequest != null) {
            ProductDetailDtoResponse productDetailDtoResponse = productService.updateProductById(id, updateProductDtoRequest);
            return new ResponseEntity<>(productDetailDtoResponse, HttpStatus.OK);
        }
        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
    }

}
