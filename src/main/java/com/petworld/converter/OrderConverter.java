package com.petworld.converter;

import com.petworld.domain.OrderDetail;
import com.petworld.domain.Orders;
import com.petworld.domain.User;
import com.petworld.dto.order.OrderDetailDtoResponse;
import com.petworld.dto.order.OrdersDtoRequest;
import com.petworld.dto.order.OrdersDtoResponse;
import com.petworld.dto.userDto.response.UserDtoResponse;
import com.petworld.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
@RequiredArgsConstructor
public class OrderConverter {
    private final UserConverter userConverter;
    private final UserRepository userRepository;


    public OrdersDtoResponse entityToDto(Orders order){
        OrdersDtoResponse ordersDtoResponse = new OrdersDtoResponse();
        BeanUtils.copyProperties(order, ordersDtoResponse);
        UserDtoResponse userDtoResponse = userConverter.entityToDto(order.getUser());
        List< OrderDetailDtoResponse> orderDetailDtoResponses = new ArrayList<>();
        order.getOrderDetails().forEach(element -> {
            OrderDetailDtoResponse orderDetailDtoResponse = new OrderDetailDtoResponse();
            BeanUtils.copyProperties(element, orderDetailDtoResponse);
            orderDetailDtoResponses.add(orderDetailDtoResponse);
        });
        ordersDtoResponse.setOrderDetailDtoResponses(orderDetailDtoResponses);
        ordersDtoResponse.setUserDtoResponse(userDtoResponse);
        return ordersDtoResponse;
    };

    public Orders dtoToEntity(OrdersDtoRequest ordersDtoRequest){
        Orders orders = new Orders();
        BeanUtils.copyProperties(ordersDtoRequest, orders);
        User user = userRepository.findUserByEmail(ordersDtoRequest.getUserEmail());
        orders.setUser(user);
        return orders;
    }

}
