package com.petworld.repository;

import com.petworld.domain.Category;
import com.petworld.domain.Product;
import com.petworld.dto.productDto.request.ProductDtoRequest;
import com.petworld.dto.productDto.response.ProductDtoResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;
import java.util.List;
import java.util.Optional;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {

    @Query( value = "select p from Product p where p.status = true ")
    Page<Product> getAllProducts(Pageable pageable);

    @Query("select p from Product p where p.category.id in (:id) and p.status = true")
    Page<Product> findByCategoryIds(@Param("id") List<Long> categoryIds, Pageable pageable);

    @Transactional
    @Modifying
    @Query("UPDATE Product p SET p.status = false WHERE p.id = :id")
    void deleteProductById(@Param("id") Long id);


}
