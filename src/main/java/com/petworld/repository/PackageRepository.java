package com.petworld.repository;

import com.petworld.entity.Package;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;


@Repository
public interface PackageRepository extends JpaRepository<Package,Long> {

    @Modifying
    @Query("UPDATE Package p SET p.isActive = false WHERE p.id = :id")
    void deleteByIdPackage(@Param("id") Long id);
    Page<Package> findPackagesByName(String name, Pageable pageable);

    Optional<Package> findPackageByName(String name);
    Package findPackageById(Long id);

    @Override
    Page<Package> findAll(Pageable pageable);
}
