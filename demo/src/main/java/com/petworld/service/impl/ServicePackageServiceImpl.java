package com.petworld.service.impl;

import com.petworld.converter.ServicePackageConverter;

import com.petworld.domain.ServicePackage;
import com.petworld.dto.servicePackageDto.request.ServicePackageDtoRequest;
import com.petworld.dto.servicePackageDto.response.ServicePackageDtoResponse;
import com.petworld.repository.ServicePackageRepo;
import com.petworld.repository.ServiceRepository;
import com.petworld.service.ServicePackageService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Transactional
@Slf4j
public class ServicePackageServiceImpl implements ServicePackageService {
    private final ServicePackageRepo servicePackageRepo;

    private final ServiceRepository serviceRepo;
    private final ServicePackageConverter servicePackageConverter;
    @Override
    public ServicePackageDtoResponse saveServicePackage(ServicePackageDtoRequest servicePackageDtoRequest) {
        log.info("Saving new service package to database {}",servicePackageDtoRequest.getName());
       ServicePackage servicePackage =  servicePackageConverter.dtoToEntity(servicePackageDtoRequest);
       ServicePackage savedSevicePackage =  servicePackageRepo.save(servicePackage);
       return servicePackageConverter.entityToDto(savedSevicePackage);
    }

    @Override
    public List<ServicePackageDtoResponse> getAllServicePackages() {
        log.info("Getting all service package from database");
        List<ServicePackage> servicePackages = servicePackageRepo.findAll();
        List<ServicePackageDtoResponse> servicePackageDtoResponses = new ArrayList<>();
        servicePackages.stream()
                .forEach(element -> servicePackageDtoResponses.add(servicePackageConverter.entityToDto(element)));
        return servicePackageDtoResponses;
    }


    @Override
    public Optional<ServicePackageDtoResponse> getServicePackage(Long id) {
        log.info("Getting service package by id from database");
        Optional<ServicePackage> servicePackage = servicePackageRepo.findById(id);
        if(servicePackage.isPresent()){
            ServicePackageDtoResponse servicePackageDtoResponse = servicePackageConverter.entityToDto(servicePackage.get());
            return Optional.of(servicePackageDtoResponse);
        } else {
        return Optional.empty();
        }
    }


    @Override
    public void deleteByIdByStatus(Long id) {
        log.info("Removing service package ");
        servicePackageRepo.deleteByIdPackageService(id);
    }

    @Override
    public List<ServicePackageDtoResponse> getAllServicePackageByName(String name) {
        log.info("Getting all service package by name from database");
        List<ServicePackage> servicePackages = servicePackageRepo.findServicePackageByName(name);
        List<ServicePackageDtoResponse> servicePackageDtoResponses = new ArrayList<>();
        servicePackages.forEach(element -> {servicePackageDtoResponses.add(servicePackageConverter.entityToDto(element));});
        return servicePackageDtoResponses;
    }

    @Override
    public Page<ServicePackageDtoResponse> findAll(Pageable pageable) {
        Page<ServicePackage> servicePackages = servicePackageRepo.findAll(pageable);
        return servicePackages.map(servicePackageConverter::entityToDto);
    }

    @Override
    public Optional<ServicePackageDtoResponse> addServiceToServicePackage(Long id, Long serviceId) {
        Optional<ServicePackage> servicePackage = servicePackageRepo.findById(id);
        if (servicePackage.isPresent()){
            List<com.petworld.domain.Service> services = servicePackage.get().getServices();
            Optional<com.petworld.domain.Service> findingService = serviceRepo.findById(serviceId);
            if (findingService.isPresent()){
                services.add(findingService.get());
                ServicePackage editedServicePackage = servicePackageRepo.save(servicePackage.get());
                return Optional.ofNullable(servicePackageConverter.entityToDto(editedServicePackage));
            }
        }
        return Optional.empty();
    }
}
