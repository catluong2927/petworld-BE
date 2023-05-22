package com.petworld.service.impl;

import com.petworld.converter.UserConverter;
import com.petworld.domain.User;
import com.petworld.domain.UserRole;
import com.petworld.dto.userDto.request.UserDtoCreateRequest;
import com.petworld.dto.userDto.request.UserDtoPassword;
import com.petworld.dto.userDto.request.UserDtoUpdate;
import com.petworld.dto.userDto.response.UserDtoResponse;
import com.petworld.dto.userDto.response.UserDtoResponseDetail;
import com.petworld.payload.response.UserDtoReponse;
import com.petworld.repository.UserRoleRepository;
import com.petworld.repository.UserRepository;
import com.petworld.service.UserService;
//import com.petworld.validation.RegexValidate;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;


@Service
@Transactional
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;
    private final UserRoleRepository userRoleRepository;

    private final UserConverter userConverter;


    public UserServiceImpl(UserRepository userRepository, UserConverter userConverter,
                           UserRoleRepository userRoleRepository) {
        this.userRepository = userRepository;
        this.userConverter = userConverter;
        this.userRoleRepository = userRoleRepository;

    }

    @Override
    public Page<UserDtoResponse> getUsers(Pageable pageable) {
        Page<User> users = userRepository.findAll(pageable);
        return users.map(userConverter::entityToDto);
    }

    @Override
    public Optional<UserDtoResponse> findById(Long id) {
        Optional<User> customer = userRepository.findById(id);
        return Optional.ofNullable(userConverter.entityToDtoOptional(customer).get());
    }


    @Override
    public UserDtoReponse save(UserDtoCreateRequest userDtoCreateRequest) {
        User email = userRepository.findUserByEmail(userDtoCreateRequest.getEmail());
        User userName = userRepository.findUserByUserName(userDtoCreateRequest.getUserName());
        UserDtoReponse userDtoReponse = new UserDtoReponse();
        if (email != null && userName != null) {
            userDtoReponse.setUserName("userName already exists");
            userDtoReponse.setEmail("email already exists");
            return userDtoReponse;
        }
        else if (email == null && userName != null) {
                userDtoReponse.setUserName("userName already exists");
                return userDtoReponse;
        } else if (email != null && userName == null) {
            userDtoReponse.setEmail("email already exists");
            return userDtoReponse;
        } else {
            User newUser = userConverter.dtoToEntity(userDtoCreateRequest);
            String hashedPassword = BCrypt.hashpw(userDtoCreateRequest.getPassword(), BCrypt.gensalt(10));
            newUser.setPassword(hashedPassword);
            userRepository.save(newUser);
            userDtoCreateRequest.getRoles().forEach(role -> {
                UserRole userRole = new UserRole(newUser, role);
                userRoleRepository.save(userRole);
            });
            return null;
        }
    }

    @Override
    public Boolean remove(Long id) {
        Optional<User> user = userRepository.findById(id);
        if (user.isPresent()) {
            userRepository.deleteByIdUser(id);
            return true;
        }
        return false;
    }

    @Override
    public Boolean active(Long id) {
        Optional<User> user = userRepository.findById(id);
        if (user.isPresent()) {
            userRepository.activeByIdUser(id);
            return true;
        }
        return false;
    }

    @Override
    public List<UserDtoResponse> findAll() {
        List<User> users = userRepository.findAll();
        List<UserDtoResponse> userDtoResponses = new ArrayList<>();
        users.forEach(element -> {
            userDtoResponses.add(userConverter.entityToDto(element));
        });
        return userDtoResponses;
    }

    @Override
    public List<UserDtoResponse> getUsersByFullName(String fullName) {
        String likeFullName = "%" + fullName + "%";
        List<User> userByFullNames = userRepository.searchByFullName(likeFullName);
        List<UserDtoResponse> userDtoResponseFullNames = new ArrayList<>();
        userByFullNames.forEach(element -> {
            userDtoResponseFullNames.add(userConverter.entityToDto(element));
        });
        return userDtoResponseFullNames;
    }

    @Override
    public UserDtoResponse getUserByEmail(String email) {
        UserDtoResponse userDtoResponse = userConverter.entityToDto(userRepository.findUserByEmail(email));
        return userDtoResponse;
    }


//    @Override
//    public User findUserByEmail(String email) {
//        return userRepository.findUserByEmail(email);
//    }

    @Override
    public UserDtoResponseDetail getUserById(Long customerId) {
        User user = userRepository.findById(customerId).orElse(null);
        return userConverter.entityToUserDtoResponseDetail(user);
    }

    @Override
    public Boolean updateSimple(String email, UserDtoUpdate userDtoUpdate) {
        User user = userRepository.findUserByEmail(email);
        if (user != null) {
            user.setAddress(userDtoUpdate.getAddress());
            user.setFullName(userDtoUpdate.getFullName());
            user.setAvatar(userDtoUpdate.getAvatar());
            user.setPhone(userDtoUpdate.getPhone());
            userRepository.save(user);
            return true;
        }
        return false;
    }

    @Override
    public Boolean updatePassword(String email, UserDtoPassword userDtoPassword) {
        User user = userRepository.findUserByEmail(email);
        if (BCrypt.checkpw(userDtoPassword.getOldPassword(), user.getPassword())) {
            String hashedPassword = BCrypt.hashpw(userDtoPassword.getNewPassword(), BCrypt.gensalt(10));
            user.setPassword(hashedPassword);
            userRepository.save(user);
            return true;
        }
        return false;
    }


}
