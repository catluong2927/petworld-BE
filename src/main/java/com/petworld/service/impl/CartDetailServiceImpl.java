package com.petworld.service.impl;

import com.petworld.converter.CartDetailConverter;
import com.petworld.domain.CartDetail;
import com.petworld.dto.cartDto.response.CartDetailDtoResponse;
import com.petworld.repository.CartDetailRepository;
import com.petworld.service.ICartDetailService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class CartDetailServiceImpl implements ICartDetailService {
    private final CartDetailRepository cartDetailRepository;
    private final CartDetailConverter cartDetailConverter;


    @Override
    public List<CartDetailDtoResponse> findAllCartDetail() {
        List<CartDetail> cartDetailList = cartDetailRepository.findAll();
        if(cartDetailList != null) {
            List<CartDetailDtoResponse> cartDetailDtoResponses = cartDetailConverter.entitiesToDtos(cartDetailList);
            if(!cartDetailDtoResponses.isEmpty()) {
                for(CartDetailDtoResponse element: cartDetailDtoResponses){
                    element.setTotalPrice(element.getProductDtoResponse().getPrice() * element.getAmount());
                }
                return cartDetailDtoResponses;
            }
            return null;
        }
        return null;
    }

    public List<CartDetailDtoResponse> findCartDetailById(Long id){
        List<CartDetail> cartDetailList = cartDetailRepository.findCartDetailById(id);
        if(cartDetailList != null) {
            List<CartDetailDtoResponse> cartDetailDtoResponses = cartDetailConverter.entitiesToDtos(cartDetailList);
            if(!cartDetailDtoResponses.isEmpty()) {
                for(CartDetailDtoResponse element: cartDetailDtoResponses){
                    element.setTotalPrice(element.getProductDtoResponse().getPrice() * element.getAmount());
                }
                return cartDetailDtoResponses;
            }
            return null;
        }
        return null;
    }

}
