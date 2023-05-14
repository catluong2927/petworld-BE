package com.petworld.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@Entity
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "services")
public class Service {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;

    private String description;

    private Float price;

    @ManyToOne
    @JoinColumn(name = "package_id")
    private Package servicePackage;

    @Column(name = "active")
    private boolean isActive;

    @OneToMany(mappedBy = "service", fetch = FetchType.LAZY)
    private List<ServiceImage> serviceImages = new ArrayList<>();
}