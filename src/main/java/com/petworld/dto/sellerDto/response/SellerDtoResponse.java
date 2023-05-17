package com.petworld.dto.sellerDto.response;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class SellerDtoResponse {
    private Long id;
    private String name;
    private String phone;
    private String address;
    private Boolean isActive;
}
