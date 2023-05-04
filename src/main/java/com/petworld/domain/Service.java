package com.petworld.domain;

import lombok.*;

import javax.persistence.*;
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

    @OneToMany(targetEntity = ServiceImage.class)
    @JoinTable(name = "service_image_detail",
            joinColumns = @JoinColumn(name = "service_id"),
            inverseJoinColumns = @JoinColumn(name = "service_images_id"))
    private List<ServiceImage> serviceImages;

    @Column(name = "active")
    private boolean isActive;
}