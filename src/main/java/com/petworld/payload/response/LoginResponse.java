package com.petworld.payload.response;

import org.springframework.lang.Nullable;

import javax.validation.constraints.NotBlank;

public class LoginResponse {

    @NotBlank
    private String message;

    @Nullable
    private String token;

    public LoginResponse() {
        super();
    }

    public LoginResponse(@NotBlank String message, String token) {
        super();
        this.message = message;
        this.token = token;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }
}
