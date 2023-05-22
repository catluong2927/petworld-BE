package com.petworld.dto.userDto.response;

import com.petworld.dto.userRoleDto.response.UserRoleDtoResponse;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Set;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class UserDtoResponse {
    private Long id;
    private String fullName;
    private String userName;
    private String email;
    private String avatar;
    private Set<UserRoleDtoResponse> userRoleDtos;
}
