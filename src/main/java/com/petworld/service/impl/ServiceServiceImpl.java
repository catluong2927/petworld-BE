package com.petworld.service.impl;

import com.petworld.domain.Service;
import com.petworld.domain.ServiceImage;
import com.petworld.domain.ServicePackage;
import com.petworld.dto.servicePackageDto.response.ServicePackageDtoResponse;
import com.petworld.repository.ServiceImageRepo;
import com.petworld.repository.ServiceRepository;
import com.petworld.service.ServiceImageService;
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

    private final ServiceRepository serviceRepo;
    private final ServiceImageRepo serviceImageRepo;
    @Override
    public Service saveService(Service service) {
        log.info("Saving new service  to database",service.getName());
        List<ServiceImage> listImages = service.getServiceImages();
        listImages.forEach(img -> serviceImageRepo.save(img));
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

    @Override
    public Page<Service> findAll(Pageable pageable) {
      Page<Service> services = serviceRepo.findAll(pageable);
      return services;
    }
    @Override
    public void addImageToService(Long id, String urlImage) {
       Service service = serviceRepo.getById(id);
       ServiceImage serviceImage = new ServiceImage(urlImage);
       service.getServiceImages().add(serviceImage);
       serviceImageRepo.save(serviceImage);
       serviceRepo.save(service);
    }
}
