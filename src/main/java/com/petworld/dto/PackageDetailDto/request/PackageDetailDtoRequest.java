package com.petworld.dto.PackageDetailDto.request;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PackageDetailDtoRequest {
    private Long id;
    private String name;
    private String description;
    private Double price;
    private String image;
    private String status;
    private Boolean isActive;
    private String userEmail;
    private Long packageId;
}
