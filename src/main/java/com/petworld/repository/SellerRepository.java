package com.petworld.repository;

import com.petworld.domain.Seller;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface SellerRepository extends JpaRepository <Seller,Long> {

    @Modifying
    @Query("UPDATE Seller s SET s.isActive = false WHERE s.id = :id")
    void deleteByIdSeller(@Param("id") Long id);
}
