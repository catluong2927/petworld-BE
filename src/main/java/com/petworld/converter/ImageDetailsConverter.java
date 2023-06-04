package com.petworld.converter;

import com.petworld.entity.ImageDetail;
import com.petworld.dto.imageDetailsDto.ImageDetailsDto;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Component;

import java.awt.*;
import java.awt.image.ImageObserver;
import java.awt.image.ImageProducer;
import java.util.ArrayList;
import java.util.List;

@Component
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
        return imageDetail;
    }

//    public List<ImageDetail> dtoToEntities(List <ImageDetailsDto> imageDetailsDto) {
//        List<ImageDetail>  imageDetails = new ArrayList<>();
//        for(ImageDetailsDto element : imageDetailsDto){
//            ImageDetail imageDetail = dtoToEntity(element);
//            imageDetails.add(imageDetail);
//        }
//        return imageDetails;
//    }
}
