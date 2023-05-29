package com.petworld.service.impl;

import com.petworld.converter.UserConverter;
import com.petworld.domain.User;
import com.petworld.dto.userDto.response.UserDtoResponse;
import com.petworld.payload.request.LoginRequest;
import com.petworld.payload.response.LoginResponse;
import com.petworld.repository.UserRepository;
import com.petworld.security.JwtTokenProvider;
import com.petworld.service.AuthService;
import com.petworld.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;

@Service
@Transactional
public class AuthServiceImpl implements AuthService {

    private final AuthenticationManager authenticationManager;

    private final UserRepository userRepository;

    private final JwtTokenProvider tokenProvider;
    private final UserConverter userConverter;

    public AuthServiceImpl(UserRepository userRepository, JwtTokenProvider tokenProvider, AuthenticationManager authenticationManager, UserConverter userConverter) {
        this.userRepository = userRepository;
        this.tokenProvider = tokenProvider;
        this.authenticationManager = authenticationManager;
        this.userConverter = userConverter;
    }

    @Override
    public LoginResponse login(LoginRequest loginRequest) {
        User currentUser = userRepository.findUserByAccount(loginRequest.getAccount());
//        if (currentUser != null) {
            UserDtoResponse userDtoResponse = userConverter.entityToDto(currentUser);
            Authentication authentication = authenticationManager
                    .authenticate(new UsernamePasswordAuthenticationToken(
                            userDtoResponse.getEmail(), loginRequest.getPassword()));

            SecurityContextHolder.getContext().setAuthentication(authentication);
            // Gọi hàm tạo Token
            String token = tokenProvider.generateToken(authentication);
            LoginResponse loginResponse = new LoginResponse(userDtoResponse, token);
            return loginResponse;
    }
    @Override
    public Boolean isExistAccount (String account){
        UserDtoResponse userDtoResponse = userConverter.entityToDto(userRepository.findUserByAccount(account));
        if( userDtoResponse != null) return true;
        else return false;
    }
}


