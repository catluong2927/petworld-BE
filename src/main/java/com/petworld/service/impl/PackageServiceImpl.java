package com.petworld.service.impl;

import com.petworld.converter.PackageConverter;
import com.petworld.entity.Package;
import com.petworld.dto.packageDto.request.PackageDtoRequest;
import com.petworld.dto.packageDto.response.PackageDtoResponse;
import com.petworld.repository.PackageRepository;
import com.petworld.service.PackageService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Transactional
@Slf4j
public class PackageServiceImpl implements PackageService {
    private final PackageRepository packageRepository;
    private final PackageConverter packageConverter;
    @Override
    public PackageDtoResponse savePackage(PackageDtoRequest packageDtoRequest) {
           log.info("Saving new service package to database {}", packageDtoRequest.getName());
           Package aPackage =  packageConverter.dtoToEntity(packageDtoRequest);
           Package savedPackage =  packageRepository.save(aPackage);
           savedPackage.setIsActive(true);
           return packageConverter.entityToDto(savedPackage);
    }

    @Override
    public void deleteByIdByStatus(Long id) {
        packageRepository.deleteByIdPackage(id);
    }

    @Override
    public Optional<PackageDtoResponse> getPackage(Long id) {
        log.info("Getting service package by id from database");
        Optional<Package> servicePackage = packageRepository.findById(id);
        if(servicePackage.isPresent()){
            PackageDtoResponse packageDtoResponse = packageConverter.entityToDto(servicePackage.get());
            return Optional.of(packageDtoResponse);
        } else {
        return Optional.empty();
        }
    }
    @Override
    public Page<PackageDtoResponse> findAll(Pageable pageable) {
        Page<Package> servicePackages = packageRepository.findAll(pageable);
        return servicePackages.map(packageConverter::entityToDto);
    }
}
