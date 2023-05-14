package com.petworld.dto.serviceDto.request;

import com.petworld.domain.Package;
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

    private Package aPackage;

    private boolean isActive;
}
