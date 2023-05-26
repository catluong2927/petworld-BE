package com.petworld.converter;

import com.petworld.entity.Seller;
import com.petworld.dto.sellerDto.request.SellerDtoRequest;
import com.petworld.dto.sellerDto.response.SellerDtoResponse;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Component;

@Component
public class SellerConverter {
    public SellerDtoResponse entityToDto(Seller seller){
        SellerDtoResponse sellerDtoResponse = new SellerDtoResponse();
        BeanUtils.copyProperties(seller,sellerDtoResponse);
        return sellerDtoResponse;
    }
    public Seller dtoToEntity(SellerDtoRequest sellerDtoRequest){
        Seller seller = new Seller();
        BeanUtils.copyProperties(sellerDtoRequest, seller);
        return seller;
    }
}
