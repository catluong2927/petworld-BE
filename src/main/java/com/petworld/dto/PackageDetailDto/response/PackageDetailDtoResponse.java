package com.petworld.dto.PackageDetailDto.response;

import com.petworld.dto.packageDetailReviewDto.response.PackageDetailReviewDtoResponse;
import com.petworld.dto.serviceDto.response.ServiceDtoResponse;
import com.petworld.entity.PackageDetailReview;
import com.petworld.entity.Service;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.domain.Page;

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
    private Page<ServiceDtoResponse> serviceDtoResponses;
    private Page<PackageDetailReviewDtoResponse> packageDetailReviewDtoResponses;
}
