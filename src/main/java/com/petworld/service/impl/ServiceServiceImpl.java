package com.petworld.service.impl;

import com.petworld.domain.Service;
import com.petworld.domain.ServiceImage;
import com.petworld.repository.ServiceImageRepository;
import com.petworld.repository.ServiceRepository;
import com.petworld.service.ServiceService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import javax.transaction.Transactional;
import java.util.Collection;
import java.util.List;
import java.util.Optional;

@org.springframework.stereotype.Service
@RequiredArgsConstructor
@Transactional
@Slf4j
public class ServiceServiceImpl implements ServiceService {

    private final ServiceRepository serviceRepository;
    private final ServiceImageRepository serviceImageRepository;
    @Override
    public Service saveService(Service service) {
        log.info("Saving new service  to database",service.getName());
        List<ServiceImage> listImages = service.getServiceImages();
        listImages.forEach(img -> serviceImageRepository.save(img));
        return serviceRepository.save(service);
    }

    @Override
    public Collection<Service> getAllServices() {
        log.info("Getting all service from database");
        return serviceRepository.findAll();
    }

    @Override
    public Optional<Service> getService(Long id) {
        log.info("Getting service package by id from database");
        return serviceRepository.findById(id);
    }

    @Override
    public void deleteByIdByStatus(Long id) {
        log.info("Removing service package ");
        serviceRepository.deleteByIdService(id);
    }

    @Override
    public Page<Service> findAll(Pageable pageable) {
      Page<Service> services = serviceRepository.findAll(pageable);
      return services;
    }
    @Override
    public void addImageToService(Long id, String urlImage) {
       Service service = serviceRepository.getById(id);
       ServiceImage serviceImage = new ServiceImage(urlImage);
       service.getServiceImages().add(serviceImage);
       serviceImageRepository.save(serviceImage);
       serviceRepository.save(service);
    }
}
