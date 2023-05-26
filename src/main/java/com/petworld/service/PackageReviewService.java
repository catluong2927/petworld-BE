package com.petworld.service;

import com.petworld.entity.PackageReview;
import com.petworld.dto.packageReviewDto.request.PackageReviewDtoRequest;
import com.petworld.dto.packageReviewDto.response.PackageReviewDtoResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.Optional;

public interface PackageReviewService {
    Page<PackageReviewDtoResponse> findAll(Pageable pageable);

    PackageReview savePackageReview(PackageReviewDtoRequest packageReviewDtoRequest);

    Optional<PackageReviewDtoResponse> getPackReview(Long id);

    void deleteByIdByStatus(Long id);

    Page<PackageReviewDtoResponse> findPackageReviewsByPackage(Long id, Pageable pageable);
}
