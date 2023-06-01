package com.petworld.dto.roleDto.response;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class RoleDtoResponse {
    private Long id;
    private String name;
    private String desc;
}
