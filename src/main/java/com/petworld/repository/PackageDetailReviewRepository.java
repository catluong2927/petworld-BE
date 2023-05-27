package com.petworld.repository;

import com.petworld.entity.PackageDetailReview;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface PackageDetailReviewRepository extends JpaRepository<PackageDetailReview, Long> {
    @Override
    @Query("SELECT pr FROM PackageDetailReview pr WHERE pr.isActive = true")
    Page<PackageDetailReview> findAll(Pageable pageable);

    @Modifying
    @Query("UPDATE PackageDetailReview pr SET pr.isActive = false WHERE pr.id = :id")
    void deleteByIdPackageReview(@Param("id") Long id);


    @Query(value = "SELECT * FROM package_reviews " +
            "JOIN packages ON package_reviews.package_id = packages.id " +
            "WHERE packages.id =:id", nativeQuery = true)
    Page<PackageDetailReview> findPackageReviewByPackageId(Long id, Pageable pageable);
}
