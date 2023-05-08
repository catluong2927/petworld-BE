package com.petworld.service.impl;

import com.petworld.converter.CenterConverter;
import com.petworld.domain.Center;
import com.petworld.dto.centerDto.response.CenterDtoResponse;
import com.petworld.repository.CenterRepo;
import com.petworld.service.CenterService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.Optional;

@RequiredArgsConstructor
@Service
@Transactional
@Slf4j
public class CenterServiceImpl implements CenterService {
    private final CenterRepo centerRepo;
    private final CenterConverter centerConverter;
    @Override
    public CenterDtoResponse getById(Long id) {
        return null;
    }

    @Override
    public Page<CenterDtoResponse> findAll(Pageable pageable) {
        Page<Center> centers = centerRepo.findAll(pageable);
        return centers.map(centerConverter::entityToDto);
    }

    @Override
    public void deleteByIdByStatus(Long id) {
//        Optional<Center> center = Optional.of(centerRepo.getById(id));
//        if (center.isEmpty()) return
//        centerRepo.deleteByIdCenter(id);
//        return null;
    }
}
