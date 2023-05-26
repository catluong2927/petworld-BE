package com.petworld.dto.cartDto.request;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CartDetailDtoRequest {
    private String userEmail;
    private Boolean type;
    private Long typeId;
    private Integer amount;
    private Double totalPrice;
}
