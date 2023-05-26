package com.petworld.dto.packageDto.request;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PackageDtoRequest {
    private Long id;
    private String name;

}
