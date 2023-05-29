package com.petworld.service;

import com.petworld.entity.Service;
import com.petworld.dto.serviceDto.request.ServiceDtoRequest;
import com.petworld.dto.serviceDto.response.ServiceDtoResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.Optional;

public interface ServiceService {
    Service saveService(ServiceDtoRequest serviceDtoRequest);

    Optional<ServiceDtoResponse> getService(Long id);

    void deleteByIdByStatus(Long id);

    Page<ServiceDtoResponse> findAll(Pageable pageable);

    void addImageToService(Long id,String urlImage);
    Optional<Page<ServiceDtoResponse>> findByPackageId(Long packageDetailId,Pageable pageable);
}
