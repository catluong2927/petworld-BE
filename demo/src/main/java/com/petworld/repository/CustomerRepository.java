package com.petworld.repository;

import com.petworld.domain.Customer;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface CustomerRepository extends JpaRepository<Customer, Integer> {
    Customer findByUsername(String username);

    @Query(nativeQuery = true, value = "select * " +
            "from users u " +
            "where u.fullname like (:fullname);")
    List<Customer> findByFullName(@Param("fullname") String fullname);

    @Query(nativeQuery = true,
            value = "SELECT r.name FROM roles r " +
                    "INNER JOIN users u ON r.id = u.role_id " +
                    "WHERE u.username = :username")
    List<String> findRolesByUsername(@Param("username") String username);
}
