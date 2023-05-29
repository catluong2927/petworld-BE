package com.petworld.converter;


import com.petworld.dto.serviceDto.response.ServiceDtoResponse;
import com.petworld.entity.Center;
import com.petworld.entity.PackageDetail;
import com.petworld.dto.PackageDetailDto.request.PackageDetailDtoRequest;
import com.petworld.dto.PackageDetailDto.response.PackageDetailDtoResponse;
import com.petworld.entity.Service;
import com.petworld.repository.CenterRepository;
import lombok.AllArgsConstructor;
import org.springframework.beans.BeanUtils;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

@Component
@AllArgsConstructor
public class PackageDetailConverter {
    private CenterRepository centerRepository;
    private ServiceConverter serviceConverter;
    public PackageDetailDtoResponse entityToDto(PackageDetail packageDetail){
        PackageDetailDtoResponse packageDetailDtoResponse = new PackageDetailDtoResponse();
        BeanUtils.copyProperties(packageDetail,packageDetailDtoResponse);
        List<Service> services = packageDetail.getServices();
        if(!services.isEmpty()) {
            List<ServiceDtoResponse> serviceDtoResponses = services.stream().
                    map(serviceConverter::entityToDto).collect(Collectors.toList());
            Page<ServiceDtoResponse> servicesDto = new PageImpl<ServiceDtoResponse>(serviceDtoResponses);
            packageDetailDtoResponse.setServiceDtoResponses(servicesDto);
        }
        packageDetailDtoResponse.setPackageName(packageDetail.getServicePackage().getName());
        packageDetailDtoResponse.setCenterName(packageDetail.getCenter().getName());
        return packageDetailDtoResponse;
    }

    public PackageDetail dtoToEntity(PackageDetailDtoRequest packageDetailDtoRequest){
        PackageDetail packageDetail = new PackageDetail();
        BeanUtils.copyProperties(packageDetailDtoRequest,packageDetail);
        Center center = centerRepository.findCenterByUserEmail(packageDetailDtoRequest.getUserEmail());
        packageDetail.setCenter(center);
        return packageDetail;
    }
}
