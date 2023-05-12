package com.petworld.repository;

import com.petworld.domain.Cart;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface CartRepository extends JpaRepository<Cart, Long> {

    @Query("select c from Cart c where c.user.email = :email")
    Cart findCartByEmail(@Param("email") String email);

    @Query("select c from Cart c where c.user.id = :id")
    Cart findCartByUser(@Param("id") Long id);
}
