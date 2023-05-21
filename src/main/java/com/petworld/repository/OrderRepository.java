package com.petworld.repository;

import com.petworld.domain.Order;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface OrderRepository extends JpaRepository< Order, Long> {
    List<Order> findOrderByUserEmail(String email);
}
