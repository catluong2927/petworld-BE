package com.petworld.converter;

import com.petworld.entity.UserRole;
import com.petworld.dto.userRoleDto.response.UserRoleDtoResponse;
import com.petworld.dto.userRoleDto.response.UserRoleDtoResponseDetail;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
@RequiredArgsConstructor
public class UserRoleConverter {
    private final RoleConverter roleConverter;
    public List<UserRoleDtoResponse> entitiesToDtos(List<UserRole> userRoleSet ){
        List<UserRoleDtoResponse> userRoleDtoResponses = new ArrayList<>();
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
    public List<UserRoleDtoResponseDetail> entitiesToDtoResponseDetails(List<UserRole> userRoleSet ){
        List<UserRoleDtoResponseDetail> userRoleDtoResponses = new ArrayList<>();
        if(!userRoleSet.isEmpty()) {
            for(UserRole element : userRoleSet){
                UserRoleDtoResponseDetail userRoleDtoResponseDetail = entityToDtoResponseDetail(element);
                userRoleDtoResponses.add(userRoleDtoResponseDetail);
            }
            return userRoleDtoResponses;
        }
        return null;
    }
    public UserRoleDtoResponseDetail entityToDtoResponseDetail(UserRole userRole){
        UserRoleDtoResponseDetail userRoleDtoResponseDetail = new UserRoleDtoResponseDetail();
        BeanUtils.copyProperties(userRole, userRoleDtoResponseDetail);
        userRoleDtoResponseDetail.setRoleDtoResponse(roleConverter.entityToDto(userRole.getRole()));
        return userRoleDtoResponseDetail;
    }
}