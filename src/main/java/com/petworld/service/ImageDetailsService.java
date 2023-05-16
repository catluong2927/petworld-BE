package com.petworld.service;

import com.petworld.dto.imageDetailsDto.ImageDetailsDto;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public interface ImageDetailsService {
    List<ImageDetailsDto> getAllImageDetails();
}
