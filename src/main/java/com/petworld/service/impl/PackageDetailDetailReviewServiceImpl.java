package com.petworld.service.impl;

import com.petworld.converter.PackageDetailReviewConverter;
import com.petworld.entity.PackageDetail;
import com.petworld.entity.PackageDetailReview;
import com.petworld.entity.User;
import com.petworld.dto.packageDetailReviewDto.request.PackageDetailReviewDtoRequest;
import com.petworld.dto.packageDetailReviewDto.response.PackageDetailReviewDtoResponse;
import com.petworld.repository.PackageDetailRepository;
import com.petworld.repository.PackageRepository;
import com.petworld.repository.PackageDetailReviewRepository;
import com.petworld.repository.UserRepository;
import com.petworld.service.PackageDetailReviewService;
import lombok.RequiredArgsConstructor;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Transactional
public class PackageDetailDetailReviewServiceImpl implements PackageDetailReviewService {
    private final PackageDetailReviewRepository packageDetailReviewRepository;
    private final PackageDetailReviewConverter packageDetailReviewConverter;
    private final UserRepository userRepository;
    private final PackageDetailRepository packageDetailRepository;
    private final PackageRepository packageRepository;
    @Override
    public Page<PackageDetailReviewDtoResponse> findAll(Pageable pageable) {
        Page<PackageDetailReview> packageReviews = packageDetailReviewRepository.findAll(pageable);
        return packageReviews.map(packageDetailReviewConverter::entityToDto);
    }

    @Override
    public PackageDetailReview savePackageReview(PackageDetailReviewDtoRequest packageDetailReviewDtoRequest) {
        PackageDetailReview packageDetailReview = packageDetailReviewConverter.dtoToEntity(packageDetailReviewDtoRequest);
        User user = userRepository.findUserByEmail(packageDetailReviewDtoRequest.getUseEmail());
        PackageDetail packageDetail = packageDetailRepository.getById(packageDetailReviewDtoRequest.getPackageDetailId());
        packageDetailReview.setUser(user);
        packageDetailReview.setPackageDetail(packageDetail);
        return packageDetailReviewRepository.save(packageDetailReview);
    }

    @Override
    public Optional<PackageDetailReviewDtoResponse> getPackReview(Long id) {
        PackageDetailReview packageDetailReview = packageDetailReviewRepository.getById(id);
        PackageDetailReviewDtoResponse packageDetailReviewDtoResponse = packageDetailReviewConverter.entityToDto(packageDetailReview);
        return Optional.of(packageDetailReviewDtoResponse);
    }

    @Override
    public void deleteByIdByStatus(Long id) {
        packageDetailReviewRepository.deleteByIdPackageReview(id);
    }

    @Override
    public Page<PackageDetailReviewDtoResponse> findPackageReviewsByPackage(Long id, Pageable pageable) {
        Page<PackageDetailReview> packageReviews = packageDetailReviewRepository.findPackageReviewByPackageId(id, pageable);
        List<PackageDetailReviewDtoResponse> packageDetailReviewDtoResponseArrayList = new ArrayList<>();
        packageReviews.forEach(packageReview -> {
            packageDetailReviewDtoResponseArrayList.add(packageDetailReviewConverter.entityToDto(packageReview));
        });
        Page<PackageDetailReviewDtoResponse> productDtoResponses= new PageImpl<>(packageDetailReviewDtoResponseArrayList);
        return productDtoResponses;
    }
}
