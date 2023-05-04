package com.petworld.service;


import com.petworld.domain.Service;
import com.petworld.domain.ServicePackage;
import com.petworld.dto.servicePackageDto.request.ServicePackageDtoRequest;
import com.petworld.dto.servicePackageDto.response.ServicePackageDtoResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Optional;

public interface ServicePackageService {
    ServicePackageDtoResponse saveServicePackage(ServicePackageDtoRequest servicePackageDtoRequest);

    List<ServicePackageDtoResponse> getAllServicePackages();

    Optional<ServicePackageDtoResponse> getServicePackage(Long id);

    void deleteByIdByStatus(Long id);

    List<ServicePackageDtoResponse> getAllServicePackageByName(String name);

    Page<ServicePackageDtoResponse> findAll(Pageable pageable);

    Optional<ServicePackageDtoResponse> addServiceToServicePackage(Long id, Long serviceId);
}