package com.petworld.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;

@AllArgsConstructor
@NoArgsConstructor
@Entity
@Getter
@Setter
@Table(name = "cart_detail")
public class CartDetail {

    @EmbeddedId
    CartDetailKey id;

    @ManyToOne(targetEntity = ProductCart.class)
    @MapsId("productCartId")
    @JoinColumn(name = "product_cart_id", referencedColumnName = "id")
    private ProductCart productCart;

    @ManyToOne(targetEntity = Product.class)
    @MapsId("productId")
    @JoinColumn(name = "product_id", referencedColumnName = "id")
    private Product product;

}
