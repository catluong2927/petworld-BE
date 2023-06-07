package com.petworld.controller.controller_FE_SF;

import com.petworld.dto.userDto.request.UserDtoPassword;
import com.petworld.dto.userDto.request.UserDtoUpdate;
import com.petworld.dto.userDto.response.UserDtoResponse;
import com.petworld.dto.userDto.response.UserDtoResponseDetail;
import com.petworld.payload.request.SearchRequest;
import com.petworld.security.JwtAuthFilter;
import com.petworld.security.JwtTokenProvider;
import com.petworld.service.SecurityService;
import com.petworld.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@CrossOrigin(value = "*", maxAge = 3600)
@RestController
@RequestMapping("/api/users")
public class UserController {
    @Autowired
    private UserService userService;

    @Autowired
    private SecurityService securityService;
    @Autowired
    private JwtAuthFilter jwtAuthFilter;
    @Autowired
    private JwtTokenProvider tokenProvider;

    @GetMapping
    public ResponseEntity<?> getAll(@RequestHeader("Authorization") final String authToken,
                                    @PageableDefault(size = 5) Pageable pageable) {

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
            return new ResponseEntity<>(null,HttpStatus.NOT_FOUND);
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
    @PutMapping
    public ResponseEntity<?> updateUser(@RequestBody UserDtoUpdate userDtoUpdate,
                                        @RequestHeader("Authorization") final String authToken) {
        if (!securityService.isAuthenticated() && !securityService.isValidToken(authToken)) {
            return new ResponseEntity<String>("Responding with unauthorized error. Message - {}", HttpStatus.UNAUTHORIZED);
        }
            if (userService.updateSimple( userDtoUpdate))
                return new ResponseEntity<String>("Update successful", HttpStatus.OK);
            else return new ResponseEntity<String>("update failed", HttpStatus.BAD_REQUEST);
    }

    @PutMapping("/password")
    public ResponseEntity<?> updatePassword(@RequestBody UserDtoPassword userDtoPassword,
                                            @RequestHeader("Authorization") final String authToken, HttpServletRequest request) {
        if (!securityService.isAuthenticated() && !securityService.isValidToken(authToken)) {
            return new ResponseEntity<String>("Responding with unauthorized error. Message - {}", HttpStatus.UNAUTHORIZED);
        }
        String jwt = jwtAuthFilter.getJwtFromRequest(request);
        if (StringUtils.hasText(jwt) && tokenProvider.validateToken(jwt)) {
            if (userService.updatePassword(userDtoPassword))
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
    @PutMapping("/{id}")
    public ResponseEntity<?> updateImage(@PathVariable("id") Long id, @RequestParam String avatarUrl,
                                         @RequestHeader("Authorization") final String authToken) {
        if (!securityService.isAuthenticated() && !securityService.isValidToken(authToken)) {
            return new ResponseEntity<String>("Responding with unauthorized error. Message - {}", HttpStatus.UNAUTHORIZED);
        }
        Boolean updateImage = userService.updateImage(id,avatarUrl);
        UserDtoResponseDetail userDtoResponseDetail = userService.getUserById(id);
        if (!updateImage) {
            return new ResponseEntity<>(null,HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(userDtoResponseDetail.getAvatar(), HttpStatus.OK);
    }
}
