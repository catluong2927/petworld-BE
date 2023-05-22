package com.petworld.service;

import com.petworld.domain.Orders;
import com.petworld.dto.order.OrderDetailDtoRequest;
import com.petworld.dto.order.OrderDetailDtoResponse;
import com.petworld.dto.order.OrdersDtoRequest;
import com.petworld.dto.order.OrdersDtoResponse;

import java.util.List;

public interface OrderService {
    List<OrdersDtoResponse> findOrderByEmail(String email);

    OrdersDtoResponse saveOrder(OrdersDtoRequest ordersDtoRequest);
}
