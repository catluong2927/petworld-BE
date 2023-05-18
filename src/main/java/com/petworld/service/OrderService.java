package com.petworld.service;

import com.petworld.domain.Order;
import com.petworld.dto.order.OrderDtoResponse;

import java.util.List;

public interface OrderService {
    List<OrderDtoResponse> findOrderByEmail(String email );
}
