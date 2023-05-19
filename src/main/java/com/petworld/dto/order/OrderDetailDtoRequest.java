package com.petworld.dto.order;

import com.petworld.domain.Orders;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class OrderDetailDtoRequest {
    private Long id;
    private String itemName;
    private Integer quantity;
    private Double total;
    private String note;

    private OrdersDtoRequest ordersDtoRequest;

}
