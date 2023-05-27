package com.petworld.dto.packageDetailReviewDto.request;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PackageDetailReviewDtoRequest {
    private Long id;

    private String review;

    private Integer star;

    private Date date;
    private Long packageDetailId;
    private String userEmail;
}
