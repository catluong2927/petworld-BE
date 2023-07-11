package com.petworld.dto.imagedetailDto.request;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class UpdateImageDetailDto {
    private Long id;
    private String url;
}
