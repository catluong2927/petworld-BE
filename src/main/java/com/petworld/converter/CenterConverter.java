package com.petworld.converter;

import com.petworld.entity.Center;
import com.petworld.entity.User;
import com.petworld.dto.centerDto.request.CenterDtoRequest;
import com.petworld.dto.centerDto.response.CenterDtoResponse;
import com.petworld.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class CenterConverter {
    private final UserRepository userRepository;
    public CenterDtoResponse entityToDto(Center center){
        CenterDtoResponse centerDtoResponse = new CenterDtoResponse();
        BeanUtils.copyProperties(center,centerDtoResponse);
        return centerDtoResponse;
    }

    public Center dtoToEntity(CenterDtoRequest centerDtoRequest){
        Center center = new Center();
        User user = userRepository.findUserByEmail(centerDtoRequest.getUserEmail());
        BeanUtils.copyProperties(centerDtoRequest, center);
        center.setUser(user);
        return center;
    }
}
