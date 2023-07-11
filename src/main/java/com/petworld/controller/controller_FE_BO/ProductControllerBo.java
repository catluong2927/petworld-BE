package com.petworld.controller.controller_FE_BO;

import com.petworld.dto.productDto.request.ProductDtoRequest;
import com.petworld.dto.productDto.request.UpdateProductDtoRequest;
import com.petworld.dto.productDto.response.ProductDetailDtoResponse;
import com.petworld.dto.productDto.response.ProductDtoResponse;
import com.petworld.service.ProductService;
import com.petworld.service.SecurityService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin("*")
@RestController
@RequestMapping("/api/productsBo")
@RequiredArgsConstructor
public class ProductControllerBo {

    private final SecurityService securityService;
    private final ProductService productService;
    @GetMapping("")
    public ResponseEntity<?> getAllProducts(@PageableDefault(size = 9) Pageable pageable,
                                            @RequestHeader("Authorization") final String authToken) {
        if (!securityService.isAuthenticated() && !securityService.isValidToken(authToken)) {
            return new ResponseEntity<String>("Responding with unauthorized error. Message - {}", HttpStatus.UNAUTHORIZED);
        }
        Page<ProductDtoResponse> productDtoResponses = productService.getAllProductBo( pageable);
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
        return new ResponseEntity<>(productDetailDtoResponse,HttpStatus.NO_CONTENT);
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> updateProductById(@PathVariable("id") Long id,
                                               @RequestBody UpdateProductDtoRequest updateProductDtoRequest) {
        ProductDetailDtoResponse productDetailDtoResponse = productService.updateProductById(id, updateProductDtoRequest);
        return new ResponseEntity<>(productDetailDtoResponse, HttpStatus.OK);
    }

    @GetMapping("search")
    public ResponseEntity<?> findProductByName(@RequestParam ("name") String name) {
        List<ProductDtoResponse> productDtoResponse = productService.findProductByName(name);
        return new ResponseEntity<>(productDtoResponse, HttpStatus.OK);

    }
}
