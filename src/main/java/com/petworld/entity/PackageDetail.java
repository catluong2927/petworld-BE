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
@Table(name = "package_details")
public class PackageDetail {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String description;
    private Double price;
    private String image;
    @Column(name="is_active")
    private Boolean isActive;
    @Column(name = "status")
    private String status;
    @OneToMany(mappedBy = "packageDetail",fetch = FetchType.LAZY)
    private List<Service> services;
    @OneToMany(mappedBy = "packageDetail",fetch = FetchType.LAZY)
    private List<PackageReview> packageReviews;
    @ManyToOne(targetEntity = Center.class)
    @JoinColumn(name = "center_id", referencedColumnName = "id")
    private Center center;
    @ManyToOne(targetEntity = Package.class)
    @JoinColumn(name = "package_id",referencedColumnName = "id")
    private Package servicePackage;
}
