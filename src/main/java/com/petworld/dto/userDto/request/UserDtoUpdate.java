package com.petworld.dto.userDto.request;

import com.petworld.domain.Role;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.validation.constraints.NotNull;
import java.util.Set;

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
