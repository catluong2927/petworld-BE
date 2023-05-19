package com.petworld.dto.order;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class OrdersDtoRequest {
    private Long id;
    private String phoneNumber;
    private String note;
    private Date date;
    private String address;
    private String status;
    private String userEmail;
    private List<OrderDetailDtoRequest> orderDetailDtoRequests = new ArrayList<>();
}
