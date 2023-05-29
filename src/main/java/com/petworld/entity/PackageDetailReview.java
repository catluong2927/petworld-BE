package com.petworld.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.Date;

@Data
@Entity
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "package_detail_reviews")
public class PackageDetailReview {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String review;

    private Integer star;

    private Date date;
    @Column(name = "active")
    private Boolean isActive;

    @ManyToOne
    @JoinColumn(name = "package_detail_id")
    private PackageDetail packageDetail;

    @OneToOne
    @JoinColumn(name ="user_id")
    private User user;
}
