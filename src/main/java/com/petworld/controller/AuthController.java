package com.petworld.controller;

import com.petworld.dto.userDto.response.UserDtoResponse;
import com.petworld.payload.request.LoginRequest;
import com.petworld.payload.response.LoginResponse;
import com.petworld.payload.response.UserDtoReponse;
import com.petworld.repository.UserRepository;
import com.petworld.security.JwtTokenProvider;
import com.petworld.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
//import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

@CrossOrigin("*")
@RestController
@RequestMapping("/api/auth")
public class AuthController {
    @Autowired
    private AuthenticationManager authenticationManager;
    @Autowired
    private UserService userService;

//    @Autowired
//    PasswordEncoder passwordEncoder;

    @Autowired
    JwtTokenProvider tokenProvider;

    @PostMapping("/login")
    public ResponseEntity<LoginResponse> login(@Valid @RequestBody LoginRequest loginRequest) {
        try {
            // Call authenticate function to authenticate credentials
            Authentication authentication = authenticationManager
                    .authenticate(new UsernamePasswordAuthenticationToken(
                            loginRequest.getEmail(), loginRequest.getPassword()));

            SecurityContextHolder.getContext().setAuthentication(authentication);

            // Gọi hàm tạo Token
            String token = tokenProvider.generateToken(authentication);
            UserDtoResponse userDtoResponse = userService.getUserByEmail(loginRequest.getEmail());
            return new ResponseEntity<>(new LoginResponse(userDtoResponse, token), HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(new LoginResponse( "login fail",null), HttpStatus.BAD_REQUEST);
        }
    }
}
