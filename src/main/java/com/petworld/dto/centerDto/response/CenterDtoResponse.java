package com.petworld.dto.centerDto.response;

import com.petworld.domain.Seller;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CenterDtoResponse {
    private Long id;
    private String name;
    List<Seller> sellers;
    private Boolean isActive;
}
