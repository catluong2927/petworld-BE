package com.petworld.repository;

import com.petworld.domain.CartDetail;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CartDetailRepository extends JpaRepository<CartDetail, Long> {
    @Query(value = "Select * from cart " +
            "join cart_detail on cart.id = cart_detail.cart_id " +
            "join product on cart_detail.product_id = product.id " +
            "where cart.id = :id", nativeQuery = true)
    List<CartDetail> findCartDetailById(@Param("id") Long id);
}
