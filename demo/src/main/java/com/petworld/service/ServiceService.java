package com.petworld.service;

import com.petworld.domain.Service;

import java.util.Collection;
import java.util.Optional;

public interface ServiceService {
    Service saveService(Service service);

    Collection<Service> getAllServices();

    Optional<Service> getService(Long id);

    void deleteByIdByStatus(Long id);

}
