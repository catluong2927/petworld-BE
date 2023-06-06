package com.petworld.repository;

import com.petworld.entity.ImageDetail;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ImageDetailRepository extends JpaRepository<ImageDetail, Long> {
    @Query("select i from ImageDetail i where i.product.id = :id")
    List<ImageDetail>getImageDetailByProduct(@Param("id") Long id);
}
