package com.petworld.service.impl;

import com.petworld.converter.OrderDetailConverter;
import com.petworld.domain.OrderDetail;
import com.petworld.dto.order.OrderDetailDtoRequest;
import com.petworld.dto.order.OrderDetailDtoResponse;
import com.petworld.repository.OrderDetailRepository;
import com.petworld.service.OrderDetailService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class OrderDetailServiceImpl implements OrderDetailService{
    private final OrderDetailRepository orderDetailRepository;
    private final OrderDetailConverter orderDetailConverter;


    @Override
    public OrderDetail saveOrderDetail(OrderDetail orderDetail) {
       return orderDetailRepository.save(orderDetail);
    }
}
