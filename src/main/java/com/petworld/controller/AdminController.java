package com.petworld.controller;

import com.petworld.dto.userDto.request.UserDtoCreateRequest;
import com.petworld.dto.userDto.request.UserDtoPassword;
import com.petworld.dto.userDto.request.UserDtoUpdate;
import com.petworld.dto.userDto.response.UserDtoResponse;
import com.petworld.dto.userDto.response.UserDtoResponseDetail;
import com.petworld.payload.request.SearchRequest;
import com.petworld.payload.response.UserDtoReponse;
import com.petworld.security.JwtAuthFilter;
import com.petworld.security.JwtTokenProvider;
import com.petworld.service.SecurityService;
import com.petworld.service.UserService;
//import com.petworld.validation.UserDtoValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@CrossOrigin(value = "*", maxAge = 3600)
@RestController
@RequestMapping("/api/users")
public class AdminController {
    @Autowired
    private UserService userService;

    @Autowired
    private SecurityService securityService;
    @Autowired
    private JwtAuthFilter jwtAuthFilter;
    @Autowired
    private JwtTokenProvider tokenProvider;
    @Autowired
    private Environment env;

    @GetMapping
    public ResponseEntity<?> getAll(@RequestHeader("Authorization") final String authToken, @PageableDefault(size = 3) Pageable pageable) {
        if (!securityService.isAuthenticated() && !securityService.isValidToken(authToken)) {
            return new ResponseEntity<String>("Responding with unauthorized error. Message - {}", HttpStatus.UNAUTHORIZED);
        }
        Page<UserDtoResponse> userDtoResponses = userService.getUsers(pageable);
        if (userDtoResponses.isEmpty()) {
            return new ResponseEntity<Page<UserDtoResponse>>(HttpStatus.NO_CONTENT);
        }
        return new ResponseEntity<>(userDtoResponses, HttpStatus.OK);
    }


    @GetMapping("/{id}")
    public ResponseEntity<?> getOne(@PathVariable("id") Long id,
                                    @RequestHeader("Authorization") final String authToken) {
        if (!securityService.isAuthenticated() && !securityService.isValidToken(authToken)) {
            return new ResponseEntity<String>("Responding with unauthorized error. Message - {}", HttpStatus.UNAUTHORIZED);
        }
        UserDtoResponseDetail userDtoResponseDetail = userService.getUserById(id);
        if (userDtoResponseDetail == null) {
            return new ResponseEntity<UserDtoResponseDetail>(HttpStatus.NOT_FOUND);
        }
        return new ResponseEntity<>(userDtoResponseDetail, HttpStatus.OK);
    }

    @PostMapping("/search")
    public ResponseEntity<?> search(@RequestBody SearchRequest searchRequest,
                                    @RequestHeader("Authorization") final String authToken) {
        if (!securityService.isAuthenticated() && !securityService.isValidToken(authToken)) {
            return new ResponseEntity<String>("Responding with unauthorized error. Message - {}", HttpStatus.UNAUTHORIZED);
        }
        List<UserDtoResponse> userDtoResponses = null;
        if (searchRequest.getKeyword() != null && !searchRequest.getKeyword().isEmpty()) {
            userDtoResponses = userService.getUsersByFullName(searchRequest.getKeyword());
            if (userDtoResponses.isEmpty()) {
                return new ResponseEntity<List<UserDtoResponse>>(HttpStatus.NOT_FOUND);
            }
        }
        return new ResponseEntity<>(userDtoResponses, HttpStatus.OK);
    }

    @PostMapping
    public ResponseEntity<?> create(@Validated @RequestBody UserDtoCreateRequest userDtoCreateRequest, BindingResult bindingResult) {
//        new UserDtoValidator(userService).validate(userDtoCreateRequest, bindingResult);
        UserDtoReponse userDtoReponse = userService.save(userDtoCreateRequest);
        if (userDtoReponse == null) {
            return new ResponseEntity<>(null, HttpStatus.OK);
        } else return new ResponseEntity<>(userDtoReponse, HttpStatus.BAD_REQUEST);
    }


    @PutMapping
    public ResponseEntity<?> updateUser(@RequestBody UserDtoUpdate userDtoUpdate,
                                        @RequestHeader("Authorization") final String authToken, HttpServletRequest request) {
        if (!securityService.isAuthenticated() && !securityService.isValidToken(authToken)) {
            return new ResponseEntity<String>("Responding with unauthorized error. Message - {}", HttpStatus.UNAUTHORIZED);
        }
        String jwt = jwtAuthFilter.getJwtFromRequest(request);
        if (StringUtils.hasText(jwt) && tokenProvider.validateToken(jwt)) {
            String email = tokenProvider.getEmailFromJWT(jwt);
            if (userService.updateSimple(email, userDtoUpdate))
                return new ResponseEntity<String>("Update successful", HttpStatus.OK);
            else return new ResponseEntity<String>("update failed", HttpStatus.BAD_REQUEST);
        } else return new ResponseEntity<String>("update failed", HttpStatus.BAD_REQUEST);
    }

    @PutMapping("/password")
    public ResponseEntity<?> updatePassword(@RequestBody UserDtoPassword userDtoPassword,
                                            @RequestHeader("Authorization") final String authToken, HttpServletRequest request) {
        if (!securityService.isAuthenticated() && !securityService.isValidToken(authToken)) {
            return new ResponseEntity<String>("Responding with unauthorized error. Message - {}", HttpStatus.UNAUTHORIZED);
        }
        String jwt = jwtAuthFilter.getJwtFromRequest(request);
        if (StringUtils.hasText(jwt) && tokenProvider.validateToken(jwt)) {
            String email = tokenProvider.getEmailFromJWT(jwt);
            if (userService.updatePassword(email, userDtoPassword))
                return new ResponseEntity<String>("Update successful", HttpStatus.OK);
            else return new ResponseEntity<String>("update failed", HttpStatus.BAD_REQUEST);
        } else return new ResponseEntity<String>("update failed", HttpStatus.BAD_REQUEST);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> delete(@PathVariable("id") Long id,
                                    @RequestHeader("Authorization") final String authToken) {
        if (!securityService.isAuthenticated() && !securityService.isValidToken(authToken)) {
            return new ResponseEntity<String>("Responding with unauthorized error. Message - {}", HttpStatus.UNAUTHORIZED);
        }
        if (!userService.remove(id)) {
            return new ResponseEntity<String>("delete failed", HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<String>("successful delete", HttpStatus.OK);
    }
}
