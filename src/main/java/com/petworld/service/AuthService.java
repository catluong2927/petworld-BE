package com.petworld.service;

import com.petworld.entity.User;
import com.petworld.dto.userDto.response.UserDtoResponse;
import com.petworld.payload.request.LoginRequest;
import com.petworld.payload.response.LoginResponse;

public interface AuthService {
    LoginResponse login (LoginRequest loginRequest);
    Boolean isExistAccount (String account);
}
