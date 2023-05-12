package com.petworld.dto.cartDto.response;

import com.petworld.domain.Cart;
import com.petworld.domain.Product;
import com.petworld.dto.productDto.response.ProductDtoResponse;
import lombok.*;

import javax.persistence.*;
@Data
@AllArgsConstructor
@NoArgsConstructor
public class CartDetailDtoResponse {
    private Long id;
    private Integer amount;
    private Double totalPrice;
    private Boolean status;
    private ProductDtoResponse productDtoResponse;
//    private Cart cart;
}
