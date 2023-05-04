package com.petworld.domain;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import java.io.Serializable;

@Embeddable
public class CartDetailKey implements Serializable {

    @Column(name = "productCartId")
    Long productCartId;

    @Column(name = "productId")
    Long productId;
}
