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
@Table(name = "package_reviews")
public class PackageReview {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String review;

    private Integer star;

    private Date date;
    @Column(name = "active")
    private Boolean isActive;

    @ManyToOne
    @JoinColumn(name = "package_id")
    private Package servicePackage;

    @OneToOne
    @JoinColumn(name ="user_id")
    private User user;
}
