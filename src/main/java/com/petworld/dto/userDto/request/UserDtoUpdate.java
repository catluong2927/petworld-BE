package com.petworld.dto.userDto.request;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class UserDtoUpdate {
    private String fullName;
    private String address;
    private String phone;
    private String avatar;
}
