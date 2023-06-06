package com.petworld.repository;

import com.petworld.entity.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {

    @Query(value = "select u from User u where u.email = :account or u.userName  = :account or u.phone  = :account")
    User findUserByAccount (String account);
    User findUserByEmail(String email);

    @Query(value = "select  u from User u where u.fullName like (:full_name)")
    List<User> searchByFullName(@Param("full_name") String fullName);

    @Query("SELECT r.name as Role " +
            "FROM User u " +
            "JOIN UserRole ur ON u.id = ur.user.id " +
            "JOIN Role r ON ur.role.id = r.id " +
            "WHERE u.email =:email")
    List<String> findRolesByEmail(@Param("email") String email);

    Page<User> findAll(Pageable pageable);

    @Modifying
    @Query("UPDATE User u SET u.isStatus = false WHERE u.id = :id")
    void deleteByIdUser(@Param("id") Long id);

    @Modifying
    @Query("UPDATE User u SET u.isStatus = true WHERE u.id = :id")
    void activeByIdUser(@Param("id") Long id);

//    @Query(value = "select u from User u where u.userName =:userName")
    User findUserByUserName(String userName);
    User getUserById (Long id);

}
