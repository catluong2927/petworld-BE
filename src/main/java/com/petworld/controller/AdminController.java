package com.petworld.controller;

import com.petworld.entity.Role;
import com.petworld.security.JwtAuthFilter;
import com.petworld.security.JwtTokenProvider;
import com.petworld.service.SecurityService;
import com.petworld.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@CrossOrigin(value = "*", maxAge = 3600)
@RestController
@RequestMapping("/api/role")
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
    @PutMapping("/{id}")
    public ResponseEntity<?> updateRoleAdd(@PathVariable("id") Long id, @RequestBody Role role,
                                        @RequestHeader("Authorization") final String authToken) {
        if (!securityService.isAuthenticated() && !securityService.isValidToken(authToken)) {
            return new ResponseEntity<String>("Responding with unauthorized error. Message - {}", HttpStatus.UNAUTHORIZED);
        }
        if(userService.updateAddRole(id,role)){
            return new ResponseEntity<String>("Update role successful", HttpStatus.OK);
        } else return new ResponseEntity<String>("update role failed", HttpStatus.BAD_REQUEST);
    }

    @PutMapping("/remove/{id}")
    public ResponseEntity<?> updateRoleRemove(@PathVariable("id") Long id, @RequestBody Role role,
                                           @RequestHeader("Authorization") final String authToken) {
        if (!securityService.isAuthenticated() && !securityService.isValidToken(authToken)) {
            return new ResponseEntity<String>("Responding with unauthorized error. Message - {}", HttpStatus.UNAUTHORIZED);
        }
        if(userService.updateRemoveRole(id,role)) {
            return new ResponseEntity<String>("Update role successful", HttpStatus.OK);
        }
        return new ResponseEntity<String>("update role failed", HttpStatus.BAD_REQUEST);
    }
}
