package com.petworld.dto.userDto.request;

import com.petworld.domain.Role;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.lang.Nullable;
import org.springframework.validation.annotation.Validated;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import java.util.Set;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Validated
public class UserDtoCreateRequest {
    @NotNull
    private String fullName;
    @NotNull
    @Pattern(regexp = "^(?=.{8,20}$)(?![_.])(?!.*[_.]{2})[a-zA-Z0-9._]+(?<![_.])$",message = "username có ít nhất 8 kí tự dài nhất 20 kí tự, không có các dấu chấm . _ ở đầu tên giữa và cuối tên")
    private String userName;
    @NotNull
    @Email
    @Pattern(regexp = "[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?", message = "địa chỉ mail không hợp lệ")
    private String email;
    @Pattern(regexp = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$",message = "password có ít nhất 8 kí tự, có chữ cái in hoa, chữ cái thường, kí tự đặt biệt")
    private String password;
    private String address;
    @NotNull
    private String phone;
    @Nullable
    private String avatar;
    @NotNull
    private Boolean isStatus = true;
    private String rememberToken;
    private Set<Role> roles;
    private String newPassword;
    private String oldPassword;

}
