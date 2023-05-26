package com.petworld.converter;

import com.petworld.entity.ServiceImage;
import com.petworld.dto.serviceImageDto.request.ServiceImageDtoRequest;
import com.petworld.dto.serviceImageDto.response.ServiceImageDtoResponse;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Component;

@Component
public class ServiceImageConverter {
    public ServiceImageDtoResponse entityToDto(ServiceImage serviceImage){
        ServiceImageDtoResponse serviceImageDtoResponse = new ServiceImageDtoResponse();
        BeanUtils.copyProperties(serviceImage,serviceImageDtoResponse);
        return serviceImageDtoResponse;
    }
    public ServiceImage dtoToEntity(ServiceImageDtoRequest serviceImageDtoRequest){
        ServiceImage serviceImage = new ServiceImage();
        BeanUtils.copyProperties(serviceImageDtoRequest, serviceImage);
        return serviceImage;
    }
}
