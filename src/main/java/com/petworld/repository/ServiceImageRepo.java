package com.petworld.repository;

import com.petworld.domain.ServiceImage;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ServiceImageRepo extends JpaRepository<ServiceImage, Long> {
}
