package com.petworld.repository;

import com.petworld.domain.Package;
import com.petworld.domain.PackageReview;
import com.petworld.domain.Service;
import com.petworld.dto.packageReviewDto.response.PackageReviewDtoResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface PackageReviewRepository extends JpaRepository<PackageReview, Long> {
    @Override
    @Query("SELECT pr FROM PackageReview pr WHERE pr.isActive = true")
    Page<PackageReview> findAll(Pageable pageable);

    @Modifying
    @Query("UPDATE PackageReview pr SET pr.isActive = false WHERE pr.id = :id")
    void deleteByIdPackageReview(@Param("id") Long id);


    @Query(value = "SELECT * FROM package_reviews " +
            "JOIN packages ON package_reviews.package_id = packages.id " +
            "WHERE packages.id =:id", nativeQuery = true)
    Page<PackageReview> findPackageReviewByPackageId(Long id, Pageable pageable);
}
