package com.petworld.service.impl;

import com.petworld.converter.PackageConverter;
import com.petworld.domain.Package;
import com.petworld.dto.packageDto.request.PackageDtoRequest;
import com.petworld.dto.packageDto.response.PackageDtoResponse;
import com.petworld.repository.PackageRepository;
import com.petworld.repository.ServiceRepository;
import com.petworld.service.PackageService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Transactional
@Slf4j
public class PackageServiceImpl implements PackageService {
    private final PackageRepository packageRepository;
    private final ServiceRepository serviceRepository;
    private final PackageConverter packageConverter;
    @Override
    public PackageDtoResponse savePackage(PackageDtoRequest packageDtoRequest) {
           log.info("Saving new service package to database {}", packageDtoRequest.getName());
           Package aPackage =  packageConverter.dtoToEntity(packageDtoRequest);
           Package savedPackage =  packageRepository.save(aPackage);
           return packageConverter.entityToDto(savedPackage);
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
    public void deleteByIdByStatus(Long id) {
        log.info("Removing package ");
        packageRepository.deleteByIdPackage(id);
    }

    @Override
    public Page<PackageDtoResponse> getAllPackageByName(String name, Pageable pageable) {
        log.info("Getting all package by name from database");
        Page<Package> packages = packageRepository.findPackageByName(name,pageable);
        Page<PackageDtoResponse> packageDtoResponses= packages.map(packageConverter::entityToDto);
        return packageDtoResponses;
    }

    @Override
    public List<PackageDtoResponse> findByCenterId(Long id) {
        List<Package> packages =  packageRepository.getPackagesByCenterId(id);
        List<PackageDtoResponse> packageDtoResponses= packages.stream().map(packageConverter::entityToDto).collect(Collectors.toList());
        return packageDtoResponses;
    }

    @Override
    public Page<PackageDtoResponse> findAll(Pageable pageable) {
        Page<Package> servicePackages = packageRepository.findAll(pageable);
        return servicePackages.map(packageConverter::entityToDto);
    }

    @Override
    public Optional<PackageDtoResponse> addServiceToPackage(Long id, Long serviceId) {
        Optional<Package> servicePackage = packageRepository.findById(id);
        if (servicePackage.isPresent()){
            List<com.petworld.domain.Service> services = servicePackage.get().getServices();
            Optional<com.petworld.domain.Service> findingService = serviceRepository.findById(serviceId);
            if (findingService.isPresent()){
                services.add(findingService.get());
                Package editedPackage = packageRepository.save(servicePackage.get());
                return Optional.ofNullable(packageConverter.entityToDto(editedPackage));
            }
        }
        return Optional.empty();
    }
}
