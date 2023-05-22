package com.petworld.payload.response;

import com.petworld.dto.userDto.response.UserDtoResponse;
import lombok.*;

import javax.validation.constraints.NotBlank;

@Getter
@Setter
public class LoginResponse {
    private String message;
    private UserDtoResponse userDtoResponse;
    private String token;

    public LoginResponse(String message,String token) {
        this.message = message;
        this.token = token;
    }

    public LoginResponse(UserDtoResponse userDtoResponse, String token) {
        this.userDtoResponse = userDtoResponse;
        this.token = token;
    }

    public LoginResponse() {
    }
}

