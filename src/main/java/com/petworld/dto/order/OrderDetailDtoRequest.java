package com.petworld.dto.order;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class OrderDtoRequest {
    private Long id;
    private String itemName;
    private Date date;

    private Double total;

    private String status;
    private String address;

    private String userEmail;
}
