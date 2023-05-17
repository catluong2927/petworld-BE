package com.petworld.dto.cartDto.request;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CartDetailDtoRequest {
    private Long productId;
    private Integer amount;
    private Double totalPrice;
}
