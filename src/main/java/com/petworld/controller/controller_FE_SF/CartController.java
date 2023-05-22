package com.petworld.controller.controller_FE_SF;

import com.petworld.dto.cartDto.request.CartDetailDtoRequest;
import com.petworld.service.SecurityService;
import com.petworld.service.CartService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin("*")
@RestController
@RequestMapping("/api/cart")
@RequiredArgsConstructor
public class CartController {


    private final SecurityService securityService;
    private final CartService cartService;

    @GetMapping("/{email}")
    public ResponseEntity<?> getCartByEmail(@PathVariable("email") String email) {
        return new ResponseEntity<>(cartService.getCartByEmail(email), HttpStatus.OK);
    };

    @PostMapping("")
    public ResponseEntity<?> addToCart(@RequestBody CartDetailDtoRequest cartDetailDtoRequest){
        cartService.addToCart(cartDetailDtoRequest);
        return new ResponseEntity<>("Product added to cart successfully.", HttpStatus.CREATED);
    }

    @PutMapping("")
    public ResponseEntity<?> deleteProductInCart(@RequestBody CartDetailDtoRequest cartDetailDtoRequest){
        cartService.removeToCart(cartDetailDtoRequest);
        return new ResponseEntity<>("Product is removed successfully.", HttpStatus.NO_CONTENT);
    }
    @DeleteMapping("")
    public ResponseEntity<?> deleteAllProductsInCart(@RequestBody List<Long> ids){
        cartService.deleteAllItemsInCart(ids);
        return new ResponseEntity<>("Delete successfully!", HttpStatus.OK);
    }
}

