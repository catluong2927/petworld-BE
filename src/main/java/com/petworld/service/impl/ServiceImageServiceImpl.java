package com.petworld.service.impl;

import com.petworld.domain.ServiceImage;
import com.petworld.repository.ServiceImageRepository;
import com.petworld.service.ServiceImageService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ServiceImageServiceImpl implements ServiceImageService {
    private final ServiceImageRepository serviceImageRepository;
    @Override
    public ServiceImage saveServiceImage(ServiceImage serviceImage) {
        return serviceImageRepository.save(serviceImage);
    }

    @Override
    public void deleteServiceImage(Long id) {
        serviceImageRepository.deleteById(id);
    }

}
