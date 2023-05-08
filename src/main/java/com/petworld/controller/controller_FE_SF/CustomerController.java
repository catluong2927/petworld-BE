package com.petworld.controller.controller_FE_SF;

import com.petworld.dto.userDto.response.UserDtoResponse;
import com.petworld.payload.request.SearchRequest;
import com.petworld.service.UserService;
import com.petworld.service.SecurityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin(value = "*", maxAge = 3600)
@RestController
@RequestMapping("/api/customer")
public class CustomerController {
    @Autowired
    private UserService userService;

    @Autowired
    private SecurityService securityService;

//    @GetMapping({"/all"})
//    public ResponseEntity<?> getAll(@RequestHeader("Authorization") final String authToken) {
//        if (!securityService.isAuthenticated() && !securityService.isValidToken(authToken)) {
//            return new ResponseEntity<String>("Responding with unauthorized error. Message - {}", HttpStatus.UNAUTHORIZED);
//        }
//        List<UserDtoResponse> userDtoResponse = userService.getUsers();
//        if (userDtoResponse.isEmpty()) {
//            return new ResponseEntity<List<UserDtoResponse>>(HttpStatus.NO_CONTENT);
//        }
//        return new ResponseEntity<>(userDtoResponse, HttpStatus.OK);
//    }

//    @GetMapping("/{id}")
//    public ResponseEntity<?> getOne(@PathVariable("id") Integer id,
//                                    @RequestHeader("Authorization") final String authToken) {
//        if (!securityService.isAuthenticated() && !securityService.isValidToken(authToken)) {
//            return new ResponseEntity<String>("Responding with unauthorized error. Message - {}", HttpStatus.UNAUTHORIZED);
//        }
//        UserDtoResponse userDtoResponse = userService.getUserById(id);
//        if (userDtoResponse == null) {
//            return new ResponseEntity<UserDtoResponse>(HttpStatus.NOT_FOUND);
//        }
//        return new ResponseEntity<>(userDtoResponse, HttpStatus.OK);
//    }
//
//    @PostMapping("/search")
//    public ResponseEntity<?> search(@RequestBody SearchRequest searchRequest,
//                                    @RequestHeader("Authorization") final String authToken) {
//        if (!securityService.isAuthenticated() && !securityService.isValidToken(authToken)) {
//            return new ResponseEntity<String>("Responding with unauthorized error. Message - {}", HttpStatus.UNAUTHORIZED);
//        }
//        List<UserDtoResponse> userDtoResponse = null;
//        if (searchRequest.getKeyword() != null && !searchRequest.getKeyword().isEmpty()) {
//            userDtoResponse = userService.getUsersByFullName(searchRequest.getKeyword());
//            if (userDtoResponse.isEmpty()) {
//                return new ResponseEntity<List<UserDtoResponse>>(HttpStatus.NO_CONTENT);
//            }
//        }
//        return new ResponseEntity<>(userDtoResponse, HttpStatus.OK);
//    }
}
