package com.petworld.repository;

import com.petworld.domain.Service;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface ServiceRepository extends JpaRepository <Service ,Long> {
    @Modifying
    @Query("UPDATE Service s SET s.isStatus = false WHERE s.id = :id")
    void deleteByIdService(@Param("id") Long id);
}
