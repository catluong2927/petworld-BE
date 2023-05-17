package com.petworld.service;

import com.petworld.dto.cartDto.response.CartDetailDtoResponse;

import java.util.List;

public interface CartDetailService {
    List<CartDetailDtoResponse> findAllCartDetail();
    List<CartDetailDtoResponse> findCartDetailById(Long id);
}
