package com.petworld.service.impl;

import com.petworld.domain.Service;
import com.petworld.repository.ServiceRepository;
import com.petworld.service.ServiceService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import javax.transaction.Transactional;
import java.util.Collection;
import java.util.Optional;

@org.springframework.stereotype.Service
@RequiredArgsConstructor
@Transactional
@Slf4j
public class ServiceServiceImpl implements ServiceService {

    private final ServiceRepository serviceRepo;
    @Override
    public Service saveService(Service service) {
        log.info("Saving new service  to database",service.getName());
        return serviceRepo.save(service);
    }

    @Override
    public Collection<Service> getAllServices() {
        log.info("Getting all service from database");
        return serviceRepo.findAll();
    }

    @Override
    public Optional<Service> getService(Long id) {
        log.info("Getting service package by id from database");
        return serviceRepo.findById(id);
    }

    @Override
    public void deleteByIdByStatus(Long id) {
        log.info("Removing service package ");
        serviceRepo.deleteByIdService(id);
    }
}
