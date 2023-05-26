package com.petworld.repository;

import com.petworld.entity.CouponCode;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.sql.Date;
import java.util.List;

@Repository
public interface CouponCodeRepository extends JpaRepository<CouponCode,Long> {
    @Query("select couponCode from CouponCode couponCode " +
            "where :date between couponCode.beginDate and couponCode.expirationDate " +
            "and couponCode.totalPayCondition <= :totalPayCondition")
    List<CouponCode> availableCouponCode(@Param("date") Date date, @Param("totalPayCondition") Double totalPayCondition);
}
