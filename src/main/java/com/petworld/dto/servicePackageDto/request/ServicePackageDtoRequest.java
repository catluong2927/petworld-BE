package com.petworld.dto.servicePackageDto.request;

import com.petworld.domain.Service;
import com.petworld.domain.ServicePackageReview;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ServicePackageDtoRequest {
    private Long id;
    private String name;
    private String description;
    private Float minPrice;
    private Float maxPrice;

    private String image;
    private List<Service> services;

    private List<ServicePackageReview> reviews;
    private boolean isActive;
    private String status;
}
