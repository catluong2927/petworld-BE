package com.petworld.dto.PackageDetailDto.response;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PackageDetailDtoResponse {
    private Long id;
    private String description;
    private Double price;
    private String image;
    private Boolean isActive;
    private String status;
    private String packageName;
    private String centerName;
}
