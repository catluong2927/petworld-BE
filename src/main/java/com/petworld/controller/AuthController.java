package com.petworld.controller;

import com.petworld.dto.userDto.request.UserDtoCreateRequest;
import com.petworld.dto.userDto.response.UserDtoResponse;
import com.petworld.payload.request.LoginRequest;
import com.petworld.payload.response.LoginResponse;
import com.petworld.payload.response.checkEmailPassword;
import com.petworld.security.JwtTokenProvider;
import com.petworld.service.AuthService;
import com.petworld.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
//import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

@CrossOrigin("*")
@RestController
@RequestMapping("/api/auth")
public class AuthController {
    @Autowired
    private UserService userService;
    @Autowired
    private AuthService authService;

    @PostMapping("/login")
    public ResponseEntity<?> login(@Valid @RequestBody LoginRequest loginRequest) {
        try {
            LoginResponse loginResponse = authService.login(loginRequest);
            return new ResponseEntity<>(loginResponse, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>("this Account is not valid", HttpStatus.BAD_REQUEST);
        }
    }

    @PostMapping
    public ResponseEntity<?> create(@Validated @RequestBody UserDtoCreateRequest userDtoCreateRequest) {
        checkEmailPassword checkEmailPassword = userService.save(userDtoCreateRequest);
        if (checkEmailPassword == null) {
            return new ResponseEntity<>(null, HttpStatus.OK);
        } else return new ResponseEntity<>(checkEmailPassword, HttpStatus.BAD_REQUEST);
    }

    @GetMapping
    public ResponseEntity<?> findUserByAccount(@Valid @RequestParam String account) {

        Boolean isExist = authService.isExistAccount(account);
        if (!isExist) return new ResponseEntity<>(false, HttpStatus.OK);
        else return new ResponseEntity<>(true, HttpStatus.BAD_REQUEST);

    }
}
