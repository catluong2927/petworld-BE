package com.petworld.converter;

import com.petworld.domain.User;
import com.petworld.dto.userDto.request.UserDtoRequest;
import com.petworld.dto.userDto.response.UserDtoResponse;
import com.petworld.dto.userDto.response.UserDtoResponseDetail;
import org.springframework.beans.BeanUtils;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Component
public class UserConverter {
    public Optional<UserDtoResponse> entityToDtoOptional(Optional<User> user ){
        Optional<UserDtoResponse> userDtoResponse = Optional.of(new UserDtoResponse());
        BeanUtils.copyProperties(user,userDtoResponse);
        return userDtoResponse;
    }
    public UserDtoResponse entityToDto(User user){
        UserDtoResponse userDtoResponse = new UserDtoResponse();
        BeanUtils.copyProperties(user, userDtoResponse);
        return userDtoResponse;
    }
    public User dtoToEntity(UserDtoRequest userDtoRequest){
        User user = new User();
        BeanUtils.copyProperties(userDtoRequest, user);
        return user;
    }

    public UserDtoResponseDetail entityToUserDtoResponseDetail(User user){
        UserDtoResponseDetail userDtoResponseDetail = new UserDtoResponseDetail();
        BeanUtils.copyProperties(user, userDtoResponseDetail);
        return userDtoResponseDetail;
    }

}
