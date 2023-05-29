package com.petworld.dto.order;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class OrderDetailDtoResponse {
    private Long id;
    private String itemName;
    private String image;

    private Integer quantity;
    private Double total;
    private String note;

    private OrdersDtoResponse orders;
}
