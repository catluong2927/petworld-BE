package com.petworld.controller.controller_FE_SE;

import com.petworld.dto.cartDto.response.CartDtoResponse;
import com.petworld.service.ICartService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/cart")
@RequiredArgsConstructor
public class CartController {

    private final ICartService cartService;

    @GetMapping("")
    public ResponseEntity<?> getAllCarts(@PageableDefault(size = 9) Pageable pageable) {
        Page<CartDtoResponse> cartDtoResponses = cartService.getAllCarts(pageable);
        return new ResponseEntity<>(cartDtoResponses, HttpStatus.OK);
    }


    @GetMapping("/{id}")
    public ResponseEntity<?> getCartById(@PathVariable("id") Long customerId) {
        CartDtoResponse cartDtoResponses = cartService.getCartById(customerId);
        return new ResponseEntity<>(cartDtoResponses, HttpStatus.OK);
    }

    @PostMapping("/{pId}/{quantity}/{username}")
    public ResponseEntity<?> addToCart(@PathVariable("pId") Long productId,
                                       @PathVariable("quantity") Integer quantity,
                                       @PathVariable("username") String username){

        cartService.addToCart(username,productId,quantity);
        return new ResponseEntity<>("Product added to cart successfully.", HttpStatus.OK);
    }

    @DeleteMapping("/{pId}/{username}")
    public ResponseEntity<?> deleteProductInCart(@PathVariable("pId") Long productId,
                                       @PathVariable("username") String username){

        cartService.removeToCart(username,productId);
        return new ResponseEntity<>("Product is removed successfully.", HttpStatus.OK);
    }
}
