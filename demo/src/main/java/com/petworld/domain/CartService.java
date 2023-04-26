package com.petworld.domain;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Data
@Entity
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "cart_service")
public class CartService {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
}
