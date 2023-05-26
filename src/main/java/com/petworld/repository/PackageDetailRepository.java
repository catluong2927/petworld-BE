package com.petworld.repository;

import com.petworld.entity.PackageDetail;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;


public interface PackageDetailRepository  extends JpaRepository <PackageDetail,Long> {
    @Modifying
    @Query("UPDATE PackageDetail pd SET pd.isActive = false WHERE pd.id = :id")
    void deleteByIdPackageDetail(@Param("id") Long id);

    List<PackageDetail> getPackageDetailsByCenterUserEmail(String userEmail);
    Page<PackageDetail> findAll(Pageable pageable);

    Page<PackageDetail> findPackageDetailsByServicePackageName(String name,Pageable pageable);
}
