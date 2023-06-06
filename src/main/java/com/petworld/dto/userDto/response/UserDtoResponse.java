package com.petworld.dto.userDto.response;

import com.petworld.dto.userRoleDto.response.UserRoleDtoResponse;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.sql.Date;
import java.util.List;
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
    private Boolean isStatus;
    private String phone;
    private String address;
    private Date dob;
    private String descript;
    private List<UserRoleDtoResponse> userRoleDtos;
}
