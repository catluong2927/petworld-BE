package com.petworld.service;

import com.petworld.dto.userDto.response.UserDtoResponse;
import com.petworld.payload.response.LoginResponse;
import com.petworld.security.JwtTokenProvider;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;

@Service
@Transactional
public class AuthService {
    @Autowired
    private AuthenticationManager authenticationManager;
    @Autowired
    private UserService userService;
    @Autowired
    JwtTokenProvider tokenProvider;
    public AuthService(UserService userService,JwtTokenProvider tokenProvider,AuthenticationManager authenticationManager){
        this.userService = userService;
        this.tokenProvider = tokenProvider;
        this.authenticationManager = authenticationManager;
    }
    @Override
    public LoginResponse login
//    Authentication authentication = authenticationManager
//            .authenticate(new UsernamePasswordAuthenticationToken(
//                    loginRequest.getEmail(), loginRequest.getPassword()));
//
//            SecurityContextHolder.getContext().setAuthentication(authentication);
//
//    // Gọi hàm tạo Token
//    String token = tokenProvider.generateToken(authentication);
//    UserDtoResponse userDtoResponse = userService.getUserByEmail(loginRequest.getEmail());
}
