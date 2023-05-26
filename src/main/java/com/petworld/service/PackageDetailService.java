package com.petworld.service;

import com.petworld.dto.PackageDetailDto.request.PackageDetailDtoRequest;
import com.petworld.dto.PackageDetailDto.response.PackageDetailDtoResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Optional;

public interface PackageDetailService {
    PackageDetailDtoResponse savePackageDetail(PackageDetailDtoRequest packageDetailDtoRequest);

    Optional<PackageDetailDtoResponse> getPackageDetail(Long id);
    void deleteByIdByStatus(Long id);

    List<PackageDetailDtoResponse> findByUserEmail(String userEmail);

    Page<PackageDetailDtoResponse> findAll(Pageable pageable);

    Page<PackageDetailDtoResponse> findPackageDetailByPackageName(String name,Pageable pageable);
}
