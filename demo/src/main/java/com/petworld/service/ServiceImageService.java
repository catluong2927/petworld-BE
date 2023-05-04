package com.petworld.service;

import com.petworld.domain.ServiceImage;

public interface ServiceImageService{
    ServiceImage saveServiceImage(ServiceImage serviceImage);

    void deleteServiceImage(Long id);
}
