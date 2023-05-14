package com.petworld.dto.packageReviewDto.request;

import com.petworld.domain.User;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PackageReviewDtoRequest {
    private Long id;

    private String review;

    private Integer star;

    private Date date;
    private User user;
}
