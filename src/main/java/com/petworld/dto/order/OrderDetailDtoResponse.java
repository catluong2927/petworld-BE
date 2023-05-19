package com.petworld.dto.order;

import com.petworld.domain.Orders;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class OrderDetailDtoResponse {
    private Long id;
    private String itemName;
    private Integer quantity;
    private Double total;
    private String note;

    private OrdersDtoResponse orders;
}
