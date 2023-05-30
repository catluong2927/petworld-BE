package com.petworld.controller.controller_FE_SF;

import com.petworld.dto.roleDto.response.RoleDtoResponse;
import com.petworld.entity.Role;
import com.petworld.service.RoleService;
import com.petworld.service.UserService;
import com.petworld.service.impl.RoleServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@CrossOrigin(value = "*", maxAge = 3600)
@RestController
@RequestMapping("/api/roless")
public class RoleController {
    @Autowired
    private RoleService roleService;
    @GetMapping
    public ResponseEntity<?> getAllRole (){
        List<RoleDtoResponse> roleDtoResponses = roleService.getAllRole();
        if(!roleDtoResponses.isEmpty()) return new ResponseEntity<>(roleDtoResponses, HttpStatus.OK);
        else return new ResponseEntity<>(null,HttpStatus.BAD_REQUEST);
    }
}
