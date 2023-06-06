package com.petworld.service;

import com.petworld.dto.imagedetailDto.request.UpdateImageDetailDto;
import com.petworld.dto.imagedetailDto.response.ImageDetailsDto;

import java.util.List;

public interface ImageDetailService {
    List<ImageDetailsDto> findImageDetailById(Long id);
    Boolean updateImageDetail(Long id, List<UpdateImageDetailDto> updateImageDetailDtos);
}
