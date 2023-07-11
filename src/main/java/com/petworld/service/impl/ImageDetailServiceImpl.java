package com.petworld.service.impl;

import com.petworld.converter.ImageDetailsConverter;
import com.petworld.dto.imagedetailDto.request.UpdateImageDetailDto;
import com.petworld.dto.imagedetailDto.response.ImageDetailsDto;
import com.petworld.entity.ImageDetail;
import com.petworld.repository.ImageDetailRepository;
import com.petworld.service.ImageDetailService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ImageDetailServiceImpl implements ImageDetailService {
    private final ImageDetailRepository imageDetailRepository;
    private final ImageDetailsConverter imageDetailsConverter;
    @Override
    public List<ImageDetailsDto> findImageDetailById(Long id) {
        List<ImageDetail> imageDetails = imageDetailRepository.getImageDetailByProduct(id);
        if(!imageDetails.isEmpty()) {
            List<ImageDetailsDto> imageDetailDtos = imageDetailsConverter.entititesToDtos(imageDetails);
            return imageDetailDtos;
        }
        return null;
    }

    @Override
    public Boolean updateImageDetail(Long id, List<UpdateImageDetailDto> updateImageDetailDtos) {
        List<ImageDetail> imageDetails = imageDetailsConverter.dtoToEntities(updateImageDetailDtos);
        List<ImageDetail> imageDetailList = imageDetailRepository.getImageDetailByProduct(id);
        if (!imageDetails.isEmpty() && !imageDetailList.isEmpty()) {
            for (ImageDetail newImageDetail : imageDetails) {
                for (ImageDetail imageDetail : imageDetailList) {
                    if (newImageDetail.getId().equals(imageDetail.getId())) {
                        imageDetail.setUrl(newImageDetail.getUrl());
                        imageDetailRepository.save(imageDetail);
                    }
                }
            }
            return true;
        }
        return false;
    }
}
