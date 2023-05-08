package com.petworld.service;

import com.petworld.dto.centerDto.response.CenterDtoResponse;
import com.petworld.dto.servicePackageDto.response.ServicePackageDtoResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface CenterService {
    CenterDtoResponse getById(Long id);
    Page<CenterDtoResponse> findAll(Pageable pageable);

    void deleteByIdByStatus (Long id);
}
