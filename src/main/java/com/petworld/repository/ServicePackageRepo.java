package com.petworld.repository;

import com.petworld.domain.ServicePackage;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface ServicePackageRepo extends JpaRepository<ServicePackage,Long> {
    @Modifying
    @Query("UPDATE ServicePackage s SET s.isStatus = false WHERE s.id = :id")
    void deleteByIdPackageService(@Param("id") Long id);

}
