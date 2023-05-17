package com.petworld.service;

import com.petworld.dto.couponCodeDto.response.CouponCodeDtoResponse;

import java.sql.Date;
import java.util.List;

public interface ICouponCodeService {
    List<CouponCodeDtoResponse> getCouponCode(Date date, Double cartTotals);
}
