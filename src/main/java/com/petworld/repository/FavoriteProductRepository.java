package com.petworld.repository;

import com.petworld.entity.FavoriteProduct;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface FavoriteProductRepository extends JpaRepository<FavoriteProduct,Long> {
//    void deleteFavoriteProductByProductIdAndFavoriteUserId(Long UserId,Long productId);
    void deleteFavoriteProductByFavoriteUserIdAndProductId(Long UserId,Long productId);
}
