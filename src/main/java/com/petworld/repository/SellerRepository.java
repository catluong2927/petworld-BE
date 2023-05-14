package com.petworld.repository;

import com.petworld.domain.PackageReview;
import com.petworld.domain.Seller;
import com.petworld.domain.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface SellerRepository extends JpaRepository <Seller,Long> {

    @Modifying
    @Query("UPDATE Seller s SET s.isActive = false WHERE s.id = :id")
    void deleteByIdSeller(@Param("id") Long id);
    @Override
    @Query("SELECT s FROM Seller s WHERE s.isActive = true")
    Page<Seller> findAll(Pageable pageable);
//    @Query("SELECT s FROM Seller s JOIN s.center c WHERE c.name = :name")
//    Seller findByCenterName(@Param("name") String name);

    @Query(value = "SELECT * FROM sellers " +
            "JOIN centers ON sellers.center_id = centers.id " +
            "WHERE centers.name =:name", nativeQuery = true)
    Seller findByCenterName(@Param("name") String name);
}
