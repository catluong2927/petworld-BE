package com.petworld.repository;

import com.petworld.entity.Center;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface CenterRepository extends JpaRepository<Center,Long> {
    @Modifying
    @Query("UPDATE Center c SET c.isActive = false WHERE c.id = :id")
    void deleteByIdCenter(@Param("id") Long id);

    Page<Center> findAllByIsActiveTrue(Pageable pageable);

    Page<Center> findAll(Pageable pageable);

    Center findCenterByUserEmail(String email);
}
