package com.petworld.dto.serviceDto.request;

import com.petworld.entity.Package;
import com.petworld.entity.PackageDetail;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ServiceDtoRequest {
    private Long id;

    private String name;

    private String description;

    private Float price;

    private PackageDetail packageDetail;

    private boolean isActive;
}
