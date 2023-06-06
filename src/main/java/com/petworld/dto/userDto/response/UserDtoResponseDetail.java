package com.petworld.dto.userDto.response;
import com.petworld.dto.userRoleDto.response.UserRoleDtoResponseDetail;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.sql.Date;
import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class UserDtoResponseDetail {
    private Long id;
    private String fullName;
    private String userName;
    private String email;
    private String address;
    private String phone;
    private String avatar;
    private String descript;
    private Date dob;
    private List<UserRoleDtoResponseDetail> userRoleDtos;
}
