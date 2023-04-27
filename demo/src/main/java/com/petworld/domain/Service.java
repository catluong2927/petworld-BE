package com.petworld.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Data
@Entity
@NoArgsConstructor
@AllArgsConstructor
public class Service {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;

    private String description;

    private Float price;
    @ManyToOne(targetEntity = ServicePackage.class)
    @JoinColumn(name = "service_package_id", referencedColumnName = "id")
    private ServicePackage servicePackage;
    ádasd

}
