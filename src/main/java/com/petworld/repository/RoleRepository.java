package com.petworld.repository;

import com.petworld.entity.Role;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RoleRoleRepository extends JpaRepository<Role, Long> {
    Role getRoleById(Long id);
}
