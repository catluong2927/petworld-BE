package com.petworld.converter;

import com.petworld.domain.User;
import com.petworld.dto.userDto.request.UserDtoCreateRequest;
import com.petworld.dto.userDto.response.UserDtoResponse;
import com.petworld.dto.userDto.response.UserDtoResponseDetail;
//import com.petworld.validation.RegexValidate;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Component;

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
    public User dtoToEntity(UserDtoCreateRequest userDtoCreateRequest){
        User user = new User();
        BeanUtils.copyProperties(userDtoCreateRequest, user);
        return user;
    }
    public User dtoToEntity(UserDtoCreateRequest userDtoCreateRequest, User user){
        BeanUtils.copyProperties(userDtoCreateRequest, user);
        return user;
    }

    public UserDtoResponseDetail entityToUserDtoResponseDetail(User user){
        UserDtoResponseDetail userDtoResponseDetail = new UserDtoResponseDetail();
        BeanUtils.copyProperties(user, userDtoResponseDetail);
        return userDtoResponseDetail;
    }

}
