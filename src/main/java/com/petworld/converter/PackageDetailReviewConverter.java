package com.petworld.converter;

import com.petworld.entity.PackageDetailReview;
import com.petworld.dto.packageDetailReviewDto.request.PackageDetailReviewDtoRequest;
import com.petworld.dto.packageDetailReviewDto.response.PackageDetailReviewDtoResponse;
import com.petworld.dto.userDto.response.UserDtoResponse;
import lombok.AllArgsConstructor;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Component;

@Component
@AllArgsConstructor
public class PackageDetailReviewConverter {
    private final UserConverter userConverter;

    public PackageDetailReviewDtoResponse entityToDto(PackageDetailReview packageDetailReview){
        PackageDetailReviewDtoResponse packageDetailReviewDtoResponse = new PackageDetailReviewDtoResponse();
        BeanUtils.copyProperties(packageDetailReview, packageDetailReviewDtoResponse);
        UserDtoResponse userDtoResponse = userConverter.entityToDto(packageDetailReview.getUser());
        packageDetailReviewDtoResponse.setUserDtoResponse(userDtoResponse);
        return packageDetailReviewDtoResponse;
    }
    public PackageDetailReview dtoToEntity(PackageDetailReviewDtoRequest packageDetailReviewDtoRequest){
        PackageDetailReview packageDetailReview = new PackageDetailReview();
        BeanUtils.copyProperties(packageDetailReviewDtoRequest, packageDetailReview);
        return packageDetailReview;
    }
}
