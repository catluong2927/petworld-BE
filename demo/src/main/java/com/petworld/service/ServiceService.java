package com.petworld.service;

import com.petworld.domain.Service;
import com.petworld.dto.servicePackageDto.response.ServicePackageDtoResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.Collection;
import java.util.Optional;

public interface ServiceService {
    Service saveService(Service service);

    Collection<Service> getAllServices();

    Optional<Service> getService(Long id);

    void deleteByIdByStatus(Long id);

    Page<Service> findAll(Pageable pageable);

    void addImageToService(Long id,String urlImage);
}
