package com.petworld.converter;

import com.petworld.domain.OrderDetail;
import com.petworld.domain.Orders;
import com.petworld.dto.order.OrderDetailDtoRequest;
import com.petworld.dto.order.OrderDetailDtoResponse;
import com.petworld.dto.order.OrdersDtoResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class OrderDetailConverter {
    private final OrderConverter orderConverter;

    public OrderDetailDtoResponse entityToDto(OrderDetail orderDetail){
        OrderDetailDtoResponse orderDetailDtoResponse = new OrderDetailDtoResponse();
        BeanUtils.copyProperties(orderDetail, orderDetailDtoResponse);
        OrdersDtoResponse ordersDtoResponse = orderConverter.entityToDto(orderDetail.getOrders());
        orderDetailDtoResponse.setOrders(ordersDtoResponse);
        return orderDetailDtoResponse;
    };

    public OrderDetail dtoToEntity(OrderDetailDtoRequest orderDetailDtoRequest){
        OrderDetail orderDetail = new OrderDetail();
        BeanUtils.copyProperties(orderDetailDtoRequest, orderDetail);
        return orderDetail;
    }
}
