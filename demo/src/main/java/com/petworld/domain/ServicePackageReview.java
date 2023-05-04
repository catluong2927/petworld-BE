package com.petworld.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.Date;

@Data
@Entity
@NoArgsConstructor
@AllArgsConstructor
public class ServicePackageReview {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String review;

    private Integer start;

    private Date date;

    @ManyToOne(targetEntity = ServicePackage.class)
    @JoinColumn(name = "service_package_id", referencedColumnName = "id")
    private ServicePackage servicePackage;


}
