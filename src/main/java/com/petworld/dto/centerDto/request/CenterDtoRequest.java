package com.petworld.dto.centerDto.request;

import com.petworld.domain.Seller;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;
@Data
@NoArgsConstructor
@AllArgsConstructor
public class CenterDtoRequest {
    private String name;
    List<Seller> sellers;
    private Boolean isActive;
}
