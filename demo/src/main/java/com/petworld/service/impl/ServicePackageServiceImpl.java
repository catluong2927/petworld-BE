package com.petworld.service.impl;

import com.petworld.domain.ServicePackage;
import com.petworld.repository.ServicePackageRepo;
import com.petworld.service.ServicePackageService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.Collection;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Transactional
@Slf4j
public class ServicePackageServiceImpl implements ServicePackageService {
    private final ServicePackageRepo servicePackageRepo;
    @Override
    public ServicePackage saveServicePackage(ServicePackage servicePackage) {
        log.info("Saving new service package to database",servicePackage.getName());
        return servicePackageRepo.save(servicePackage);
    }

    @Override
    public Collection<ServicePackage> getAllServicePackages() {
        log.info("Getting all service package from database");
        return servicePackageRepo.findAll();
    }

    @Override
    public Optional<ServicePackage> getServicePackage(Long id) {
        log.info("Getting service package by id from database");
        return servicePackageRepo.findById(id);
    }

    @Override
    public void deleteByIdByStatus(Long id) {
        log.info("Removing service package ");
        servicePackageRepo.deleteByIdPackageService(id);
    }
}
