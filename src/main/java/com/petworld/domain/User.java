package com.petworld.domain;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
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
    private Set<UserRole> userRoles;

//    @ManyToMany(fetch = FetchType.LAZY)
//    @JoinTable(name = "user_role",
//            joinColumns = @JoinColumn(name = "user_id"),
//            inverseJoinColumns = @JoinColumn(name = "role_id"))
////    @OnDelete(action = OnDeleteAction.CASCADE)
//    private Set<Role> roles = new HashSet<Role>();

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

    @Column(name = "remember_token", length = 255, nullable = true)
    private String rememberToken;
}
