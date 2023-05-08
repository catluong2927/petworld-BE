package com.petworld.dto.userDto.response;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class UserDtoResponseDetail {
    private Long id;
    private String fullName;
    private String username;
    private String email;
    private String address;
    private String phone;
    private String avatar;
    private Boolean activated;
    private String rememberToken;
}
