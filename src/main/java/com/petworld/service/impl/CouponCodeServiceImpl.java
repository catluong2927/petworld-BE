package com.petworld.service.impl;

import com.petworld.converter.CouponCodeConverter;
import com.petworld.domain.CouponCode;
import com.petworld.dto.couponCodeDto.response.CouponCodeDtoResponse;
import com.petworld.repository.CouponCodeRepository;
import com.petworld.service.ICouponCodeService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.sql.Date;
import java.util.List;

@Service
@RequiredArgsConstructor
public class CouponCodeServiceImpl implements ICouponCodeService {
    private final CouponCodeRepository couponCodeRepository;
    private final CouponCodeConverter couponCodeConverter;
    @Override
    public List<CouponCodeDtoResponse> getCouponCode(Date date, Double cartTotals) {
        if(date != null && cartTotals != null) {
            List<CouponCode> couponCodes = couponCodeRepository.availableCouponCode(date,cartTotals);
            if (!couponCodes.isEmpty()) {
                List<CouponCodeDtoResponse> couponCodeDtoResponses = couponCodeConverter.entitiesToResponseDtos(couponCodes);
                return couponCodeDtoResponses;
            }
        }
        return null;
    }
}
