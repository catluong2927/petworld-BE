package com.petworld.converter;

import com.petworld.entity.Role;
import com.petworld.dto.roleDto.response.RoleDtoResponse;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Component;

@Component
public class RoleConverter {
    public RoleDtoResponse entityToDto(Role role){
        RoleDtoResponse roleDtoResponse = new RoleDtoResponse();
        BeanUtils.copyProperties(role, roleDtoResponse);
        return roleDtoResponse;
    }
}