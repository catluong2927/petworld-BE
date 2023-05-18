package com.petworld.dto.cartDto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CartDetailDto {
  private Long id;
  private String  name;
  private  Double price;
  private Float minPrice;
  private Float maxPrice;
  private Integer amount;
  private Double totalPrice;

}
