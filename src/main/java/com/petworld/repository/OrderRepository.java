package com.petworld.repository;

import com.petworld.entity.Orders;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface OrderRepository extends JpaRepository<Orders, Long> {
    List< Orders> findOrdersByUserEmailOrderByDateDesc(String email);


}
