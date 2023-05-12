package com.petworld.domain;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.List;

@Data
@Entity
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "service_packages")
public class ServicePackage {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;
    private String description;
    private Float minPrice;
    private Float maxPrice;

    @OneToMany(targetEntity = ServicePackageReview.class)
    @JoinTable(name = "service_package_review_details",
            joinColumns = @JoinColumn(name = "service_package_id"),
            inverseJoinColumns = @JoinColumn(name = "service_package_review_id"))
    private List<ServicePackageReview> reviews;

    private String image;
    @OneToMany(targetEntity = Service.class)
    @JoinTable(name = "service_package_details",
            joinColumns = @JoinColumn(name = "service_package_id"),
            inverseJoinColumns = @JoinColumn(name = "service_id"))
    private List<Service> services;

//    @OneToMany(targetEntity = ServicePackageReview.class)
//    @JoinTable(name = "service_package_review_detail",
//            joinColumns = @JoinColumn(name = "service_package_id"),
//            inverseJoinColumns = @JoinColumn(name = "service_package_review_id"))
//    private List<ServicePackageReview> reviews;
    @Column(name="active")
    private Boolean isActive;
    @Column(name = "status")
    private String status;
}
