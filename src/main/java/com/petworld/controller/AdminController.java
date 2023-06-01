package com.petworld.controller;

import com.petworld.dto.roleDto.response.RoleDtoResponse;
import com.petworld.entity.Role;
import com.petworld.security.JwtAuthFilter;
import com.petworld.security.JwtTokenProvider;
import com.petworld.service.RoleService;
import com.petworld.service.SecurityService;
import com.petworld.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

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
    @Autowired
    private RoleService roleService;

//    @PutMapping("/{id}")
//    public ResponseEntity<?> updateRoleAdd(@PathVariable("id") Long id, @RequestBody Role role,
//                                        @RequestHeader("Authorization") final String authToken) {
//        if (!securityService.isAuthenticated() && !securityService.isValidToken(authToken)) {
//            return new ResponseEntity<String>("Responding with unauthorized error. Message - {}", HttpStatus.UNAUTHORIZED);
//        }
//        if(userService.updateAddRole(id,role)){
//            return new ResponseEntity<String>("Update role successful", HttpStatus.OK);
//        } else return new ResponseEntity<String>("update role failed", HttpStatus.BAD_REQUEST);
//    }

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
    @PutMapping("/{id}")
    public ResponseEntity<?> updateRole (@PathVariable("id") Long id, @RequestParam List<Long> roles,
                                        @RequestHeader("Authorization") final String authToken) {

        if (!securityService.isAuthenticated() && !securityService.isValidToken(authToken)) {
            return new ResponseEntity<String>("Responding with unauthorized error. Message - {}", HttpStatus.UNAUTHORIZED);
        }
        Boolean updateRole = userService.updateRole(id,roles);
        if(updateRole) return new ResponseEntity<String>("Update role successful", HttpStatus.OK);
        return new ResponseEntity<String>("update role failed", HttpStatus.BAD_REQUEST);
    }
//    @GetMapping
//    public ResponseEntity<?> getAllRole (@RequestHeader("Authorization") final String authToken){
//        if (!securityService.isAuthenticated() && !securityService.isValidToken(authToken)) {
//            return new ResponseEntity<String>("Responding with unauthorized error. Message - {}", HttpStatus.UNAUTHORIZED);
//        }
//        List<RoleDtoResponse> roleDtoResponses = roleService.getAllRole();
//        if(!roleDtoResponses.isEmpty()) return new ResponseEntity<>(roleDtoResponses, HttpStatus.OK);
//        else return new ResponseEntity<>(null,HttpStatus.BAD_REQUEST);
//    }
}
