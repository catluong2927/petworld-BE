package com.petworld.entity;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


import javax.persistence.*;
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
    private String name;
    private String phone;
    private String email;
    private String address;
    @Column(name = "is_active")
    private Boolean isActive;
    @OneToMany(mappedBy = "center",fetch = FetchType.LAZY)
    private List<PackageDetail> packageDetails;
    @OneToOne
    @JoinColumn(name = "user_id")
    private User user;
}
