package com.petworld.domain;

import lombok.*;

import javax.persistence.*;
import java.util.Date;

@Entity
@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@Table(name = "order_detail")
public class OrderDetail {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String itemName;
    private Integer quantity;
    private Double total;
    private String note;
    @ManyToOne(targetEntity = Orders.class)
    @JoinColumn(name = "orders_id", referencedColumnName = "id")
    private Orders orders;
}
