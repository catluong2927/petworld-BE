package com.petworld.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@Entity
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "centers")
public class Center {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @NotBlank
    private String name;
    @NotBlank
    private String phone;
    @NotBlank
    private String email;
    @NotBlank
    private String address;
    @Column(name = "active")
    private Boolean isActive;
    @OneToMany(mappedBy = "center",fetch = FetchType.LAZY)
    private List<Package> packages = new ArrayList<>();
    @OneToMany(mappedBy = "center",fetch = FetchType.LAZY)
    private List<Seller> sellers = new ArrayList<>();

    @OneToOne(targetEntity = User.class)
    @JoinColumn(name = "user_id", referencedColumnName = "id")
    private User user;
}
