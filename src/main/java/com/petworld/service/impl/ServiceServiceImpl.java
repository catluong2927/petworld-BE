package com.petworld.service.impl;

import com.petworld.converter.ServiceConverter;
import com.petworld.entity.Service;
import com.petworld.dto.serviceDto.request.ServiceDtoRequest;
import com.petworld.dto.serviceDto.response.ServiceDtoResponse;
import com.petworld.repository.ServiceRepository;
import com.petworld.service.ServiceService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import javax.transaction.Transactional;
import java.util.Optional;

@org.springframework.stereotype.Service
@RequiredArgsConstructor
@Transactional
@Slf4j
public class ServiceServiceImpl implements ServiceService {

    private final ServiceRepository serviceRepository;

    private final ServiceConverter serviceConverter;

    @Override
    public Service saveService(ServiceDtoRequest serviceDtoRequest) {
        log.info("Saving new service  to database",serviceDtoRequest.getName());
        return serviceRepository.save(serviceConverter.dtoToEntity(serviceDtoRequest));
    }

    @Override
    public Optional<ServiceDtoResponse> getService(Long id) {
        log.info("Getting service package by id from database");
        Service service = serviceRepository.findById(id).get();
        return Optional.ofNullable(serviceConverter.entityToDto(service));
    }

    @Override
    public void deleteByIdByStatus(Long id) {
        log.info("Removing service package ");
        serviceRepository.deleteByIdService(id);
    }

    @Override
    public Page<ServiceDtoResponse> findAll(Pageable pageable) {
      Page<Service> services = serviceRepository.findAll(pageable);
      return services.map(serviceConverter::entityToDto);
    }
    @Override
    public void addImageToService(Long id, String urlImage) {
       Service service = serviceRepository.getById(id);

       serviceRepository.save(service);
    }
}
