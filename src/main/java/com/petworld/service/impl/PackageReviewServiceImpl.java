package com.petworld.service.impl;

import com.petworld.converter.PackageReviewConverter;
import com.petworld.domain.Package;
import com.petworld.domain.PackageReview;
import com.petworld.domain.User;
import com.petworld.dto.packageReviewDto.request.PackageReviewDtoRequest;
import com.petworld.dto.packageReviewDto.response.PackageReviewDtoResponse;
import com.petworld.repository.PackageRepository;
import com.petworld.repository.PackageReviewRepository;
import com.petworld.repository.UserRepository;
import com.petworld.service.PackageReviewService;
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
public class PackageReviewServiceImpl implements PackageReviewService {
    private final PackageReviewRepository packageReviewRepository;
    private final PackageReviewConverter packageReviewConverter;
    private final UserRepository userRepository;

    private final PackageRepository packageRepository;
    @Override
    public Page<PackageReviewDtoResponse> findAll(Pageable pageable) {
        Page<PackageReview> packageReviews = packageReviewRepository.findAll(pageable);
        return packageReviews.map(packageReviewConverter::entityToDto);
    }

    @Override
    public PackageReview savePackageReview(PackageReviewDtoRequest packageReviewDtoRequest) {
        PackageReview packageReview = packageReviewConverter.dtoToEntity(packageReviewDtoRequest);
        User user = userRepository.findUserByEmail(packageReviewDtoRequest.getUseEmail());
        Package servicePackage = packageRepository.getById(packageReviewDtoRequest.getPackageId());
        packageReview.setUser(user);
        packageReview.setServicePackage(servicePackage);
        return packageReviewRepository.save(packageReview);
    }

    @Override
    public Optional<PackageReviewDtoResponse> getPackReview(Long id) {
        PackageReview packageReview = packageReviewRepository.getById(id);
        PackageReviewDtoResponse packageReviewDtoResponse = packageReviewConverter.entityToDto(packageReview);
        return Optional.of(packageReviewDtoResponse);
    }

    @Override
    public void deleteByIdByStatus(Long id) {
        packageReviewRepository.deleteByIdPackageReview(id);
    }

    @Override
    public Page<PackageReviewDtoResponse> findPackageReviewsByPackage(Long id, Pageable pageable) {
        Page<PackageReview> packageReviews = packageReviewRepository.findPackageReviewByPackageId(id, pageable);
        List<PackageReviewDtoResponse> packageReviewDtoResponseArrayList = new ArrayList<>();
        packageReviews.forEach(packageReview -> {
            packageReviewDtoResponseArrayList.add(packageReviewConverter.entityToDto(packageReview));
        });
        Page<PackageReviewDtoResponse> productDtoResponses= new PageImpl<>(packageReviewDtoResponseArrayList);
        return productDtoResponses;
    }
}
