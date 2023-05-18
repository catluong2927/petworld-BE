package com.petworld.service.impl;

import com.petworld.domain.Order;
import com.petworld.dto.order.OrderDtoResponse;
import com.petworld.repository.OrderRepository;
import com.petworld.service.OrderService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class OrderServiceImpl implements OrderService {
    private final OrderRepository orderRepository;


    @Override
    public List<OrderDtoResponse> findOrderByEmail(String email) {
        List<Order> orders = orderRepository.findOrderByUserEmail(email);
        List<OrderDtoResponse> orderDtoResponses = new ArrayList<>();
        OrderDtoResponse orderDtoResponse = new OrderDtoResponse();
        orders.forEach(element -> {
            BeanUtils.copyProperties(element, orderDtoResponse);
            orderDtoResponses.add(orderDtoResponse);
        });
        return null;
    }
}
