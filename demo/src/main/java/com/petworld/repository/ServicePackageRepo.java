package com.petworld.repository;

import com.petworld.domain.ServicePackage;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Collection;

public interface ServicePackageRepo extends JpaRepository<ServicePackage,Long> {
    @Modifying
    @Query("UPDATE ServicePackage sp SET sp.isStatus = false WHERE sp.id = :id")
    void deleteByIdPackageService(@Param("id") Long id);

    @Query("SELECT sp FROM ServicePackage sp WHERE sp.name = :name")
    Collection<ServicePackage> findServicePackageByName(String name);
}
