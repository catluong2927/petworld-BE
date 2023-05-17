package com.petworld.dto.cartDto.response;

import com.petworld.dto.productDto.response.ProductDtoResponse;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CartDetailDtoResponse {
    private Long id;
    private Double totalPrice;
    private Integer amount;
    private Boolean status;
    private ProductDtoResponse productDtoResponse;
//    private Cart cart;
}
