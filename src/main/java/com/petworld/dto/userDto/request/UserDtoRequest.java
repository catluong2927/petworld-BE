package com.petworld.dto.userDto.request;
import com.petworld.domain.Role;
import com.petworld.domain.UserRole;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import java.util.Set;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class UserDtoRequest {
    private Long id;
    @NotNull
    private String fullName;
    @NotNull
    private String username;
    @NotNull
    @Email
    @Pattern(regexp = "/[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/,")
    private String email;
    @NotNull
//    @Pattern(regexp = "/^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$/,")
    private String password;
    private String address;
    private String phone;
    private String avatar;
    private Boolean activated;
    private String rememberToken;
    private Set<Role> roles;
}
