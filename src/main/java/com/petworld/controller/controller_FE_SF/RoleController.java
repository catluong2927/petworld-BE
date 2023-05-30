package com.petworld.controller.controller_FE_SF;

import com.petworld.dto.roleDto.response.RoleDtoResponse;
import com.petworld.entity.Role;
import com.petworld.service.RoleService;
import com.petworld.service.SecurityService;
import com.petworld.service.UserService;
import com.petworld.service.impl.RoleServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin(value = "*", maxAge = 3600)
@RestController
@RequestMapping("/api/roles")
public class RoleController {
    @Autowired
    private SecurityService securityService;
    @Autowired
    private RoleService roleService;
    @GetMapping
    public ResponseEntity<?> getAllRole (@RequestHeader("Authorization") final String authToken){
        if (!securityService.isAuthenticated() && !securityService.isValidToken(authToken)) {
            return new ResponseEntity<String>("Responding with unauthorized error. Message - {}", HttpStatus.UNAUTHORIZED);
        }
        List<RoleDtoResponse> roleDtoResponses = roleService.getAllRole();
        if(!roleDtoResponses.isEmpty()) return new ResponseEntity<>(roleDtoResponses, HttpStatus.OK);
        else return new ResponseEntity<>(null,HttpStatus.BAD_REQUEST);
    }
}
