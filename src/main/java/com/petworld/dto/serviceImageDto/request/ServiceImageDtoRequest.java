package com.petworld.dto.serviceImageDto.request;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ServiceImageDtoRequest {
    private Long id;
    private String url;
}
