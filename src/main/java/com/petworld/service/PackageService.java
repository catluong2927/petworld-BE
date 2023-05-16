package com.petworld.service;


import com.petworld.dto.packageDto.request.PackageDtoRequest;
import com.petworld.dto.packageDto.response.PackageDtoResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Optional;

public interface PackageService {
    PackageDtoResponse savePackage(PackageDtoRequest packageDtoRequest);

    Optional<PackageDtoResponse> getPackage(Long id);

    void deleteByIdByStatus(Long id);

    Page<PackageDtoResponse> getAllPackageByName(String name,Pageable pageable);

    Page<PackageDtoResponse> findAll(Pageable pageable);

    Optional<PackageDtoResponse> addServiceToPackage(Long id, Long serviceId);
}