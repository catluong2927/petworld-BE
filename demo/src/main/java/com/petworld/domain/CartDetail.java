package com.petworld.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Data
@Entity
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "cart_detail")
public class CartDetail {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(targetEntity = CartService.class)
    @JoinColumn(name="cart_service_id",referencedColumnName = "id")
    private Long cartServiceId;

    @ManyToOne(targetEntity = ServicePackage.class)
    @JoinColumn(name = "service_package_id",referencedColumnName = "id")
    private Long servicePackageId;
}
