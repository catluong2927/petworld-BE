package com.petworld.converter;

import com.petworld.dto.imagedetailDto.request.UpdateImageDetailDto;
import com.petworld.dto.imagedetailDto.response.ImageDetailsDto;
import com.petworld.entity.ImageDetail;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
@RequiredArgsConstructor
public class ImageDetailsConverter {


    public List<ImageDetailsDto> entititesToDtos(List<ImageDetail> imageDetails){
        List<ImageDetailsDto> imageDetailsDtos = new ArrayList<>();
        for(ImageDetail element : imageDetails){
            ImageDetailsDto imageDetailsDto = entityToDto(element);
            imageDetailsDtos.add(imageDetailsDto);
        }
        return imageDetailsDtos;
    }

    public ImageDetailsDto entityToDto(ImageDetail imageDetail){
        ImageDetailsDto imageDetailsDto = new ImageDetailsDto();
        BeanUtils.copyProperties(imageDetail, imageDetailsDto);
        return imageDetailsDto;
    }

    public ImageDetail dtoToEntity(ImageDetailsDto imageDetailsDto){
        ImageDetail imageDetail = new ImageDetail();
        BeanUtils.copyProperties(imageDetailsDto, imageDetail);
//        imageDetail.setProduct(productConverter.dtoToEntity(imageDetailsDto.getProductDtoRequest()));
        return imageDetail;
    }

    public ImageDetail updateDtoToEntity(UpdateImageDetailDto updateImageDetailDto){
        ImageDetail imageDetail = new ImageDetail();
        BeanUtils.copyProperties(updateImageDetailDto, imageDetail);
        return imageDetail;
    }

    public List<ImageDetail> dtoToEntities(List <UpdateImageDetailDto> updateImageDetailDtos) {
        List<ImageDetail>  imageDetails = new ArrayList<>();
        for(UpdateImageDetailDto element : updateImageDetailDtos){
            ImageDetail imageDetail = updateDtoToEntity(element);
            imageDetails.add(imageDetail);
        }
        return imageDetails;
    }
}
