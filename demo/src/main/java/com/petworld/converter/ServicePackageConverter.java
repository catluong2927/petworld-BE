package com.petworld.converter;

import com.petworld.domain.ServicePackage;
import com.petworld.dto.servicePackageDto.request.ServicePackageDtoRequest;
import com.petworld.dto.servicePackageDto.response.ServicePackageDtoResponse;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Component;

@Component
public class ServicePackageConverter {
    public ServicePackageDtoResponse entityToDto(ServicePackage servicePackage){
        ServicePackageDtoResponse servicePackageDtoResponse = new ServicePackageDtoResponse();
        BeanUtils.copyProperties(servicePackage,servicePackageDtoResponse);
        return servicePackageDtoResponse;
    }
    public ServicePackage dtoToEntity(ServicePackageDtoRequest  servicePackageDtoRequest){
        ServicePackage servicePackage = new ServicePackage();
        BeanUtils.copyProperties(servicePackageDtoRequest, servicePackage);
        return servicePackage;
    }
}
