package com.petworld.converter;

import com.petworld.domain.Center;
import com.petworld.dto.centerDto.request.CenterDtoRequest;
import com.petworld.dto.centerDto.response.CenterDtoResponse;
import org.springframework.beans.BeanUtils;

public class CenterConverter {
    public CenterDtoResponse entityToDto(Center center){
        CenterDtoResponse centerDtoResponse = new CenterDtoResponse();
        BeanUtils.copyProperties(center,centerDtoResponse);
        return centerDtoResponse;
    }
    public Center dtoToEntity(CenterDtoRequest centerDtoRequest){
        Center center = new Center();
        BeanUtils.copyProperties(centerDtoRequest, center);
        return center;
    }
}
