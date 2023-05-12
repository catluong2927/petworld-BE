package com.petworld.domain;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.*;
import javax.persistence.*;
import java.util.List;
import java.util.Set;

@Entity
@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@Table(name = "product")
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;
    private String description;
    private String image;
    private Double price;
    @Column(name = "product_code")
    private String productCode;
    private String protein;
    private String fats;
    private String carbohydrates;
    private String minerals;
    private String vitamins;
    private String animal;
    private Integer sale;
    private Boolean status;
    @OneToOne
    @JoinColumn(name = "mark_id", referencedColumnName = "id")
    private Mark mark;
    @OneToMany(mappedBy = "product", fetch = FetchType.LAZY)
    private List<CartDetail> cartDetailList;
}
