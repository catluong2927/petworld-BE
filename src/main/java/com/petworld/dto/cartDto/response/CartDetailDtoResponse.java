package com.petworld.dto.cartDto.response;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CartDetailDtoResponse {
  private Long id;
  private Boolean type;
  private String  name;
  private  Double price;
  private Double originalPrice;

  private Integer amount;
  private String image;
  private Long typeId;
  private Double totalPrice;

}
