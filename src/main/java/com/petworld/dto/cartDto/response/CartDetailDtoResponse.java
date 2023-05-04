package com.petworld.dto.cartDto.response;

import com.petworld.domain.Cart;
import com.petworld.domain.Product;
import com.petworld.dto.productDto.response.ProductDtoResponse;
import lombok.*;

import javax.persistence.*;
@Data
@Getter
@Setter
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
