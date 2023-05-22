package com.petworld.repository;

import com.petworld.domain.Package;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;


@Repository
public interface PackageRepository extends JpaRepository<Package,Long> {
    @Modifying
    @Query("UPDATE Package p SET p.isActive = false WHERE p.id = :id")
    void deleteByIdPackage(@Param("id") Long id);
    Page<Package> findPackageByName(String name, Pageable pageable);
    @Override
    Page<Package> findAll(Pageable pageable);

    @Query("SELECT p FROM Package p JOIN p.center c WHERE c.id = :centerId")
    List<Package> getPackagesByCenterId(@PathVariable Long centerId);
}
