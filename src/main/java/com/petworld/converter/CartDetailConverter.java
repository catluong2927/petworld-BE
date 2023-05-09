package com.petworld.converter;

import com.petworld.domain.CartDetail;
import com.petworld.dto.cartDto.response.CartDetailDtoResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
@RequiredArgsConstructor
public class CartDetailConverter {

    private final ProductConverter productConverter;

    public List<CartDetailDtoResponse> entitiesToDtos(List<CartDetail> cartDetailList ){
        List<CartDetailDtoResponse> cartDetailDtoResponses = new ArrayList<>();
        if(!cartDetailList.isEmpty()) {
            for(CartDetail element : cartDetailList){
                CartDetailDtoResponse cartDetailDtoResponse = entityToDto(element);
                cartDetailDtoResponses.add(cartDetailDtoResponse);
            }
            return cartDetailDtoResponses;
        }
        return null;
    }
    public CartDetailDtoResponse entityToDto(CartDetail cartDetail){
        CartDetailDtoResponse cartDetailDtoResponse = new CartDetailDtoResponse();
        BeanUtils.copyProperties(cartDetail, cartDetailDtoResponse);
        cartDetailDtoResponse.setProductDtoResponse(productConverter.entityToDto(cartDetail.getProduct()));
        cartDetailDtoResponse.setTotalPrice(cartDetail.getAmount() * cartDetail.getProduct().getPrice());
        return cartDetailDtoResponse;
    }
}
