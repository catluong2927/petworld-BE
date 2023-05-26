package com.petworld.converter;


import com.petworld.entity.Center;
import com.petworld.entity.PackageDetail;
import com.petworld.dto.PackageDetailDto.request.PackageDetailDtoRequest;
import com.petworld.dto.PackageDetailDto.response.PackageDetailDtoResponse;
import com.petworld.repository.CenterRepository;
import lombok.AllArgsConstructor;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Component;

@Component
@AllArgsConstructor
public class PackageDetailConverter {
    private CenterRepository centerRepository;
    public PackageDetailDtoResponse entityToDto(PackageDetail packageDetail){
        PackageDetailDtoResponse packageDetailDtoResponse = new PackageDetailDtoResponse();
        BeanUtils.copyProperties(packageDetail,packageDetailDtoResponse);
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
