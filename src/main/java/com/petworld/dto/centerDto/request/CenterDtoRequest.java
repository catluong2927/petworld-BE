package com.petworld.dto.centerDto.request;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CenterDtoRequest {
    private Long id;
    private String name;
    private String phone;
    private String email;
    private String address;
    private Boolean isActive;
    private String userEmail;
}
