package com.petworld.repository;

import com.petworld.entity.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface ServiceRepository extends JpaRepository <Service ,Long> {
    @Modifying
    @Query("UPDATE Service s SET s.isActive = false WHERE s.id = :id")
    void deleteByIdService(@Param("id") Long id);

    @Override
    @Query("SELECT s FROM Service s WHERE s.isActive = true")
    Page<Service> findAll(Pageable pageable);

    Page<Service> findServiceByPackageDetailServicePackageName(@Param("name") String name,Pageable pageable);

    Page<Service> findServicesByPackageDetailId(@Param("id") Long packageDetailId,Pageable pageable);
}
