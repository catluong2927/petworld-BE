package com.petworld.service;

import com.petworld.dto.cartDto.request.CartDetailDtoRequest;
import com.petworld.dto.cartDto.response.CartDtoResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface CartService {
    Page<CartDtoResponse> getAllCarts(Pageable pageable);
    CartDtoResponse getCartByEmail(String email);
    void addToCart(String email, CartDetailDtoRequest cartDetailDtoRequest);
    void removeToCart (String email, Long productId);
}
