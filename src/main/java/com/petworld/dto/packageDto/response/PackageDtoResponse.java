package com.petworld.dto.packageDto.response;


import com.petworld.dto.serviceDto.response.ServiceDtoResponse;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PackageDtoResponse {
    private Long id;
    private String name;
    private String description;
    private Float minPrice;
    private Float maxPrice;
    private String image;
    private boolean isActive;
    private String status;
    private List<ServiceDtoResponse> serviceDtoResponses;
}
