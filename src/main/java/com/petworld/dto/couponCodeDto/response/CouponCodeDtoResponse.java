package com.petworld.dto.couponCodeDto.response;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Column;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CouponCodeDtoResponse {
    private String code;
    private Integer discount;
}
