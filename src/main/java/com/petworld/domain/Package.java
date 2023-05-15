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
@Table(name = "packages")
public class Package {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;
    private String description;
    private Float minPrice;
    private Float maxPrice;
    private String image;

    @OneToMany(mappedBy = "servicePackage", fetch = FetchType.LAZY)
    private List<Service> services = new ArrayList<>();
    @Column(name="active")
    private Boolean isActive;
    @Column(name = "status")
    private String status;

    @OneToMany(mappedBy = "servicePackage",fetch = FetchType.LAZY)
    private List<PackageReview> packageReviews = new ArrayList<>();

    @ManyToOne
    @JoinColumn(name = "center_id",referencedColumnName = "id")
    private Center center;
}
