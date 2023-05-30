package com.petworld.converter;

import com.petworld.dto.productDto.response.ProductDtoResponse;
import com.petworld.entity.Product;
import com.petworld.entity.Role;
import com.petworld.dto.roleDto.response.RoleDtoResponse;
import org.springframework.beans.BeanUtils;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

@Component
public class RoleConverter {

    public List<RoleDtoResponse> entitiesToDtos(List<Role> roles){
        List<RoleDtoResponse> roleDtoResponses = roles.stream().map(product -> entityToDto(product)).collect(Collectors.toList());
        return roleDtoResponses;
    }

    public RoleDtoResponse entityToDto(Role role){
        RoleDtoResponse roleDtoResponse = new RoleDtoResponse();
        BeanUtils.copyProperties(role, roleDtoResponse);
        return roleDtoResponse;
    }
}
