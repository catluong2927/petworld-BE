package com.petworld.converter;

import com.petworld.domain.Cart;
import com.petworld.dto.cartDto.response.CartDtoResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.BeanUtils;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class CartConverter {
    private final CartDetailConverter cartDetailConverter;

    public Page<CartDtoResponse> entitiesToDtos(Page<Cart> carts ){
        Page<CartDtoResponse> cartDtoResponses = carts.map(cart -> entityToDto(cart));
        return cartDtoResponses;
    }

    public CartDtoResponse entityToDto(Cart cart){
        CartDtoResponse cartDtoResponse = new CartDtoResponse();
        BeanUtils.copyProperties(cart, cartDtoResponse);
        cartDtoResponse.setCartDetailDtoResponses(cartDetailConverter.entitiesToDtos(cart.getCartDetailList()));
        cartDtoResponse.setUserId(cart.getUser().getId());
        return cartDtoResponse;
    }
}
