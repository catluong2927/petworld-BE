package com.petworld.controller;

import com.petworld.dto.userDto.request.UserDtoRequest;
import com.petworld.dto.userDto.response.UserDtoResponse;
import com.petworld.payload.request.SearchRequest;
import com.petworld.repository.UserRepository;
import com.petworld.service.SecurityService;
import com.petworld.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.CrossOrigin;

import java.util.List;

@CrossOrigin(value = "*", maxAge = 3600)
@RestController
@RequestMapping("/api/users")
public class AdminController {
    @Autowired
    private UserService userService;

    @Autowired
    private SecurityService securityService;

    @GetMapping
    public ResponseEntity<?> getAll(@RequestHeader("Authorization") final String authToken,@PageableDefault(size = 3) Pageable pageable) {
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
        UserDtoResponse userDtoResponse = userService.getUserById(id);
        if (userDtoResponse == null) {
            return new ResponseEntity<UserDtoResponse>(HttpStatus.NOT_FOUND);
        }
        return new ResponseEntity<>(userDtoResponse, HttpStatus.OK);
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
    public ResponseEntity<?> create(@RequestBody UserDtoRequest userDtoRequest,
                                    @RequestHeader("Authorization") final String authToken){
        if (!securityService.isAuthenticated() && !securityService.isValidToken(authToken)) {
            return new ResponseEntity<String>("Responding with unauthorized error. Message - {}", HttpStatus.UNAUTHORIZED);
        }
        if(userService.save(userDtoRequest)) return new ResponseEntity<String>("successful new creation", HttpStatus.OK);
        else return new ResponseEntity<String>("new creation failed", HttpStatus.BAD_REQUEST);
    }
}
