package com.petworld.converter;

import com.petworld.domain.Service;
import com.petworld.domain.ServiceImage;
import com.petworld.dto.serviceDto.request.ServiceDtoRequest;
import com.petworld.dto.serviceDto.response.ServiceDtoResponse;
import com.petworld.dto.serviceImageDto.response.ServiceImageDtoResponse;
import lombok.AllArgsConstructor;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
@AllArgsConstructor
public class ServiceConverter {
    private final ServiceImageConverter serviceImageConverter;

    public ServiceDtoResponse entityToDto(Service service){
        ServiceDtoResponse serviceDtoResponse = new ServiceDtoResponse();
        BeanUtils.copyProperties(service,serviceDtoResponse);

        List<ServiceImage> serviceImages = service.getServiceImages();
        if(serviceImages != null){
            List<ServiceImageDtoResponse> serviceImageDtoResponses = new ArrayList<>();
            serviceImages.forEach(serviceImage -> serviceImageDtoResponses.add(serviceImageConverter.entityToDto(serviceImage)));
            serviceDtoResponse.setServiceImages(serviceImageDtoResponses);
        }
        return serviceDtoResponse;
    }
    public Service dtoToEntity(ServiceDtoRequest serviceDtoRequest){
        Service service = new Service();
        BeanUtils.copyProperties(serviceDtoRequest, service);
        return service;
    }
}
