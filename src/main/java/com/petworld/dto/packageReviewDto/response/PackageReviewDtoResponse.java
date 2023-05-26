package com.petworld.dto.packageReviewDto.response;

import com.petworld.dto.userDto.response.UserDtoResponse;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PackageReviewDtoResponse {
    private Long id;

    private String review;

    private Integer star;

    private Date date;
    private UserDtoResponse userDtoResponse;
}
