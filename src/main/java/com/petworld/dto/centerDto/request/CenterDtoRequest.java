package com.petworld.dto.centerDto.request;

import com.petworld.domain.Seller;

import java.util.List;

public class CenterDtoRequest {
    private String name;
    List<Seller> sellers;
    private Boolean isActive;
}
