package com.petworld.repository;

import com.petworld.domain.Service;
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
    @Query("SELECT s FROM Service s JOIN s.servicePackage sp WHERE sp.name = :name")
    Page<Service> findByPackageName(@Param("name") String name,Pageable pageable);

//    @Query(value = "SELECT * FROM services " +
//            "JOIN packages ON services.package_id = packages.id " +
//            "WHERE packages.name =:name",nativeQuery = true )
//    Page<Service> findServiceByNameOfPackage(Pageable pageable, String name);
//
}
