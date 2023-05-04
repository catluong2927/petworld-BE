package com.petworld.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;
import javax.validation.constraints.NotBlank;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "customer")
public class Customer {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Integer id;

    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(name = "customer_role",
            joinColumns = @JoinColumn(name = "customer_id"),
            inverseJoinColumns = @JoinColumn(name = "role_id"))
    @OnDelete(action = OnDeleteAction.CASCADE)
    private Set<Role> roles = new HashSet<Role>();

    @NotBlank
    @Column(name = "full_name", length = 255, nullable = false)
    private String fullName;

    @NotBlank
    @Column(name = "username", length = 255, nullable = false)
    private String username;

    @NotBlank
    @Column(name = "password", length = 255, nullable = false)
    private String password;

    @NotBlank
    @Column(name = "email", length = 255, nullable = false)
    private String email;

    @NotBlank
    @Column(name = "address", length = 255, nullable = true)
    private String address;

    @NotBlank
    @Column(name = "phone", length = 255, nullable = true)
    private String phone;

    @NotBlank
    @Column(name = "avatar",
            columnDefinition = "text", nullable = true)
    private String avatar;

    @Column(name = "is_status", nullable = true)
    private Boolean isStatus;

    @Column(name = "remember_token", length = 255, nullable = true)
    private String rememberToken;

//    @OneToOne(mappedBy = "customer")
//    private Cart cart;
}
