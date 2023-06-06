package com.petworld.entity;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import javax.validation.constraints.NotBlank;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "user")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Long id;

    @OneToMany(mappedBy = "user")
    private List<UserRole> userRoles;

    @NotBlank
    @Column(name = "full_name", length = 255, nullable = false)
    private String fullName;

    @NotBlank
    @Column(name = "username", length = 20, nullable = false)
    private String userName;

    @Column(name = "password", length = 255, nullable = true)
    private String password;

    @NotBlank
    @Column(name = "email", length = 255, nullable = false)
    private String email;


    @Column(name = "address", length = 255, nullable = true)
    private String address;


    @Column(name = "phone", length = 12, nullable = true)
    private String phone;


    @Column(name = "avatar",
            columnDefinition = "text", nullable = true)
    private String avatar;

    @Column(name = "is_status", nullable = false)
    private Boolean isStatus;

    @Column
    private Date dob;

    @Column
    private String descript;

    @OneToMany(mappedBy = "user",fetch = FetchType.LAZY)
    private List<Orders> orders = new ArrayList<>();

}
