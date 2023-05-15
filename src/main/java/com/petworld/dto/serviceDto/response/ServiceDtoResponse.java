package com.petworld.dto.serviceDto.response;

import com.petworld.dto.serviceImageDto.response.ServiceImageDtoResponse;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ServiceDtoResponse {
    private Long id;

    private String name;

    private String description;

    private Float price;

    private boolean isActive;
    private List<ServiceImageDtoResponse> serviceImages;
}
