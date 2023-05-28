package com.petworld.service;

import com.petworld.entity.PackageDetailReview;
import com.petworld.dto.packageDetailReviewDto.request.PackageDetailReviewDtoRequest;
import com.petworld.dto.packageDetailReviewDto.response.PackageDetailReviewDtoResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.Optional;

public interface PackageDetailReviewService {
    Page<PackageDetailReviewDtoResponse> findAll(Pageable pageable);

    PackageDetailReview savePackageDetailReview(PackageDetailReviewDtoRequest packageDetailReviewDtoRequest);

    Optional<PackageDetailReviewDtoResponse> getPackDetailReviewById(Long id);

    void deleteByIdByStatus(Long id);

    Page<PackageDetailReviewDtoResponse> findPackageDetailReviewsByPackageDetail(Long id, Pageable pageable);
}
