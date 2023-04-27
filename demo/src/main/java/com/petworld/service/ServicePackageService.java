package com.petworld.service;

import com.petworld.domain.ServicePackage;

import java.util.Collection;
import java.util.Optional;

public interface ServicePackageService {
    ServicePackage saveServicePackage(ServicePackage servicePackage);

    Collection<ServicePackage> getAllServicePackages();

    Optional<ServicePackage> getServicePackage(Long id);

    void deleteByIdByStatus(Long id);
}