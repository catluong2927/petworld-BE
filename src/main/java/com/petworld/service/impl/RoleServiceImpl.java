package com.petworld.service.impl;

import com.petworld.converter.RoleConverter;
import com.petworld.dto.roleDto.response.RoleDtoResponse;
import com.petworld.entity.Role;
import com.petworld.repository.RoleRepository;
import com.petworld.service.RoleService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;

@Service
@Transactional
@RequiredArgsConstructor
public class RoleServiceImpl implements RoleService {
    private final RoleRepository roleRepository;
    private final RoleConverter roleConverter;
    public List<RoleDtoResponse> getAllRole (){
        List<Role> roles = roleRepository.findAll();
        List<RoleDtoResponse> roleDtoResponses = roleConverter.entitiesToDtos(roles);
        return roleDtoResponses;
    }
}
