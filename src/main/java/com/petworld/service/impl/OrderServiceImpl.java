package com.petworld.service.impl;

import com.petworld.converter.OrderConverter;
import com.petworld.converter.OrderDetailConverter;
import com.petworld.domain.OrderDetail;
import com.petworld.domain.Orders;
import com.petworld.domain.User;
import com.petworld.dto.order.OrderDetailDtoRequest;
import com.petworld.dto.order.OrderDetailDtoResponse;
import com.petworld.dto.order.OrdersDtoRequest;
import com.petworld.dto.order.OrdersDtoResponse;
import com.petworld.repository.OrderRepository;
import com.petworld.repository.UserRepository;
import com.petworld.service.OrderDetailService;
import com.petworld.service.OrderService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class OrderServiceImpl implements OrderService {
    private final OrderRepository orderRepository;
    private final OrderConverter orderConverter;
    private final OrderDetailService orderDetailService;
    private final OrderDetailConverter orderDetailConverter;
    private final UserRepository userRepository;


    @Override
    public List<OrdersDtoResponse> findOrderByEmail(String email) {
        List< Orders> orders = orderRepository.findOrdersByUserEmail(email);
        List<OrdersDtoResponse> ordersDtoResponses = new ArrayList<>();
        orders.forEach(element -> ordersDtoResponses.add(orderConverter.entityToDto(element)));
        return ordersDtoResponses;
    }

    @Override
    public OrdersDtoResponse saveOrder(OrdersDtoRequest ordersDtoRequest) {
        Orders orders = orderConverter.dtoToEntity(ordersDtoRequest);
        Orders savedOrders = orderRepository.save(orders);
        List<OrderDetailDtoRequest> orderDetailDtoRequests = ordersDtoRequest.getOrderDetailDtoRequests();
        List<OrderDetail> orderDetails = new ArrayList<>();
        orderDetailDtoRequests.forEach(element -> {
            OrderDetail orderDetail = orderDetailConverter.dtoToEntity(element);
            orderDetail.setOrders(savedOrders);
            orderDetailService.saveOrderDetail(orderDetail);
            orderDetails.add(orderDetail);
        });
        savedOrders.setOrderDetails(orderDetails);
        return orderConverter.entityToDto(savedOrders);
    }
}
