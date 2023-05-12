package com.petworld.repository;

import com.petworld.domain.Role;
import com.petworld.domain.UserRole;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRoleRepo extends JpaRepository<UserRole,Long> {

}
