package com.petworld.repository;

import com.petworld.entity.PackageDetailReview;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface PackageDetailReviewRepository extends JpaRepository<PackageDetailReview, Long> {
    @Override
    @Query("SELECT pr FROM PackageDetailReview pr WHERE pr.isActive = true")
    Page<PackageDetailReview> findAll(Pageable pageable);

    @Modifying
    @Query("UPDATE PackageDetailReview pr SET pr.isActive = false WHERE pr.id = :id")
    void deleteByIdPackageReview(@Param("id") Long id);

    Page<PackageDetailReview> findPackageDetailReviewsByPackageDetailId(Long id, Pageable pageable);
}
