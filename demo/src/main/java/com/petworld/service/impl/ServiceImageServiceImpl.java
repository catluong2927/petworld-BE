package com.petworld.service.impl;

import com.petworld.domain.ServiceImage;
import com.petworld.repository.ServiceImageRepo;
import com.petworld.service.ServiceImageService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
@RequiredArgsConstructor
public class ServiceImageServiceImpl implements ServiceImageService {
    private final ServiceImageRepo serviceImageRepo;
    @Override
    public ServiceImage saveServiceImage(ServiceImage serviceImage) {
        return serviceImageRepo.save(serviceImage);
    }

    @Override
    public void deleteServiceImage(Long id) {
        serviceImageRepo.deleteById(id);
    }

}
