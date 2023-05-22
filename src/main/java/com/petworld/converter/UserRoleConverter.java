package com.petworld.converter;

import com.petworld.domain.UserRole;
import com.petworld.dto.userRoleDto.response.UserRoleDtoResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Component;

import java.util.HashSet;
import java.util.Set;

@Component
@RequiredArgsConstructor
public class UserRoleConverter {
    private final RoleConverter roleConverter;
    public Set<UserRoleDtoResponse> entitiesToDtos(Set<UserRole> userRoleSet ){
        Set<UserRoleDtoResponse> userRoleDtoResponses = new HashSet<>();
        if(!userRoleSet.isEmpty()) {
            for(UserRole element : userRoleSet){
                UserRoleDtoResponse userRoleDtoResponse = entityToDto(element);
                userRoleDtoResponses.add(userRoleDtoResponse);
            }
            return userRoleDtoResponses;
        }
        return null;
    }
    public UserRoleDtoResponse entityToDto(UserRole userRole){
        UserRoleDtoResponse userRoleDtoResponse = new UserRoleDtoResponse();
        BeanUtils.copyProperties(userRole, userRoleDtoResponse);
        userRoleDtoResponse.setRoleDtoResponse(roleConverter.entityToDto(userRole.getRole()));
        return userRoleDtoResponse;
    }
}