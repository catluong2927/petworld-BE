package com.petworld.service.impl;

import com.petworld.converter.CenterConverter;
import com.petworld.domain.Center;
import com.petworld.dto.centerDto.request.CenterDtoRequest;
import com.petworld.dto.centerDto.response.CenterDtoResponse;
import com.petworld.repository.CenterRepository;
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
    private final CenterRepository centerRepository;
    private final CenterConverter centerConverter;
    @Override
    public Optional<CenterDtoResponse> getById(Long id) {
        CenterDtoResponse center = centerConverter.entityToDto(centerRepository.getById(id));
        log.info("getting center from database",center.getName() );
        return Optional.of(center);
    }

    @Override
    public Optional<Page<CenterDtoResponse>> findAll(Pageable pageable) {
        Page<Center> centers = centerRepository.findAll(pageable);
        log.info("Finding all center");
        return Optional.of(centers.map(centerConverter::entityToDto));
    }

    @Override
    public Optional<CenterDtoResponse> deleteByIdByStatus(Long id) {
        log.info("deleting center from database");
        return Optional.of(centerRepository.deleteByIdCenter(id));
    }

    @Override
    public Optional<CenterDtoResponse> save(CenterDtoRequest centerDtoRequest) {
        Center center = centerConverter.dtoToEntity(centerDtoRequest);
        centerRepository.save(center);
        log.info("Saved new center to database",center.getName());
        return Optional.ofNullable(centerConverter.entityToDto(center));
    }
}
