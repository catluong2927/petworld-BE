package com.petworld.service.impl;

import com.petworld.converter.UserConverter;
import com.petworld.domain.User;
import com.petworld.domain.UserRole;
import com.petworld.dto.userDto.request.UserDtoRequest;
import com.petworld.dto.userDto.response.UserDtoResponse;
import com.petworld.repository.UserRoleRepo;
import com.petworld.repository.UserRepository;
import com.petworld.service.UserService;
//import org.modelmapper.ModelMapper;
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
    private final UserRoleRepo userRoleRepo;

    private final UserConverter userConverter;

    public UserServiceImpl(UserRepository userRepository, UserConverter userConverter, UserRoleRepo userRoleRepo) {
        this.userRepository = userRepository;
        this.userConverter = userConverter;
        this.userRoleRepo = userRoleRepo;
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
    public Boolean save(UserDtoRequest userDtoRequest) {
        if (userDtoRequest != null) {
            User user = userConverter.dtoToEntity(userDtoRequest);
            if (!userDtoRequest.getPassword().isEmpty()) {
                String hashedPassword = BCrypt.hashpw(userDtoRequest.getPassword(), BCrypt.gensalt(10));
                user.setPassword(hashedPassword);
                userRepository.save(user);
                userDtoRequest.getRoles().forEach(role -> {
                    UserRole userRole = new UserRole(user,role);
                    userRoleRepo.save(userRole);
                });
                return true;
            }
            return false;
        }
        return false;
    }

    @Override
    public void remove(Long id) {
        userRepository.deleteByIdUser(id);
    }

    @Override
    public List<UserDtoResponse> findAll() {
        List<User> users = userRepository.findAll();
        List<UserDtoResponse> userDtoResponses = new ArrayList<>();
        users.forEach(element -> {userDtoResponses.add(userConverter.entityToDto(element));});
        return userDtoResponses;
    }

    @Override
    public List<UserDtoResponse> getUsersByFullName(String fullName) {
        String likeFullName = "%" + fullName + "%";
        List<User> userByFullNames = userRepository.searchByFullName(likeFullName);
        List<UserDtoResponse> userDtoResponseFullNames = new ArrayList<>();
        userByFullNames.forEach(element -> {userDtoResponseFullNames.add(userConverter.entityToDto(element));});
        return userDtoResponseFullNames;
    }

    @Override
    public UserDtoResponse getUserById(Long customerId) {
        User user = userRepository.findById(customerId).orElse(null);
        return userConverter.entityToDto(user);
    }
//    @Override
//    public Boolean update(UserDtoRequest userDtoRequest) {
//        if (userDtoRequest != null) {
//            User user = userConverter.dtoToEntity(userDtoRequest);
//            if (!userDtoRequest.getPassword().isEmpty()) {
//                String hashedPassword = BCrypt.hashpw(userDtoRequest.getPassword(), BCrypt.gensalt(10));
//                user.setPassword(hashedPassword);
//                userRepository.save(user);
//                userDtoRequest.getRoles().forEach(role -> {
//                    UserRole userRole = new UserRole(user,role);
//                    userRoleRepo.save(userRole);
//                });
//                return true;
//            }
//            return false;
//        }
//        return false;
//    }
}
