//package com.petworld.validation;
//
//import com.petworld.dto.userDto.request.UserDtoCreateRequest;
//import com.petworld.repository.UserRepository;
//import com.petworld.service.UserService;
//import lombok.Getter;
//import lombok.Setter;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Component;
//import org.springframework.validation.Errors;
//import org.springframework.validation.ValidationUtils;
//import org.springframework.validation.Validator;
//
//@Component
//@Getter
//@Setter
//public class UserDtoValidator implements Validator{
//
//    private final UserService userService;
//
//    public UserDtoValidator(UserService userService) {
//        this.userService = userService;
//    }
//
//    @Override
//    public boolean supports(Class<?> clazz) {
//        return UserDtoCreateRequest.class.isAssignableFrom(clazz);
//    }
//    @Override
//    public void validate(Object target, Errors errors) {
//        UserDtoCreateRequest regexValidate = (UserDtoCreateRequest) target;
//        String email = regexValidate.getEmail();
//        String username = regexValidate.getUserName();
//        ValidationUtils.rejectIfEmpty(errors, "email", "email.empty");
//        ValidationUtils.rejectIfEmpty(errors, "userName", "userName.empty");
//        if (userService.findUserByEmail(email) != null){
//            errors.rejectValue("email", "email.isExit");
//        }
//        if (userService.isExitUserName(username) != null){
//            errors.rejectValue("userName", "userName.isExit");
//        }
//
//    }
//
//
//
//}
