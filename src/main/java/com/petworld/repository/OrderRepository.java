package com.petworld.repository;

import com.petworld.entity.Orders;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public interface OrderRepository extends JpaRepository<Orders, Long> {
    List< Orders> findOrdersByUserEmailOrderByDateDesc(String email);


}
