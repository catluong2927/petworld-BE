package com.petworld.converter;

import com.petworld.entity.CouponCode;
import com.petworld.dto.couponCodeDto.response.CouponCodeDtoResponse;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class CouponCodeConverter {
    public List<CouponCodeDtoResponse> entitiesToResponseDtos(List<CouponCode> couponCodes) {
        List<CouponCodeDtoResponse> couponCodeDtoResponses = new ArrayList<>();
        for(CouponCode couponCode : couponCodes){
            CouponCodeDtoResponse couponCodeDtoResponse = entityToDto(couponCode);
            couponCodeDtoResponses.add(couponCodeDtoResponse);
        }
        return couponCodeDtoResponses;
    }
    public CouponCodeDtoResponse entityToDto(CouponCode couponCode){
        CouponCodeDtoResponse productDtoResponse = new CouponCodeDtoResponse();
        BeanUtils.copyProperties(couponCode, productDtoResponse);
        return productDtoResponse;
    }
}
