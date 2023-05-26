package com.petworld.repository;

import com.petworld.domain.Center;
import com.petworld.dto.centerDto.response.CenterDtoResponse;
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

    @Override
    @Query("SELECT c FROM Center c WHERE c.isActive = true")
    Page<Center> findAll(Pageable pageable);

    Center findCenterByUserEmail(String email);
}
