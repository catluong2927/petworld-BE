package com.petworld.repository;

import com.petworld.domain.Role;
import com.petworld.domain.User;
import com.petworld.domain.UserRole;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface UserRoleRepository extends JpaRepository<UserRole,Long> {
    void removeUserRoleById(long id);
    @Query(value = "select  ur from UserRole ur where ur.user = :user and ur.role = :role")
    UserRole getUserRoleByUserId (User user, Role role);

}
