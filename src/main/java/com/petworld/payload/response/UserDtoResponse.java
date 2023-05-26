package com.petworld.payload.response;

import com.petworld.entity.UserRole;
import lombok.Data;

import java.util.Set;

@Data
public class UserDtoResponse {
    private Long id;
    private String userName;
    private String email;
    private Set<UserRole> userRoles;
}
