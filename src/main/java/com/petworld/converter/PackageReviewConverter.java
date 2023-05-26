package com.petworld.converter;

import com.petworld.entity.PackageReview;
import com.petworld.dto.packageReviewDto.request.PackageReviewDtoRequest;
import com.petworld.dto.packageReviewDto.response.PackageReviewDtoResponse;
import com.petworld.dto.userDto.response.UserDtoResponse;
import lombok.AllArgsConstructor;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Component;

@Component
@AllArgsConstructor
public class PackageReviewConverter {
    private final UserConverter userConverter;

    public PackageReviewDtoResponse entityToDto(PackageReview packageReview){
        PackageReviewDtoResponse packageReviewDtoResponse = new PackageReviewDtoResponse();
        BeanUtils.copyProperties(packageReview,packageReviewDtoResponse);
        UserDtoResponse userDtoResponse = userConverter.entityToDto(packageReview.getUser());
        packageReviewDtoResponse.setUserDtoResponse(userDtoResponse);
        return packageReviewDtoResponse;
    }
    public PackageReview dtoToEntity(PackageReviewDtoRequest packageReviewDtoRequest){
        PackageReview packageReview = new PackageReview();
        BeanUtils.copyProperties(packageReviewDtoRequest, packageReview);
        return packageReview;
    }
}
