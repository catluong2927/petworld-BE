package com.petworld.service;

import com.petworld.dto.cartDto.response.CartDtoResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface CartService {
    Page<CartDtoResponse> getAllCarts(Pageable pageable);
    CartDtoResponse getCartById(Long id);
    void addToCart(String username, Long productId, int quantity);
    void removeToCart (String username, Long productId);

//    void addToCart(Long cartId, Long productId, int quantity);
//    void removeToCart (Long cartId, Long productId);
}
