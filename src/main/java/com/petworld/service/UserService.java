package com.petworld.service;

import com.petworld.dto.userDto.request.UserDtoRequest;
import com.petworld.dto.userDto.response.UserDtoResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;


import java.util.List;
import java.util.Optional;

public interface UserService {
    List<UserDtoResponse> findAll();
    List<UserDtoResponse> getUsersByFullName(String fullName);
    UserDtoResponse getUserById(Long customerId);
    Page<UserDtoResponse> getUsers(Pageable pageable);
    Optional<UserDtoResponse> findById(Long id);
    Boolean save(UserDtoRequest userDtoRequest);
    void remove(Long id);
//    Boolean update(UserDtoRequest userDtoRequest);
}
