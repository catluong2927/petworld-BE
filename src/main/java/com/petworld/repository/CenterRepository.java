package com.petworld.repository;

import com.petworld.domain.Center;
import com.petworld.dto.centerDto.response.CenterDtoResponse;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface CenterRepository extends JpaRepository<Center,Long> {
    @Modifying
    @Query("UPDATE Center c SET c.isActive = false WHERE c.id = :id")
    CenterDtoResponse deleteByIdCenter(@Param("id") Long id);
}
