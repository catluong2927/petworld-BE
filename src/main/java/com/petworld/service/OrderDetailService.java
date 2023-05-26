package com.petworld.service;

import com.petworld.domain.OrderDetail;
import com.petworld.dto.order.OrderDetailDtoRequest;

public interface OrderDetailService {

    OrderDetail saveOrderDetail(OrderDetail orderDetail);
}
