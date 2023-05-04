package com.petworld.service;

import com.petworld.dto.cartDto.response.CartDtoResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface ICartService {
    Page<CartDtoResponse> getAllCarts(Pageable pageable);
    CartDtoResponse getCartById(Integer id);
    void addToCart(String username, Long productId, int quantity);
    void removeToCart (String username, Long productId);

//    void addToCart(Long cartId, Long productId, int quantity);
//    void removeToCart (Long cartId, Long productId);
}
