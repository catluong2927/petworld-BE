package com.petworld.repository;

import com.petworld.domain.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Long> {
//   vẫn dùng được jpql như dưới đây
    @Query(value = "select u from User u where u.email = :email")
//     Customer findByUsername(@Param("username")String username);
    User findUserByEmail(@Param("email")String email);


//    @Query(nativeQuery = true, value = "select * " +
//            "from users u " +
//            "where u.full_name like (:full_name);")
@Query(value = "select  u from User u where u.fullName like (:full_name)")
    List<User> searchByFullName(@Param("full_name") String fullname);


//    @Query(nativeQuery = true,
//            value = "SELECT r.name FROM role r " +
//                    "INNER JOIN user u ON r.id = u.role_id " +
//                    "WHERE u.email = :email")
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

}
