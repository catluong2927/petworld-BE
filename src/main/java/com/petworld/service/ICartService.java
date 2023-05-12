package com.petworld.service;

import com.petworld.dto.cartDto.request.CartDetailDtoRequest;
import com.petworld.dto.cartDto.response.CartDtoResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface ICartService {
    Page<CartDtoResponse> getAllCarts(Pageable pageable);
    CartDtoResponse getCartByEmail(String email);
    void addToCart(String email, CartDetailDtoRequest cartDetailDtoRequest);
    void removeToCart (String username, Long productId);

//    void addToCart(String username, Long productId, int quantity);
//    void addToCart(Long cartId, Long productId, int quantity);
//    void removeToCart (Long cartId, Long productId);
}
