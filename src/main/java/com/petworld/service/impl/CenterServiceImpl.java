package com.petworld.service.impl;

import com.petworld.converter.CenterConverter;
import com.petworld.entity.Center;
import com.petworld.dto.centerDto.request.CenterDtoRequest;
import com.petworld.dto.centerDto.response.CenterDtoResponse;
import com.petworld.repository.CenterRepository;
import com.petworld.repository.UserRepository;
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
    private final UserRepository userRepository;
    @Override
    public Optional<CenterDtoResponse> getById(Long id) {
        CenterDtoResponse center = centerConverter.entityToDto(centerRepository.getById(id));
        log.info("getting center from database",center.getName() );
        return Optional.of(center);
    }

    @Override
    public Optional<Page<CenterDtoResponse>> findAllByStatus(Pageable pageable) {
        Page<Center> centers = centerRepository.findAllByIsActiveTrue(pageable);
        log.info("Finding all center status");
        return Optional.of(centers.map(centerConverter::entityToDto));
    }

    @Override
    public Optional<Page<CenterDtoResponse>> findAll(Pageable pageable) {
        Page<Center> centers = centerRepository.findAll(pageable);
        log.info("Finding all center");
        return Optional.of(centers.map(centerConverter::entityToDto));
    }


    @Override
    public void deleteByIdByStatus(Long id) {
        log.info("deleting center from database");
        centerRepository.deleteByIdCenter(id);
    }
    @Override
    public Optional<CenterDtoResponse> save(CenterDtoRequest centerDtoRequest) {
        Center center = centerConverter.dtoToEntity(centerDtoRequest);
        center.setUser(userRepository.findUserByEmail(centerDtoRequest.getUserEmail()));

        centerRepository.save(center);
        center.setIsActive(true);
        log.info("Saved new center to database",center.getName());
        return Optional.ofNullable(centerConverter.entityToDto(center));
    }

    @Override
    public Optional<CenterDtoResponse> findCenterByUserId(Long id) {
        Optional<Center> center = centerRepository.findCenterByUserId(id);
        if (center.isEmpty()) return Optional.ofNullable(null);
        return Optional.ofNullable(centerConverter.entityToDto(center.get()));
    }
}
