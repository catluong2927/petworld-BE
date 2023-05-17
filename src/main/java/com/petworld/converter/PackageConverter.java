package com.petworld.converter;

import com.petworld.domain.Package;
import com.petworld.domain.Service;
import com.petworld.dto.packageDto.request.PackageDtoRequest;
import com.petworld.dto.packageDto.response.PackageDtoResponse;
import com.petworld.dto.serviceDto.response.ServiceDtoResponse;
import lombok.AllArgsConstructor;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
@AllArgsConstructor
public class PackageConverter {
    private final ServiceConverter serviceConverter;
    public PackageDtoResponse entityToDto(Package servicePackage){
        PackageDtoResponse packageDtoResponse = new PackageDtoResponse();
        BeanUtils.copyProperties(servicePackage, packageDtoResponse);
        packageDtoResponse.setCenterName(servicePackage.getCenter().getName());
        // Converter services of service-packages
        List<Service> services = servicePackage.getServices();
        if(services != null){
            List<ServiceDtoResponse> serviceDtoResponses = new ArrayList<>();
            services.forEach(service -> serviceDtoResponses.add(serviceConverter.entityToDto(service)));
            packageDtoResponse.setServiceDtoResponses(serviceDtoResponses);
        }

        return packageDtoResponse;
    }
    public Package dtoToEntity(PackageDtoRequest packageDtoRequest){
        Package aPackage = new Package();
        BeanUtils.copyProperties(packageDtoRequest, aPackage);
        return aPackage;
    }
}
