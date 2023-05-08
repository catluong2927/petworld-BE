package com.petworld.dto.centerDto.response;

import com.petworld.domain.Seller;

import java.util.List;

public class CenterDtoResponse {
    private Long id;
    private String name;
    List<Seller> sellers;
    private Boolean isActive;
}
