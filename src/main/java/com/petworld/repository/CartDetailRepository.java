package com.petworld.repository;
import com.petworld.entity.CartDetail;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;

@Repository
public interface CartDetailRepository extends JpaRepository<CartDetail, Long> {
    List<CartDetail> findCartDetailByCartId(Long id);
    Optional<CartDetail> findCartDetailByTypeIdAndCartIdAndType(Long typeId, Long cartId, Boolean type);
}
